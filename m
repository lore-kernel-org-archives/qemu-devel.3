Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBFFC52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 18:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc7oN-000164-P3; Thu, 08 Aug 2024 14:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sc7oE-00011W-7L; Thu, 08 Aug 2024 14:24:22 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sc7oB-0000V7-9D; Thu, 08 Aug 2024 14:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723141459; x=1754677459;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9WGk2g9ueOb3XS6SzlBS4Xi5lve+x+4tueFWE/t1/uU=;
 b=d2KEoM1pe3eiiJr8mOJs2aJIprpoXB/U0jFJV+oIiebXoB/ar6ePF39a
 eOGek2qzQfiVDOoW3EnCBMTx4ivEh4JHnI3OlwVF6adwK+ifJvR7Lb3mh
 yDydGHy8US4NAqhB9jdY582gd81bSTaS/Vu2QcSIbeAxfFHq/pmcvxMXS o=;
X-CSE-ConnectionGUID: ajj1a1WKShmWTdcWdv1sGw==
X-CSE-MsgGUID: tF43heZBQ8W/s/e5h4+heQ==
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 11:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoCmjBKVEGIg/mjQ3sBP20qiQVrIq3sp6qe1p5+zLsf7sEGRVzSAeAo+HwtHdnPInBNWj/1n0H81mXPrkX8AbXgbH5TwmimdxcNLCP+eCUd3hH7q2rJlVCPnxxHGGdZAqrJoMzRCz7U6gkpqNBLpVbHxbywnq0Eo9y659dGGyCPlQlt6yMe2LUxA38DtuWVFMGFH4syW/iZv/k5Q+osFN4tjiEYSE4qoCdqlUCV4l2XuEWYf6lM+RWtt8ms96XerhXeYH4xob6Tsc7SH6JDVuDy1FUQiw+3S9TdhZdAek/PvEPQQFRM+tCGKmt6T+uDJvi5xrm8PH0OKYdE4blomOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WGk2g9ueOb3XS6SzlBS4Xi5lve+x+4tueFWE/t1/uU=;
 b=E/7XnHWgE7ju2DoKxsvSS8uSgoGBXivHJ8QvLETN08Y8v4at1JOukSmjkAkRasrX/q9epfmElnjg/K7IYhrIbNfNeVnO+dMfifAaZ2SsL8/1DzRFdiP8BchzQQ7WNj+odb+uBfeS4qcuPyp8ZsVQSLbAgp6CqmIu6Hmu+SZ801qPSI9LmZjBL0veq1IFJIjUWURQkR2pm/FFNPSrRamS4fFix9NhyLZN7hpLJYHae/XQHita130UsFtb4uWMAlMESW/vqEHZa0jM+XEL2gi+p2spCh9i4abqSe5pKycfrlr3Sg5EdKU5vd40M4cOygPG/nU6XeThQ5Xk3y2r5JpHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WGk2g9ueOb3XS6SzlBS4Xi5lve+x+4tueFWE/t1/uU=;
 b=b1+x7AQaW5BhFrucuGNuf/+CnDGVR97UKI8edsPeFtoY4pWrysNT3XYfYq0o5BuQzlLRw3sXyf9anVrOEAxoJwyk+U0GMfGgTlm1PE9p+H3rK5zjexaGCNAAnOJvVQbnNXYIpXKlHMBUGTK9FFcHvOzray1DlokZJpyl6LuDSMs=
Received: from LV8PR20MB6853.namprd20.prod.outlook.com (2603:10b6:408:203::21)
 by BY1PR20MB7330.namprd20.prod.outlook.com (2603:10b6:a03:4a4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 8 Aug
 2024 18:24:10 +0000
Received: from LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad]) by LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:24:10 +0000
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Kris Conklin
 <kris.conklin@seagate.com>, Jonathan Henze <jonathan.henze@seagate.com>, Evan
 Burgess <evan.burgess@seagate.com>, "clg@kaod.org" <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 03/15] crypto/hash-gcrypt: Implement new hash API
