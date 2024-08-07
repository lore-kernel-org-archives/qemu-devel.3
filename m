Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1A6C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnIm-0003bq-I4; Wed, 07 Aug 2024 16:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbnIk-0003RD-8j; Wed, 07 Aug 2024 16:30:30 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbnIa-0007Eu-Nh; Wed, 07 Aug 2024 16:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723062620; x=1754598620;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uJ3tKwN3f7uLY/99bA8gHG0HaJzExwQrQfreGsD9xdk=;
 b=YJBWoKVckSElatLE1DOLkzLmpG+/EePWC+usiSg/70KXKQZVSMEjIdwg
 6Z2xZKJMUVcS5Iv6kPeeWTalZENQT/Ku+UB1Xjk8sKfb5sZJtnWTkMzOL
 UyamNGAR/ULO4vh/C0nfQRXP8mOCrO+AUg4Kv7oErZRiMS3NGtmAo5fJu Y=;
X-CSE-ConnectionGUID: 4DcKzj9TSdyfyEmcDvwRcQ==
X-CSE-MsgGUID: CBHTR4OORPysHMQCLDCyuQ==
Received: from mail-mw2nam10lp2046.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.46])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 13:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzK5/yK5y1DCR1cM9LYv2BF5FvRrtSfVq5ieo7ekzloCYw2GKGzDu60kWnCpiQXKkUKZGKeOWsWflabuJiqyqaSOqkxYJw6NWVk5iDfup2ww/SBRK2k7lo+31/CR4Dyzct1U5ApIOP2unb8koi8Hhs4p43N+/sG1lFi38qWbSsf5129EI64exl8OliV1LsraFsNBPRBzfJOHhfL7PaU1Iaf218gTHaRowKBIOiIGcAnIXzxI/39npXtT/7EX2fXC43oYdweIB39TtdX8ogbe5RtX3AlhIaVbbrH5fQSNBrrrdktNaNyeJv/5c8AB5icAToN964/yT55VCFeUlWiXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ3tKwN3f7uLY/99bA8gHG0HaJzExwQrQfreGsD9xdk=;
 b=MttgVFA9fol/E6ddhI82pim9ta2XX0RPFGGbxsPXBN/JsAUuJtOrXz7Zamdy+N3X/V40Tp0DkmC8OFtrg6P21uTVkQW5j4HtNeqtEIcNRgXWhBqahv78SG0LAHEH1kT86JTTCZX2KPQ+YEUPobiXWoUYFV+eg0ipr5jfGsaH7Kh2W6uAlv/ypAJWc4EhFReSfRAP6eNZbSH31qWQcePiaFTYBmSmrh3dv6YmA+Yc7jXkM0p7wGG3H9nI+kyRzizucu76A7XWjIT6j8Ojb5PQ77tfBLxYdbh7D1mKnBlFY5GqupBe599UJDLUNMGEN+W21PjV5rcMITBioWwTVD2ElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ3tKwN3f7uLY/99bA8gHG0HaJzExwQrQfreGsD9xdk=;
 b=QHesJn1BlxJh6zsCNbxV7RWYQVl5BO+eqGVpN76NvnJSQr2TavsyR5IRYYfUyBRyg5KXIuFME2C7tbKLm7qM0gHHzTGEuBmiUKWmBhtJ/EvSYEaBDepwNQ9/6ezxaB1mtrE6uMqX/8/vhBAjNm3suiB7bYZgpoYoh05pThpPNgg=
Received: from LV8PR20MB6853.namprd20.prod.outlook.com (2603:10b6:408:203::21)
 by IA1PR20MB5645.namprd20.prod.outlook.com (2603:10b6:208:42e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 20:30:12 +0000
Received: from LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad]) by LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 20:30:12 +0000
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Kris Conklin <kris.conklin@seagate.com>, Jonathan Henze
 <jonathan.henze@seagate.com>, Evan Burgess <evan.burgess@seagate.com>,
 "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 00/15] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Thread-Topic: [PATCH v4 00/15] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Thread-Index: AQHa6QN/2JH+SSXwn0igT5XFC8XuRbIcNzQAgAAGR1A=
