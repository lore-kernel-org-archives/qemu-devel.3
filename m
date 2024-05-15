Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A66C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qp-0004fi-It; Wed, 15 May 2024 03:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qb-0004c7-QA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:47 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0000oi-SC
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757270; x=1747293270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/COy1tTJqJwtN9l2Q5BDMfmJb/FNV/tBPxp5I1KxCGs=;
 b=IDCYf0ntONvWIz8IYPGitR+6cmNVPB9eE4tldIWtwkZAPWvDuwf0W4yk
 5nSEpHQFvf6kD3yKwGBDxmm1qnRyPG4h8RuT2mzX4FJDDH3M6zJaTSi/m
 quAz8EIYCYbzlmQEFdkCO6/UQdyMT0/CAAsSdF0M5TSrfT11OgcMcUrad
 nIlmpEV7px28SY0gdhArmnboe0J8d56HZHTw5hJTrofXAo0E26FyPfOdt
 S2fxB7mb/7R5JittyIF+Qn9x1H045Z0/xdIq/aXgAdqd25ti+b23BjzNA
 uR07qzLv0DKbXndKyvVJ/Tu7RZ0Wb6TsXMLuCO68g0ZbAYXaNejN1QDQH Q==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581805"
X-MGA-submission: =?us-ascii?q?MDFbOrYb7kZTYiUhdphdjjx/oDzqyGW/1jih80?=
 =?us-ascii?q?Za89E3kW2DyC5UlAfN2VTsiruVbqnUWL7+7nM32vPirwhSBRSD3U9czZ?=
 =?us-ascii?q?860GYdNOejKpCYr4V46WwLy7nHwC3b5KutyQ8to0XfQvr3lcsg5Aq0RF?=
 =?us-ascii?q?wuBufMetrgyUE41AS2svhTQw=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLaia+ZsniCqMcERfATif4H++PkQKDi0+LKQonLV0SfmZlWE4ahe/5bEF0PcZ1/dwZuEkJg8xCZ+haqibNU29Mg/Jct5XRhSGReapE4W9hlhiMVq+DwhESZi762DxvKi/HSx+1HlNY+eynk+qd84/j4XtRNVkimRQsqoyyURi0dxhtksAjbw/Dq3gQL4wVHieA29rYqArRWHaBcCJszwZQceOXkaOL7Pdum1f84kAsbHG8O+PAldGDwJCP8i7kqIxVdOCgkg+/cmoJyy01rMiPnzMssj0wyGMeACWjvmiMoyTrahrknHTFPk7aVgo5qx1rSb4pxU9n6fOQGuLBLFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/COy1tTJqJwtN9l2Q5BDMfmJb/FNV/tBPxp5I1KxCGs=;
 b=EyUdyHSOmPYLsJsh0wotdLDBfLgRbcdV4ierlsNz+vNE3Yq2opP5M55A/uaS2QzHYsR6FuJ1u+TTPw2UpBy3IeMrvjyKy15NPoaCYYKZulUNJjk2UCYkRY9Q1Ys+uH7HYzW84YY38rmhWNGfNZImRec1gbIdg1OtKTa98YKrJXqu3yXiiJfbxPi/RdDulWTxfQzzOqM4u9sKq6jVDBom3P7YoQpfW498SmRp45aNupk1CxwD/Rp5iOVdkwcZPIbenqh/7NonQ9RBQdOZnzEyrA8MvEdV6NPRl6awNkOdQ1ma/E6alLg6FwZM9uW1FWlK/kj3iC+xwsWopsPF2naxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 17/25] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v2 17/25] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Index: AQHappeAHabkT3s0Z0KfBt4GrSghlg==