Thread-Topic: [PATCH v4 03/15] crypto/hash-gcrypt: Implement new hash API
Thread-Index: AQHa6QODMzqINF9f+U22mxnzuZrJzrIdmFCAgAAUzyA=
Date: Thu, 8 Aug 2024 18:24:10 +0000
Message-ID: <LV8PR20MB6853CD119297E25B2218EC9FEFB92@LV8PR20MB6853.namprd20.prod.outlook.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-4-alejandro.zeise@seagate.com>
 <ZrT62R_5HaQQxDqP@redhat.com>
In-Reply-To: <ZrT62R_5HaQQxDqP@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ActionId=fe7c034a-06cf-432b-8f1d-5033d1e43d75;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=true;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2024-08-08T18:22:58Z;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR20MB6853:EE_|BY1PR20MB7330:EE_
x-ms-office365-filtering-correlation-id: bf1f4575-d60b-42b4-c44d-08dcb7d74c2e
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SE5NNzg1SjFNOW1ibDU2c21mMk5vejI4Y0RjcFFDT2N5MUxJOGZnemZFQ3lt?=
 =?utf-8?B?bWx4S3A2SnRDa3BqcUN5WjRPY2kvQ3QyTEx3Z3FldThUczFmTnQvZksra1Nz?=
 =?utf-8?B?Y21XeE4xRTBEUXpEc0sybUR6aEdqTEN1TlpHNDlTMit3QUhqeEdkbGM5SHow?=
 =?utf-8?B?NDFDNitYaFRUM0dsSk4rUDl5ZGdEcnZhTklJaG9MVmtjUzRMUHR2bkhIKzBv?=
 =?utf-8?B?SEUyT2xhUE5IcHpYVlRnRXhoLzJmbEE5dEVWVkRmWlVsMGUzL3lxT1N6b0VI?=
 =?utf-8?B?dlRSQnpzUmRJQzZPbyt1eTNSbXVlU0FUS04zeVFrYmJpdU9GTmJqam1CM1R4?=
 =?utf-8?B?S3IzSXdiMnNrb1hoZTVEZE5XNEZLdXVOSDFoeGJoaExnL1Q4anU2cUROSmcx?=
 =?utf-8?B?RzFGNjZOVGlVTWFLb3ZsaTBsQ3RUL2tyT1hSZm9qQ0gvaTM2OFpJVXJZamRz?=
 =?utf-8?B?VitiVUhkWkxHV0NmeDI3MmRXWGFkYk1RVVU4L0VGbnZSSHNsc1hGTDhXSlAw?=
 =?utf-8?B?YXM1UC92YndQZFhiQTIvTGlGdTRXaGpqREFmV3pGeUk4VlZCVjZwdUxMcEdP?=
 =?utf-8?B?d080b0RySlA4bnhsZTU4QTMvcGFGUDhpdlBlOGJxd09TMVZjZEV0dnhtaUdm?=
 =?utf-8?B?Y3VYUHp0RHJSVEdLL3lPODZaNysya3FLT0p1cG9UZmFidFFhN09abDF6cTQ3?=
 =?utf-8?B?SWUvbWtCTVFYcngwWFpOWmNJNldjdXRrcUI4dVlrNVpNeUJ5T3FvOVFQVUh2?=
 =?utf-8?B?YW9vQVpoQUZocHZXbzFhTWtDYVlZT2lZL0MvVThycUZXQ3R2Q3VOR1IxcDVL?=
 =?utf-8?B?MnREUEtFYzNZSWZ3UkV1Y2V0b21xQkFGWjhhQ3o0dHhSQ0ZXOXQ1ZFN1RzZo?=
 =?utf-8?B?aElkKzFSQWZpWlhJT2lkT2JpOWF5b0luTGY1eDMwalJPWjY5RGxEVUdxR0Y1?=
 =?utf-8?B?Y1lmcnR2OUlkMlFJRjFKelRGbXYrTmhCUDltU3hPbFRoWEwwMUlkekFtMklo?=
 =?utf-8?B?OGE0cUV2VVZDQjVpZHNwaENjc1pnbkJGTGM1Yk5PWmFZaTFnWEgyZ0U0QU5u?=
 =?utf-8?B?V1U2Y2ZER3V5L3FPQ1lTTDhyZWRKeUVuSzVJZU1xaUd3cTVMSHZqaXlQQ1NZ?=
 =?utf-8?B?UDlQVllQaERRQ3dTdm90aDlxME5VNkp2clEyT0ZQdThvcTNGQU1uMlNpQ1N6?=
 =?utf-8?B?WVFaR0EvelBqTEtFRk5QZy85NzRYaFZtMzJVUkhyc2tJT0ZJOG1EeGZNY2tk?=
 =?utf-8?B?THJlM3g2SW43eUlhV2h3MitqSVhUajdhcWM2M0VxeUNkaWNORnZsUWZ5b2lJ?=
 =?utf-8?B?Q1dUdXN6R01wT1lsaWRmT1Y0NlBNQTZuTkJSNVlSYTRla00yUUZJWEQ0eDNT?=
 =?utf-8?B?YmZUZHE5clVxZmpGWVpETDE0UjFKK0x6cExQVko3WjBmeWF0SnRLcTl3RXIr?=
 =?utf-8?B?WVRRRzNWZDBlZXZxUjVXZk1oS0U2K054bHM1Zk9zSUIrVmVRUkIvWmpscHdK?=
 =?utf-8?B?N0NQN1JjZHZ0WVF4YklaYTJNQzcyOCtRVjFqS3ZaRTVFMU91K0ROUUhNRDg1?=
 =?utf-8?B?MnVGUk1RenZHejlCaENiK1NvVk5WR2dObm50MjFMdTJ4TElHc2JwRGNoc3Bq?=
 =?utf-8?B?cE5JenpHa0J3TFpKdTFHSkNtb0VHclVXL3Btc1VwZnp3dGVrbzVCTVV0QVNr?=
 =?utf-8?B?b21XaTlEdWVtbEFnZXlYRUpidHQ0QVQvcWt2UDRHdzVScUM0aHlvNXdNajkr?=
 =?utf-8?B?QUpHVVdkZFZOS0FncmlRY1JGcEpBdDdSUXJqVXJDT2JaOXB4TmJSU1o4azVr?=
 =?utf-8?B?SksyazVsYUtGVUx6TVhvUDl3b0tsZmN5MUVKdWp3QnRBVUswbXdoM2lRZlVz?=
 =?utf-8?B?Z3k3b2NpNW1Tc2NaV0hSeThERUJMVm1YaVJVSmx5Lzlxbnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR20MB6853.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjhPTVJURjJXTmYvc1poNUhJVStiT0dYelJWT3Yzck9KOEtwZG9yRDRIanRt?=
 =?utf-8?B?MUwxSVN3UFdJZzR5eFU0RlhFNjNKNnRtQ0l4UUJGT0F2Y0hTelBaZ3RycnNj?=
 =?utf-8?B?am1tWDFJZ29HUDJ5cjc4VzFTN1lMRUdQaGM2c2lJQWFHckxUYk1BNEpJSDdm?=
 =?utf-8?B?dUgwL2NNVEsvLzRhUkxzVGV1Rk9yWEF0RzhFOFZJNldmR0s1cSsyUFZHbVVu?=
 =?utf-8?B?M1NaK0czaDlueUtoWFM5L3B0U0pSUkdhUmFYcFJRVncza2pYd1Vabko1MzYw?=
 =?utf-8?B?VkZPR2VYVWV3MnU2RXoyNjFZZjNrY1NudUlwVjFiM2NUMEo5S2FTYTRrNkg3?=
 =?utf-8?B?Q0dEeFJidmJ4aU12OEx5RVhMa1FQWHY3aFl3SytJRndxNTRvYjFHZ3o1VmVB?=
 =?utf-8?B?NGdLMDhDVGxnMUVrQmJWQ0IxRzEvTjFOcjNPL1A3MTRiWFFhRHJzZ2wwYkN5?=
 =?utf-8?B?VmxJd0pwQndrV3NySTlWMUplQWxpOG41V2pxY3BrdTRpTWVsQ1dPTEZVd0Ry?=
 =?utf-8?B?VVRobUpxbHh3NjNhRCtRUDZwQjJpMUErakl0b2VWNC9TOTB0S0MvQVNHc0Zq?=
 =?utf-8?B?eDUwNThXVDFXZmlpRk85d3RtaE4wVllkNktMcW5iTTlvRU1oZE9Ic29tcHZv?=
 =?utf-8?B?emJ6VW5FN0RJODJhR2hNNlZQRXVIVllWS1hSbEd2ZVhZbktTNGVJUHJVV3lF?=
 =?utf-8?B?WFB5NTN1TkVxaHhvU3p5MEU2bHovYUljditqWUV0ZnIwdUZtS0k5TWJiK2JB?=
 =?utf-8?B?VjdHNGIwRWl0TWd5UlR5QmsvRWVGWE56TjF4WDRBa2VPRmxLc3JObHMrZWNn?=
 =?utf-8?B?Smg0SWMwQXJkRDdaeG1pOVRES2lNN1l3RDl3aWFYZWR2Qk5WQWJCMmhxQlVx?=
 =?utf-8?B?cXZvdXI0Rm5QcWh4UjNkeFMvVWNHSlpiU0xuYThrajVKUlc5emFiTWk5WDRv?=
 =?utf-8?B?WThHbDVzbTErQUFFcmVVZk0vQ1RDVDdVV0RHS1NMdlRxSW96VTJ3MkpCVVQw?=
 =?utf-8?B?cmRKNTNHVmJVQXZON3Nrb1JPa0c5RTJuckM0ekJlQmZEbkRoRWdSQmxWenJq?=
 =?utf-8?B?dkZFZlcwam1leUtvUTFqLzdyTDNwQ3NuV0F1VDZXNk9TSnJUMWR1U0E1Nk03?=
 =?utf-8?B?QnRCNFRBZi9jQjN3aElyY25Ec1NIN2lUMEFNeHd3Qk1NSDlxSlZwaDhpbzNl?=
 =?utf-8?B?c1F5TGoyZFpXL2JWejBSY2c4Vm44cWJ5dGFOYmNUWnBoR290UkJEMUMxRHpG?=
 =?utf-8?B?ckZFZHZzSUFTYzhSdExaOTN3K291U3VteTZQOXdBS1JYczdCWUl4VTV1RjNT?=
 =?utf-8?B?dldxdTdWbkdCMDUzY1hySXhOMDEweEwyT21MUDNMVGRnaHRMOTJlS1NCSzIz?=
 =?utf-8?B?c2l4T1RYeU02MlFVR0ptNm40NkFRZjdFcGJxZENUSkcwK1VkU0lndVlZRUlj?=
 =?utf-8?B?WmxKVjhoNk4zbURiREppM05kMmNjVVNhVnZHQ0NjNjNCYkpNa0Z6T2Roemgw?=
 =?utf-8?B?TlhSMFNUNDR2MDE5ZWM5eU5JOGRZTlo0NkdneVp0Um40SlVsd2RMOENYRi9D?=
 =?utf-8?B?cnRTU01TYk5RSWxqUG5Rc3c1djFtckNFWGovRFFiM0xEd0E4WEZTQ3FqbVlY?=
 =?utf-8?B?QlQzaDZYbkZBS2paTHdyZVJ6NVV2VnVvdWtNc3QxcGpEdjdwdzk3L1R5aExH?=
 =?utf-8?B?NXpHN2ZvUjBQTkNEZVZuRzFjVTFOZTBnVUkzY0FLVDNxcXRnWkxQODI4dnBS?=
 =?utf-8?B?ZGZQSDk3UjRHQjVnUkZrZXpqejFrOVp5K2dBT2VNUGhVSWNCeHcwdkVMRmpy?=
 =?utf-8?B?RCsrWVFsWTJDdTZWcVFXUVJ2Q1luZnJlUjgrRHJKN3lMOHI1QjZsNHdvblA0?=
 =?utf-8?B?b2xNTm43OTRXK2lkWjVZaXdzQ2tPbE1OOG42LzN6YXN5VUlIejZjQnlTVFE3?=
 =?utf-8?B?bWNKMkowdzVBUzlqa3g4Wlg1UTRSR1B0YU0xK2JUL0hRVGVxT1ZNa0lyekds?=
 =?utf-8?B?cEdUSDVZQVpnMU5yRWhVTEZTazB4b00wWTkxSHZnK0ppYXplZHQra3F3VGRP?=
 =?utf-8?B?STBxU00rc3lQMFh6Qnk5THluSXVFbVlBbnpYazFrMHMvUEI0bFlmZjl0L01a?=
 =?utf-8?B?cFdFWTZxRVkrOGU1cndLUXlJNzFTOHl5VmxmMGVlRlVEdk9CNFpwVk1tSm55?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L9RgbvKUL4R24Mqt8TtzUzcZzl4fz1txnNXRHheHU8FEQxLfqCk+PNgShri3EaidOxwrQutjrJwKgqFH1URFZONup0tpDjKSmOvFp2VPkvbqSElA8DTQxE4nJxDYGpNzwQPRdu8yPmCnSAJiTaQtt+ENcV5mGK4M5PRWJkGPf9EJZmqKihOVSFAHwv8707Su2sPK/P85+Ka3lguIbWbGkXpZUjloW3v7hK+4xakYyDNumyIfOXxnLEBW2XZtLeCjg5HpSzJ3QPhaJVPV416fyZNsA1Fnbhn3qtqcHCLfBhO612mZMi7Z/UuePTKZhc2wUcYkMkX6IYN+tf25P+OUEMvuLTf6gXTF1NVLb/2P/oXndDIa8esOFNLeZuB+r6YSOTBxej5LzPLnoBNz6gcJDGvTbMeCn7VdsHCnq+nvHsKRumwnMqeD51Z81gwd48Ztyx48uzar9AXZI5dur430acB3DX/VpGEq5yx4ulUWGl2aJphr2SLPNai/MurIP+iXaBcKL+p/3TDE8n0f/zM3G8QOVCKxVueDrZuTc8i0YIX/Y8VBkylYR+wggOhMN1RhKKqTLo0Bx8dLWYhkqa5hmb+1kcabpaBobiOC3NydhKqtKO8xUx/HHReaAKFsrdBO
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR20MB6853.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1f4575-d60b-42b4-c44d-08dcb7d74c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 18:24:10.3608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3M3VzmHOLqQnIqSkZber1TRCAzKVW16v1t7H0915YInSPYXzUnOGIskwxxRMaYJQjPDxn2ITF/JS5yaA5+w4EKk/RepI/S5lSplWsydPQSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7330
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