Date: Wed, 7 Aug 2024 20:30:12 +0000
Message-ID: <LV8PR20MB68533478BDF10543913B5DABEFB82@LV8PR20MB6853.namprd20.prod.outlook.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <ad028c76-dd83-4795-85a4-cbd6b528a9b5@linaro.org>
In-Reply-To: <ad028c76-dd83-4795-85a4-cbd6b528a9b5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ActionId=18deb042-69ec-4399-aab4-33db1c1a9652;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_ContentBits=0;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Enabled=true;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Method=Privileged;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_Name=Public;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SetDate=2024-08-07T20:24:10Z;
 MSIP_Label_10398c1c-5e94-454c-bbc4-eb8a4a50b8b0_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR20MB6853:EE_|IA1PR20MB5645:EE_
x-ms-office365-filtering-correlation-id: 5be20017-8621-467a-33a5-08dcb71fbcef
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHI0RTgrTUZMU0lCOCtqWWhRenM3aDU0KzZBZ1dOdUJ0blRDVFpaY1c0Z3c0?=
 =?utf-8?B?QUQ0TVFhYy9QWXQrWXByZTQzckVSOGVyT2pLNVdINFJLU3lDY0xFM05RMzMv?=
 =?utf-8?B?UWRoY2Z4cnkyTnQ4RjNmYXg1VXA2QldyVEVKQTJ5MjJReHV4bWRLcFFCdTBG?=
 =?utf-8?B?L3BVU1Z6L3pqTTAvUit0RzZsRGp5T0w4REJDQmljOHpRVXYxMXo0VEozMWln?=
 =?utf-8?B?UWlkMEVFMS9uRVMzSmFVTEhmMmJmdFFnYzJKMWxaMjg2Z2ZEMk04cmFOSENH?=
 =?utf-8?B?VDdIUXBUb2Q0REwzTTJLbjRlT3g3R25kRzZVaFVSdkZCbWZ6TFFqYW4wR2dr?=
 =?utf-8?B?Z250U0lOZ09EN05HVzNrMmFmNnZEYnFyWlNBVEprdTc0a25NYmxaVEVIMkx2?=
 =?utf-8?B?eW5panlEQWtYRWFpZUY1bnN4WHNxQVhoZzFUUDl2OWI3Z2xrYTNWaU42T3Yw?=
 =?utf-8?B?R2JUMXJ0bitENXl0VElwU0MrMXdmTy9OckpNRHJEL1pIbGxHOVA5dUtXTVFC?=
 =?utf-8?B?RWc0Q0RPZFhDKy9uM0hUanFmU2VRbHBVK2JFaEVHdFR2UWZOLzJuT251dEF4?=
 =?utf-8?B?SCtRREFFeDlIVWRTcmdOaE5pdFY2YXBkM0hUdDdENXF0YTlKaWRnK0tTNGZy?=
 =?utf-8?B?dGhWZ3FtQUxwbllaNVpFaXFRNmpUdXRYN0dCY3Q0bGxxY25PZWU2OW1qaVc5?=
 =?utf-8?B?YUpubVdwa3R3aXRhY2R6MTJLa2YxOEpCV2dER2g5azlhWTgxeiswSTV4RzF5?=
 =?utf-8?B?TEZBY0tKeEl5Tnhlczh3OEt1TG8xSE1jc3JqTWxFNmpkQ2pHMlNPZndKaFBK?=
 =?utf-8?B?eGthTXVKbFNxV2NxdXY1bW5iSk4yZU1NdzhYZnhxaVc3c2FkNGhyUkp6K29w?=
 =?utf-8?B?TFdDYTYrVGl3R0E3ZXdWK2ZwWXRKUUdYMjdBNXdIZW4yeWY1MFVSSUozakpt?=
 =?utf-8?B?VXFQN0YxR1RIOGpTdW50bmlyWnNwc0pDRkRqNHhhZ21jelZXN2ZOdSt6M1lP?=
 =?utf-8?B?Vis3K0FUcFJsZ3lKS0hUdTdxZHFITWMvMXZKcFpIVFF5N28waVU2ZU5HZ1JT?=
 =?utf-8?B?YUZ6NHFuTnFzck9LeVZoR0dJY0lBT2tRTjN6LzRycEFNM0o5VkFESW0xMFNa?=
 =?utf-8?B?NEkzSWg1L29tSFlTeXJnQzAzOVBCQUdNdXVtR0tBTThvei85WXcvSnNhaHJn?=
 =?utf-8?B?VEhFbnZwb1NGMWtSbktEYWRWUUNXTlJQVHFXWlhaUGJjZHltTkFjeGtsNmZE?=
 =?utf-8?B?RG0yM3daTVovSnRxTmVqTllMTWY1K2NmYlRiZ29qdnpPOFFaR3hNRllHZ2ZS?=
 =?utf-8?B?TmdoNytNN09ObVZtSE5WVklpclZjN2NpQnZlMGFkOFNNb2s4Q1krbVdzc2t0?=
 =?utf-8?B?Rlc1NzJOQlVBNG1MK255Q0diNmsxbGZibW1DNzNVaUVoM0dkK2IvYkV5WGkz?=
 =?utf-8?B?WmgzZkpUNVJnOFBnNnh2cDN3eFlVdm1aZEVLODBaZE9HandvVVkya0F4bEZQ?=
 =?utf-8?B?dmJINDlQRkd1dXBQcndITElZRG1NSDV4RXM2aU5ub05zejFjbGEyQTgrVEtG?=
 =?utf-8?B?NXdYdy8vUVk1SnNYbG15MHdBOFN5aWluREFZUk1WNXpPQStJNDFySTkvdERV?=
 =?utf-8?B?VFhweGZwWC9BRHJ4dWYzcXRRV1BLeEVkUEk4TTVXcVlKNEU3U3FQR3dYclQ5?=
 =?utf-8?B?bXRnNzRqV2JNYS9DdFExYmQrYXVWLzRSV0pQQjBhOG1mNnQ5c0YvTmxYa2Zz?=
 =?utf-8?B?dGUydk5Eb2pwd2VEOTFwZUJLNDQwYXFpMGpnMlY0bEJraEpuM0NDeDc2TVQ1?=
 =?utf-8?B?aitmUmx5SDlyOFZVWkR0WTlvWFcxUHVjWEE0OGZWOTh2UFp4RlQrdVI4UURY?=
 =?utf-8?B?d0NIdXJ0bVRtWlMvUkJZNXRaa3VzRlZwb2V6d1RPbUJDS3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR20MB6853.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGpKa1kyeDJrcDZvaExiR0VZU21MWHh1N0hnOS9BeExJeHROWlhkY2E3RkJk?=
 =?utf-8?B?VCtoNjlvWjQ0anNOU3lkaFhSQytLOUlkQUcwbGJ5d0FONE50ZFpJT3AzRHFE?=
 =?utf-8?B?TE5HQUU5TXFlbFE2YUZGeGpZdkxydFRVUTYrbU1FYVRhak42WUNuM2c1bXU1?=
 =?utf-8?B?M20vNkNIb3kwRHhYT25rUnVNYk9CZWFkdk04Z2NCakgyN2pNaHY5NjBzaEc3?=
 =?utf-8?B?ZzJhRXhuV281SHZqTFE0WldOWEoxRVV4LzdaVmtraFMydklacEdWZXBsN2VR?=
 =?utf-8?B?bHdRNDVKZkVTY00wY3FGdVV3Q2ZMcjBlQmFjZEZhTmFtZ2o4eDEzSUtkK1Np?=
 =?utf-8?B?MFRLSEZRdERYNXZ6RlZmcGgyZVIxNzNaTVRoK09IeEg3UTI3REZheXJxdHhu?=
 =?utf-8?B?YXJDU29TamJtU2k1S0hjUmRPeFZpODk3bEp4dk1jSXBRaUxZZVIvbys4VzFB?=
 =?utf-8?B?ZFkzQ0UzUUNLbEhQSkVjOXdqSmI4aEMwMVl1WU1Sc0kxSkE5Z3hvdnRlMVVF?=
 =?utf-8?B?Y0pndW5FQWxPSS9nMUVPWVBlaGZoNW1ZSzhnZ2tOekpuZ3NzQUlhSUMxSkY2?=
 =?utf-8?B?UnBqZnE2dkhaMEIwU25DdHZKZUJwUGYwcERqblFySC9ORnRZejVSSVY0SHNL?=
 =?utf-8?B?cmt4TUFOSENyUC9wZFRQM1FPOTczR1BYSmpiVUZWK3RadWRrMXVOVHNoMyta?=
 =?utf-8?B?OGVEQ0ZYU25wc2pKVHZISnp2MFY3YlBMd2o4cUJBWkZUdEEvcjhlOFplVERJ?=
 =?utf-8?B?UW9NUjludVNMK2thYXpKWi9kQ3F6NzJNa2piZlpIZmd3NGZtOVdWbEFla1hX?=
 =?utf-8?B?cEdZUGh2RzlMV1h6aGNuTVRudUlySE9rSU5sVi9RUEtQbHE1YytUeGV5TEts?=
 =?utf-8?B?ZmNIWDQ1TnY1eEhuV0ZhS3RVUU4wc09tbEh1cTFIUGp1WmtRcEh4M2cwajZy?=
 =?utf-8?B?bFRHelU1R3pFVXdoTUtUZnZOTzRIVlpWWEtVdzA5RVZRTmJJN3A5UGJLcEdt?=
 =?utf-8?B?RjZCSWd3SnB0V3NWazdQK2pKTklHRCtyR3VxMWZ3UE9DWis1SU1tT3k4OGpw?=
 =?utf-8?B?L09lUlk3RUhuYnBlbkhsSmZmWDUyZkc1cW1wcG80Z1N0RittWjdnY2FNbjdr?=
 =?utf-8?B?MmltQmY0enR0dHlNWXFIZ2VZVWlSTGh4N0JIa2JlZGZzMTFDN2NuK1RlMEY1?=
 =?utf-8?B?V1EwT3RLajRzbHhocFczWTVVL0ltdy9xRjFrRnhKSk1sLzJkd3hpNk5xd2c3?=
 =?utf-8?B?VEJDTHh6aFVERlpmaHB4TDhMeityRnYzZlh2R1g4REJqTDZ2dDg3ZWVLVjNx?=
 =?utf-8?B?bWxSN2ZDSWVZTWpud2plSDFBWmVrUjZZUHcrM21GcGY2MGRoalJNZjM0R01B?=
 =?utf-8?B?ZFZ4UXoxL0ZXYnd4T3haMUpiZTVtQWJFRlFtNDBiVmY3U0doSXZsL2FWdjN6?=
 =?utf-8?B?OHdDV1k5TjBzRXF0dVdhUTJSdDZSTjJzLy9INjNndWNtQkdPOEc4V1NVcUdV?=
 =?utf-8?B?eGFBNzZiQkk2bVI5QldIWm1rMUdjbGkvUDZWdFhvL08xSUpKZkx3aE51NGZL?=
 =?utf-8?B?SUFtd2VMY0RlWXdEa3RQa3R4YXNLOUoxMEJzU3pPNm9NakZRWDZCdHgxVjBJ?=
 =?utf-8?B?TzJUNFlGSVo1Z3o0cW5WWko3RHRITWNQMG9UWXhYamxJd0c0TmFSUlBlazBS?=
 =?utf-8?B?NWlwMGUzUTg4dWxvcXl6RVR4VkJDL3JUV0FEcjNqblF5VS9YVWZhajFhWmNh?=
 =?utf-8?B?cWRPN3VNKzdqVXZHb3pFUVd0bjg2V1U1NzFzTTRoR29oWEVOT3oyOWNBTWZE?=
 =?utf-8?B?T2lPZS8xQzlaQjBaZUFDd1drblhidXBWeFBVZ2tTZXNxRG5pL3BiUU10Q2oz?=
 =?utf-8?B?NHJ5Unh6N0dFSEF3cVBxaTNOMStmR0s0dCszSDdROGUwUHM3MUtnOThCNmZJ?=
 =?utf-8?B?cjZVclc3NDlaVXRRRTh4alhYM3g5R1pLR0IwVjlzVnFROU5FemFSa05WaGZK?=
 =?utf-8?B?YkFSWUJSdzNyV0haTHhjaWdLcnhkQWt0cHZLSTlnajVNR0cvV0w1eVhPOFZj?=
 =?utf-8?B?bkdOeUgzck83cGxRRFBxT1lVbHk1aHlBQkR2Q3FVN1NtSEZ1N1d0ZnY4SXNy?=
 =?utf-8?B?YklodGJ3Sk9vNlU1eXNUOG5KcVg4ZS9UeDcwY0MzWkUzNWdFOU04RlRjYTgr?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SDQbTCtXxfphmxo+E7/L88lirsPmvuLCequUE9/03iXZcpA8Y8KEAYhpp6lGuMNeDCmS2r0xzdhuiGF+KjVr+PYEHFFPnMvDuSjgQSQ7wQNkH+b+QtMHB0HVIq3zc24EWIN1zpEaz9oc4o4z3VW1bfL6vKd97dPr4lJ5e09BFVce1mxDmhTQJRTqjThzmTC0nUbfeb3NQU4HShGRqwmZk7UJSfkysEdO9z/vh3MyXLas6frqsMODo3bIYDO1y84HNoyXQUrJNfqFe3u5dNGbtM4vyRStoLifmPjPO0yptdlucOXo4MtcMGQKY9slwy6aMF+rpjdDn5jpWxJQiSorZ61fWfV7LhpOyH0NlBT/IlUew+QrPOqz7c9ws13nFBqXTRDjhpxATm3+M5FJDky8JZUDb0mnB0kUN3S6VLkKxOlfIia4AmroXkwfmcGbFDpppYhQ23CdSfFh5GhGfJZlEQdaW22ZnxjvOvyVUIq6mOBWGWLApNyinlbnSNAJNJFkEmCMZui2VX1DpFiiU1ngVTBxLR7mi2X4QUhDTAyn3U2ZkYQx6STK+7dR1ZxNnu2APxX5F7TqAd/A7NsCSRIObaG4JIqZuXFmDX12tGih9dyJUOmcG29Eg1n7LOqd51Bs
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR20MB6853.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be20017-8621-467a-33a5-08dcb71fbcef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 20:30:12.1075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9hnsQaV5AZ9JS1NzQTcqx5MQJxFdDOctc6MeWcmSpTxSlcXOyPHT6gGkO+o31NL2TPkQGBmtuXGL1As1eY3AelubTycWhFIN/mkmSg+dD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB5645
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