Date: Wed, 15 May 2024 07:14:18 +0000
Message-ID: <20240515071057.33990-18-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: 683fe7b9-4d92-49dc-95e8-08dc74aea2d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dWJzanBmVC9mUjIrandQTW9keXdBK2k2aTN5TXRtei8ydmtYaHpWWUR1NUEz?=
 =?utf-8?B?V0pEb0tNWDFORU5hUUJVNWdVdkxwV2JSSllWYkZCc1Z0TTJTNHZIYnJSWkRF?=
 =?utf-8?B?Q1A1eGNzcm5zMS9taFRJWUN4Ly82V2VKTFV0NHg4QU9DbHBoWHZsclVreGpM?=
 =?utf-8?B?NUxDVllhclFOU2ZlMHNFalZxMTYvYnR3amlwd0ZTZ0k2RTU5ck9OeERjcERX?=
 =?utf-8?B?R3ZBcHpteXdFeUhmbWFCQVBLYyt5S2JXYzNqSnpRVElHQVlpZ1c3OWhGbUYz?=
 =?utf-8?B?YjZYZnZHaWxQdHlNek1lb1VQNU11YitYeERSMFMybW9OVU4rWHNDMVJQcFUw?=
 =?utf-8?B?MTJWL2U2T2hzemNnSEdOcUZRVk9VMVQ2aHY3OEtPeFBCaytyQitCWHdGbmdM?=
 =?utf-8?B?MDNuU3Z2ZE5MVlFlMEluV0FlbUk3Y2xMSWg2eXpHbHlXTjIxeEdMb2s3SmZr?=
 =?utf-8?B?Q1dkU3dPRVp0UGp3c1IrNHNpTGpaa1Z3TTNvSDF0alBaRENzbDRySGN2LzBy?=
 =?utf-8?B?TXJQa1RRQmp4N2x5OTZXbDRKc0V3V3pCTzlKV3kycG1KR2Mxd3dKT1BQRytK?=
 =?utf-8?B?Vzhxc3RZTjhXdHBOYktqb0FXY1B5Y2g4TlV6SzVZL0loSWJ6bUZJaTJkZ1Zr?=
 =?utf-8?B?V1hURGpiK3d5aUxHV2d4aytSejlXUVRXY3NpaE9NZk10dGNOOTJiQkJLUWN1?=
 =?utf-8?B?dmR6OForNTl5UXhTMkhpWWVuWGZwcFJtWFhmcGVKeldOKzIvQ1dIQk9JdzZL?=
 =?utf-8?B?MlZab2dkU3d1VTAyVDFCdXhYeTBWVTNqbHEwM3h2ZkFMeEhTcEk1T2RJdjdZ?=
 =?utf-8?B?V3hxSFE3djJhb1R6L3pCSTZPZ2VxdElIT3RSRE1BTFA5VTFzRnVoY1grOGYw?=
 =?utf-8?B?cUsvL0FNeSswSkg1MnNIU1J1ckJhTkxyU1hxUWtuU2FTWGhDZzgwNlQvZnZ3?=
 =?utf-8?B?R3h0RityZURpeWF4MUNiKzFQZVpDdzZpdEg3VW1nODVZRVduZmJVMy9nalRz?=
 =?utf-8?B?S3Y3WjI3MzdScUlzZVZqNlVRcFJhYjRQQUNTL2hFZEtBNjAyNTdLQ1hzVm41?=
 =?utf-8?B?MEZVYllheldXRmIvZ1FrV3E3Rm9SeUVTNU5HQlF3MWRnUTVBOVVxLzEyYWZF?=
 =?utf-8?B?L3RTV2Q3bmEza3BIVVRCQUZEb2x6Y1QrTktqV0tYNGc2cXpoSjhmNTkyZkl3?=
 =?utf-8?B?QmNtZCtlSzBMOVo0QU5MSGgwSXVNUlU5THh1Y1ppU0dUR1BSYU5KOWRFZnVJ?=
 =?utf-8?B?a1EwNXNjaWpYOUNnWWk4cFR4Nkl2M0x2YTJIWTNSZjZqeDY3UU9MNWVXZXZw?=
 =?utf-8?B?ajBvdGFqakV4Qm1XQkhySnQ2TWFYa1lVRnk5em1ZbG5BTm1IeC9KNzM4N3hv?=
 =?utf-8?B?cWNERURoTUFsd2pBd3hDQzY3QWkweUFNalpOSldhYjl2U0NERkRaN01ENTVQ?=
 =?utf-8?B?UFNmaWtsNGt0dlRQRW80SVppVFNYdFQrSFFMNGZra2dKQWtyT1dMbjRuZVZM?=
 =?utf-8?B?SjJyYWZjVWlMMk83WDNDK2JCMjFBSktqVHR5K21BNVl1czV3dS9xTytITFBl?=
 =?utf-8?B?NkJPQVFmb2ZBZFQ5NnEwNU5kTExXakRKTHlGM21xT1RuTXI5VHRGSFErVE9B?=
 =?utf-8?B?OU80eldkeFF5TisyQ3crUlpIZVhzdVRzSlEvNXNPcTFBd2ZHZ1hVOFdBeGkv?=
 =?utf-8?B?d3F4MEpOWC9FY0NKeG0va2RBNGlwVjd2QlBtRHd2RjluMTBGQmJObTN2emFJ?=
 =?utf-8?B?c2llUjdkWFgxdXYzQVpnZXRqQzdMREd0WXpuKzRETlB4dDY1dEtCaFlrVFBw?=
 =?utf-8?B?ZHhKYXA3bVRwVXg3OGRoQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dENSVWY1Vkd5Ym5wVHZSM1ZqVGZoMFJoMHArUzUrQ2d5L0pSSFQ3T1I5TnE3?=
 =?utf-8?B?RE9UdzdJekp2N3hqbFJNWDQ5ZGNEbGpGRUhlQUtGbFp1WDdvZ3pkWTFrSEhT?=
 =?utf-8?B?OWNmYlhtdm0vRWFSODVJVU44NThpaVFaSldpSkkyV0ZBcThCNGNlMVN2eVk1?=
 =?utf-8?B?SktYYnRzUHE2WkRDS2lRVFFFc0tzRXpGc1hyMHNwWXFOSHdqbzhUVGltM2s5?=
 =?utf-8?B?cEFYT051QWt2Um5mWENSVGdRQVlmanVSdStMUlhIUjQ4aEwzaG42alZqKzV1?=
 =?utf-8?B?R3NBMmIvdFQyY1FPanFQUU1wbEczaXFGOGlLb0xmQ0FvU0tDTWxEcEcrbmNB?=
 =?utf-8?B?cWdFMkhjc0JBVWx2WlNPeU12NmtHTGl3VVJTT0J6VUhEeEVMaytJVGRSNFdY?=
 =?utf-8?B?bWZtcmxMVUtmZkhQNDl3WDZ2TmlhVnBPZm1rZVRKNWFYMDR6and4cmdtVzly?=
 =?utf-8?B?ZXpNWFRudHRJTHJyTDdSMk15TFlLd3ZFdmoybHdpZ2dMR3E1eHpxVUZ3M1F5?=
 =?utf-8?B?UzJQNGd2SFNrNU5xZ1RWN2dSUDRKc1hNak05VUlKRnJGSGRnWHBWRjJpa2VR?=
 =?utf-8?B?YU5WaTErYW9HWEdwSnF2SHlsM2svNVNIT1VVaURmekIwYnJ1WVFyRFNPZzBM?=
 =?utf-8?B?WVlkbEU3YlNHc2RqZXVwM1ZNQkxsTnhoZ3hRMUptS284aTRiWjFOZ1Q1cnNt?=
 =?utf-8?B?MnM3NGJWTGZsLzBCeGlybnBRYWRtR3NXYlZ0NkRQY0Y3WmE0Z3UxRVRKK3lU?=
 =?utf-8?B?WkM4L2RuK3dqQ0VnbUNqaU5ETXR6YS9veDFzOE5jWC9jV25GQXhSUzlFc01u?=
 =?utf-8?B?UDJnNEhNYmRBd1lwZ09hKzVvTVdKNXl0ZHR2UC9OQmpxbU9Yc25OSnJ3RzI1?=
 =?utf-8?B?VUNCWnV0aUNPY0toTVVlK09KQUJxR1pnWkF2TUVFbEk3Y2k1OUUrcjNra1hQ?=
 =?utf-8?B?SXFKV0UvVUZVcytBdEh5T3I1MmNOMmpsbzNPS0lCNjkzQzk5dlhSTWVLNHgx?=
 =?utf-8?B?OXlBQTFuZHJhdzZhZmg5T0MwbmpZeWg4RCtNaHYweFV3RU9GWDRDd1RwL3V3?=
 =?utf-8?B?VHIrU2kzaEhRdVRHRW9pZVJWd29GZWViSi9OQ0cyTlN0U0dpMlgwUmpOK2Z6?=
 =?utf-8?B?UUFRM3R3WitxamwvYS8vRTZyN2lhcWhXY1VwSVhKY2NqaU0yZW5JTnJVRzdu?=
 =?utf-8?B?cVlVRG1INFp0N2NSR1JoYWNiS2JDNGU2T2NFZzdZdHZVRVZtc3IzTDZ0N2Z6?=
 =?utf-8?B?aTNNZzJXcFFzRWxoTk1kaDVxQXVQdE5raUUvbW5OZVdIM1A3NFo4VHp2M1V5?=
 =?utf-8?B?WTFHMzY0S1lIN2V3blBNc0RQSVM2SDR5L2RGMEtUZVdhMDdTM1dUQ1JlNjZI?=
 =?utf-8?B?cmJMejZxaExaS0JXb0NkbERqSnlLQmdZT0Z1elplQWlPcnR1T1R3NzcwSGQ0?=
 =?utf-8?B?QWV6ZnA5Uk41QWJRdVZRaG5tamJDOXlWc3M3WTN2THBZOHQyZ000WVh1aE9L?=
 =?utf-8?B?b3hnZEdZTXNGL3IxdGJmb0RVMGp4Y0dHd2FlWkl3amdRdVZzNDZWNVJNNFVn?=
 =?utf-8?B?LzFYQjdibUhsVE1BS3hscjF1Slo4NGx6WnBubC9RS2FSZE1tWkVUc1EzVFR3?=
 =?utf-8?B?RlNMZ1lXRkhlSVRJdFFJVVg4T3pyWUZpaGpkR0hva25PeFBmLzhvWWhyaXFh?=
 =?utf-8?B?NnZHS2QvbDltblRKYlRVNlpuVnliWjVWYzE5Rm1jNlVwalhzcUFFNTlRYWdj?=
 =?utf-8?B?bXpaQ2ZWeWJyUHVRdlE4ODR5Y2NLMGFkOGRuR2V2aWRmaWFhR05EY2I0dUJk?=
 =?utf-8?B?NGFWblBEeXdnT2NwOUNoUE1Dd0lXekFWVTkxSEFYazkvWnNmdis2ZTFVdE5Y?=
 =?utf-8?B?ZHpDYXl0aDNzM3VvZGtHS2hFMHJQR1J2dzl5K2ZjZ3JONEN1cmpxNzlXMjJw?=
 =?utf-8?B?Q2hFUGgrYy9RcERoK0VHbkgzLy81V3dSWW0zdm5oZHByODljNGZVN0duRzg0?=
 =?utf-8?B?c25iMDNRei9Gdmp2YkV5Nld3eUczc3BNZnBBZTEyMlZPRGNPbVZvQzRlZEU4?=
 =?utf-8?B?MGF5UnJEVVRRZjc4NzIyNjBZTkM4LzQ4aDUxNk5GVTBYci9lMk9IckYvMHNa?=
 =?utf-8?B?dUxlWnlzVnZpY0VFOEUzb1JzUHVINExKQ2ZyVElERG4zUkE2YTFWVytBWTdL?=
 =?utf-8?Q?ey4ttblpBJeDKeDcqa6OZ/I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5441A29D3497A41AE5A7DB3A9677A2A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683fe7b9-4d92-49dc-95e8-08dc74aea2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:18.1240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOHv4Dj2Sc0dsQSr9MNtFY1dwhn6bUe6vyUXTNDgh4a/hels3x2nQj4LxsHHxYbEyvXRVzuAZxP6dgXsTwCuo7VW8qh/nFdAgcYnmZirkUxp3/5IuwpVecHWSL02U7ft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDEz
ICsrKysrKysrKystLS0NCiBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAyICstDQog
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpp
bmRleCBmZDQ3MTBiYTI4Li5lNDhiMTY5Y2RhIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC01NDI5LDcgKzU0MjksNyBA
QCBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIHZ0ZF9tZW1faXJfZmF1bHRfb3BzID0gew0K
IH07DQogDQogVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRl
ICpzLCBQQ0lCdXMgKmJ1cywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
ZGV2Zm4sIHVuc2lnbmVkIGludCBwYXNpZCkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKQ0KIHsNCiAgICAgLyoNCiAgICAgICogV2Ug
Y2FuJ3Qgc2ltcGx5IHVzZSBzaWQgaGVyZSBzaW5jZSB0aGUgYnVzIG51bWJlciBtaWdodCBub3Qg
YmUNCkBAIC01OTgwLDE5ICs1OTgwLDI2IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZXNldChEZXZpY2VT
dGF0ZSAqZGV2KQ0KICAgICB2dGRfcmVmcmVzaF9wYXNpZF9iaW5kKHMpOw0KIH0NCiANCi1zdGF0
aWMgQWRkcmVzc1NwYWNlICp2dGRfaG9zdF9kbWFfaW9tbXUoUENJQnVzICpidXMsIHZvaWQgKm9w
YXF1ZSwgaW50IGRldmZuKQ0KK3N0YXRpYyBBZGRyZXNzU3BhY2UgKnZ0ZF9ob3N0X2RtYV9pb21t
dV9wYXNpZChQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKQ0KIHsN
CiAgICAgSW50ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KICAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hczsNCiANCiAgICAgYXNzZXJ0KDAgPD0gZGV2Zm4gJiYgZGV2Zm4gPCBQQ0lfREVWRk5f
TUFYKTsNCiANCi0gICAgdnRkX2FzID0gdnRkX2ZpbmRfYWRkX2FzKHMsIGJ1cywgZGV2Zm4sIFBD
SV9OT19QQVNJRCk7DQorICAgIHZ0ZF9hcyA9IHZ0ZF9maW5kX2FkZF9hcyhzLCBidXMsIGRldmZu
LCBwYXNpZCk7DQogICAgIHJldHVybiAmdnRkX2FzLT5hczsNCiB9DQogDQorc3RhdGljIEFkZHJl
c3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGlu
dCBkZXZmbikNCit7DQorICAgIHJldHVybiB2dGRfaG9zdF9kbWFfaW9tbXVfcGFzaWQoYnVzLCBv
cGFxdWUsIGRldmZuLCBQQ0lfTk9fUEFTSUQpOw0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMg
dnRkX2lvbW11X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1h
X2lvbW11LA0KKyAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9t
bXVfcGFzaWQsDQogICAgIC5zZXRfaW9tbXVfZGV2aWNlID0gdnRkX2Rldl9zZXRfaW9tbXVfZGV2
aWNlLA0KICAgICAudW5zZXRfaW9tbXVfZGV2aWNlID0gdnRkX2Rldl91bnNldF9pb21tdV9kZXZp
Y2UsDQogfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBiL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQppbmRleCAwZDViOTMzMTU5Li5iYWM0MGU0ZDQw
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCisrKyBiL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQpAQCAtMzI1LDYgKzMyNSw2IEBAIHN0cnVjdCBJbnRl
bElPTU1VU3RhdGUgew0KICAqIGNyZWF0ZSBhIG5ldyBvbmUgaWYgbm9uZSBleGlzdHMNCiAgKi8N
CiBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBD
SUJ1cyAqYnVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZmbiwg
dW5zaWduZWQgaW50IHBhc2lkKTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKTsNCiANCiAjZW5kaWYNCi0tIA0KMi40NC4wDQo=