PiBPbiBXZWQsIEF1ZyAwNywgMjAyNCBhdCAwNzo1MToxMFBNICswMDAwLCBBbGVqYW5kcm8gWmVp
c2Ugd3JvdGU6DQo+ID4gSW1wbGVtZW50cyB0aGUgbmV3IGhhc2hpbmcgQVBJIGluIHRoZSBnY3J5
cHQgaGFzaCBkcml2ZXIuDQo+ID4gU3VwcG9ydHMgY3JlYXRpbmcvZGVzdHJveWluZyBhIGNvbnRl
eHQsIHVwZGF0aW5nIHRoZSBjb250ZXh0IHdpdGggDQo+ID4gaW5wdXQgZGF0YSBhbmQgb2J0YWlu
aW5nIGFuIG91dHB1dCBoYXNoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxlamFuZHJvIFpl
aXNlIDxhbGVqYW5kcm8uemVpc2VAc2VhZ2F0ZS5jb20+DQo+ID4gLS0tDQo+ID4gIGNyeXB0by9o
YXNoLWdjcnlwdC5jIHwgNzkgDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9jcnlwdG8vaGFzaC1nY3J5cHQuYyBiL2NyeXB0by9oYXNoLWdjcnlw
dC5jIGluZGV4IA0KPiA+IDgyOWU0ODI1OGQuLmUwNTUxMWNhZmEgMTAwNjQ0DQo+ID4gLS0tIGEv
Y3J5cHRvL2hhc2gtZ2NyeXB0LmMNCj4gPiArKysgYi9jcnlwdG8vaGFzaC1nY3J5cHQuYw0KPiA+
IEBAIC0xLDYgKzEsNyBAQA0KPiA+ICAvKg0KPiA+ICAgKiBRRU1VIENyeXB0byBoYXNoIGFsZ29y
aXRobXMNCj4gPiAgICoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDI0IFNlYWdhdGUgVGVjaG5v
bG9neSBMTEMgYW5kL29yIGl0cyBBZmZpbGlhdGVzDQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAx
NiBSZWQgSGF0LCBJbmMuDQo+ID4gICAqDQo+ID4gICAqIFRoaXMgbGlicmFyeSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgQEAgDQo+ID4gLTExMCw3ICsx
MTEsODUgQEAgcWNyeXB0b19nY3J5cHRfaGFzaF9ieXRlc3YoUUNyeXB0b0hhc2hBbGdvcml0aG0g
YWxnLA0KPiA+ICAgICAgcmV0dXJuIC0xOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljDQo+ID4g
K1FDcnlwdG9IYXNoICpxY3J5cHRvX2djcnlwdF9oYXNoX25ldyhRQ3J5cHRvSGFzaEFsZ29yaXRo
bSBhbGcsIEVycm9yIA0KPiA+ICsqKmVycnApIHsNCj4gPiArICAgIFFDcnlwdG9IYXNoICpoYXNo
ID0gTlVMTDsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXFjcnlwdG9faGFzaF9zdXBwb3J0cyhhbGcp
KSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgIlVua25vd24gaGFzaCBhbGdvcml0aG0gJWQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
YWxnKTsNCj4gPiArICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgaGFzaCA9IGdfbmV3KFFDcnlw
dG9IYXNoLCAxKTsNCj4gPiArICAgICAgICBoYXNoLT5hbGcgPSBhbGc7DQo+ID4gKyAgICAgICAg
aGFzaC0+b3BhcXVlID0gZ19uZXcoZ2NyeV9tZF9oZF90LCAxKTsNCj4gPiArDQo+ID4gKyAgICAg
ICAgZ2NyeV9tZF9vcGVuKChnY3J5X21kX2hkX3QgKikgaGFzaC0+b3BhcXVlLCBxY3J5cHRvX2hh
c2hfYWxnX21hcFthbGddLCAwKTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICByZXR1cm4g
aGFzaDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljDQo+ID4gK3ZvaWQgcWNyeXB0b19nY3J5
cHRfaGFzaF9mcmVlKFFDcnlwdG9IYXNoICpoYXNoKSB7DQo+ID4gKyAgICBnY3J5X21kX2hkX3Qg
KmN0eCA9IGhhc2gtPm9wYXF1ZTsNCj4gPiArDQo+ID4gKyAgICBpZiAoY3R4KSB7DQo+ID4gKyAg
ICAgICAgZ2NyeV9tZF9jbG9zZSgqY3R4KTsNCj4gPiArICAgICAgICBnX2ZyZWUoY3R4KTsNCj4g
PiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBnX2ZyZWUoaGFzaCk7DQo+ID4gK30NCj4gPiArDQo+
ID4gKw0KPiA+ICtzdGF0aWMNCj4gPiAraW50IHFjcnlwdG9fZ2NyeXB0X2hhc2hfdXBkYXRlKFFD
cnlwdG9IYXNoICpoYXNoLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3Qgc3RydWN0IGlvdmVjICppb3YsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzaXplX3QgbmlvdiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkgew0KPiA+ICsgICAgZ2NyeV9tZF9oZF90ICpjdHggPSBoYXNoLT5vcGFxdWU7DQo+
ID4gKw0KPiA+ICsgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBuaW92OyBpKyspIHsNCj4gPiArICAg
ICAgICBnY3J5X21kX3dyaXRlKCpjdHgsIGlvdltpXS5pb3ZfYmFzZSwgaW92W2ldLmlvdl9sZW4p
Ow0KPg0KPiAgIGludCByZXQgPSBnY3J5X21kX3dyaXRlKCpjdHgsIGlvdltpXS5pb3ZfYmFzZSwg
aW92W2ldLmlvdl9sZW4pOw0KPiAgIGlmIChyZXQgIT0gMCkgew0KPiAgICAgICBlcnJvcl9zZXRn
KC4uLi4pDQo+ICAgICAgIHJldHVybiAtMTsNCj4gICB9DQo+DQo+DQo+IFdpdGggcmVnYXJkcywN
Cj4gRGFuaWVsDQoNCmdjcnlfbWRfd3JpdGUoKSBpcyBkZWNsYXJlZCBhcyB2b2lkIHdoaWNoIGlz
IHdoeSBJIGhhZCBubyBlcnJvciB2YXJpYWJsZSBwcmVzZW50Lg0KDQpUaGFua3MsDQpBbGVqYW5k
cm8NCg0K