SGkgUGhpbCwNCg0KPiBUaGlzIG1lc3NhZ2UgaGFzIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5h
bCBTb3VyY2UuIFBsZWFzZSB1c2UgcHJvcGVyIGp1ZGdtZW50IGFuZCBjYXV0aW9uIHdoZW4gb3Bl
bmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcgdG8gdGhpcyBl
bWFpbC4NCj4NCj4NCj4gSGkgQWxlamFuZHJvLA0KPg0KPiBPbiA3LzgvMjQgMjE6NTEsIEFsZWph
bmRybyBaZWlzZSB3cm90ZToNCj4gPiBUaGUgZ29hbCBvZiB0aGlzIHBhdGNoIHNlcmllcyBpcyB0
byBmaXggYWNjdW11bGF0aXZlIGhhc2hpbmcgc3VwcG9ydCANCj4gPiBpbiB0aGUgQXNwZWVkIEhB
Q0UgbW9kdWxlLiBUaGUgaXNzdWUgdGhhdCBzdGVtbWVkIHRoaXMgcGF0Y2ggd2FzIGEgDQo+ID4g
ZmFpbHVyZSB0byBib290IGFuIE9wZW5CTUMgaW1hZ2UgdXNpbmcgdGhlICJhc3QyNjAwLWV2YiIg
bWFjaGluZS4gVGhlIA0KPiA+IFUtYm9vdA0KPiA+IDIwMTkuMDQgbG9hZGVyIGZhaWxlZCB0byB2
ZXJpZnkgaW1hZ2UgaGFzaGVzLg0KPg0KPg0KPiA+IEFsZWphbmRybyBaZWlzZSAoMTUpOg0KPiA+
ICAgIGNyeXB0bzogYWNjdW11bGF0aXZlIGhhc2hpbmcgQVBJDQo+ID4gICAgY3J5cHRvL2hhc2gt
Z2xpYjogSW1wbGVtZW50IG5ldyBoYXNoIEFQSQ0KPiA+ICAgIGNyeXB0by9oYXNoLWdjcnlwdDog
SW1wbGVtZW50IG5ldyBoYXNoIEFQSQ0KPiA+ICAgIGNyeXB0by9oYXNoLWdudXRsczogSW1wbGVt
ZW50IG5ldyBoYXNoIEFQSQ0KPiA+ICAgIGNyeXB0by9oYXNoLW5ldHRsZTogSW1wbGVtZW50IG5l
dyBoYXNoIEFQSQ0KPiA+ICAgIGNyeXB0by9oYXNoLWFmYWxnOiBJbXBsZW1lbnQgbmV3IGhhc2gg
QVBJDQo+ID4gICAgY3J5cHRvL2hhc2g6IEltcGxlbWVudCBhbmQgdXNlIG5ldyBoYXNoIEFQSQ0K
PiA+ICAgIHRlc3RzL3VuaXQvdGVzdC1jcnlwdG8taGFzaDogYWNjdW11bGF0aXZlIGhhc2hpbmcN
Cj4gPiAgICBjcnlwdG8vaGFzaC1nbGliOiBSZW1vdmUgb2xkIGhhc2ggQVBJIGZ1bmN0aW9ucw0K
PiA+ICAgIGNyeXB0by9oYXNoLWdjcnlwdDogUmVtb3ZlIG9sZCBoYXNoIEFQSSBmdW5jdGlvbnMN
Cj4gPiAgICBjcnlwdG8vaGFzaC1nbnV0bHM6IFJlbW92ZSBvbGQgaGFzaCBBUEkgZnVuY3Rpb25z
DQo+ID4gICAgY3J5cHRvL2hhc2gtbmV0dGxlOiBSZW1vdmUgb2xkIGhhc2ggQVBJIGZ1bmN0aW9u
cw0KPiA+ICAgIGNyeXB0by9oYXNoLWFmYWxnOiBSZW1vdmUgb2xkIGhhc2ggQVBJIGZ1bmN0aW9u
cw0KPiA+ICAgIGNyeXB0by9oYXNocHJpdjogUmVtb3ZlIG9sZCBoYXNoIEFQSSBmdW5jdGlvbg0K
PiA+ICAgIGh3L21pc2MvYXNwZWVkX2hhY2U6IEZpeCBTRyBBY2N1bXVsYXRpdmUgaGFzaGluZw0K
Pg0KPiA+ICAgMTMgZmlsZXMgY2hhbmdlZCwgNzUzIGluc2VydGlvbnMoKyksIDI4MyBkZWxldGlv
bnMoLSkNCg0KPiBFdmVuIHdpdGhvdXQgdGhlIHVuaXQgdGVzdCB0aGlzIGlzIHN0aWxsIG1vcmUg
dGhhbiA3MDAgTG9DLCB3aGljaCBzZWVtcyBhIGh1Z2UgcGF0Y2hzZXQgdG8gbWVyZ2Ugd2hpbGUg
d2UgYXJlIGluIGZyZWV6ZSBwZXJpb2QuIERvIHlvdSBleHBlY3QgdGhpcyB0byBiZSBpbiB0aGUg
bmV4dCB2OS4xLjAgcmVsZWFzZT8NCj4NCj4gUmVnYXJkcywNCj4NCj4gIFBoaWwuDQoNCkkgZG8g
dW5kZXJzdGFuZCB0aGlzIGludm9sdmVzIG9mIGNoYW5nZXMsIGFuZCBkb24ndCBleHBlY3QgdGhp
cyB0byBiZSBpbiB0aGUgbmV4dCByZWxlYXNlLg0KSSdtIG5vdCBxdWl0ZSBmYW1pbGlhciB3aXRo
IHRoZSBwcm9jZXNzIHJlZ2FyZGluZyB2ZXJzaW9uaW5nICh0aGlzIGlzIG15IGZpcnN0IGV2ZXIg
cGF0Y2gpLCBidXQgSSBkbyBub3Qgc2VlIGEgbmVlZCB0byBydXNoIHRoZXNlIGNoYW5nZXMuDQoN
ClRoYW5rcywNCkFsZWphbmRybw0K

