Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A96CD6E43
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGvw-0004on-CP; Wed, 27 May 2026 12:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wSGvp-0004no-Jn; Wed, 27 May 2026 12:16:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wSGvm-0002hv-06; Wed, 27 May 2026 12:16:31 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RCs3vC2619691; Wed, 27 May 2026 09:16:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eS48r5Tb2ccp/tpcQ30D4fi+4dIUSBMAy5yMcs7Wd
 Jo=; b=tO455QK/F4qr5pl/QOwEvwXEIEn4NfRwLMiJltQEzuwPtS9IEJtV8urUT
 IQve5aI1Yvvj89VT+JjW3SqaeedbTSW13c3nxJLx9dLgMMRyuFRdulNm3JFcGJ/4
 9Ur5xx1WdNcMXCTjJBkXQFzHy4uhj6nk5M0f/v4Y9yBWMpCi/A3Fxqqud01gFisW
 ciV+dljn/MoVOZs3wlN6GU5mXrktWecD4NaA7wz/+nT0gMLp712zFe4C4G/wTI4z
 2KwcnQmJeM9ANTX8HQfHc2zyRJmY9o/9P3ES0dwuvYnVau0eOtAXaVD6N2VMliuH
 mt9wSl2f5IULb9yIZp+V6Q9W/Pl+Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023130.outbound.protection.outlook.com
 [40.93.196.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4edhy3tgrj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 09:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgiJHEEj/hDoYfqV3K69QaQcvn8bMKmQGkhbVX/8pcS6oNDEsJQoodjl/3mLTQ7m26jEwTNEB3ac/AiVksLeF+VZjRsiNkeX3jeH1XTE8//8pwN1sOdXRDyZ/LBSsbx3jKQxO7b5gedntPNn4yICPopK7hKtm9E6+g+GLPNPAwTaRLN1Wmga7tmxArwQzMz7JzTUNtvf8qvemoM8lTM/pN9YdpcPyUsYJRwUPseEHnaNMu9tXc8K1EMnNXQoYytEVLLPUS/b+epOTetu8zIuNzr6iQZozWtZp5WPntMzEpdvceJkJXcWf+vBZXaP+f0vP+r+SS6SjHLreknvUmdYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS48r5Tb2ccp/tpcQ30D4fi+4dIUSBMAy5yMcs7WdJo=;
 b=XU9bUao7iYNA+RhIG+tUMQO8I/jt/AXkSQRfh70oRzcccaOip4fg2BrdvhfE7rUOzdwW3i/QP9rpOWJWhgYlqAPBc11fp5Uqf8DZ8z2fBqooM0R4CmE3PPncsJMgxcx1RhljcAfLUAkBXs7RZLwykDGaOboC+uRZgTNkrTqF3g7hCDIcyOKdfMtHIhMGOoFzHFcHdSOx75ExPqB7vJ047FMwdFbX/Zw5xBc2r0+7Asf5K0SdvpHjybaCG2gZw5Ll5CN7XOhwcBqf/IbKDFo8umDZ+lnS5zTY5YKPDi1QbrkgnsRxbdc9v67xfv2fjKU/3r3/xzOkIn7bMxACGID7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS48r5Tb2ccp/tpcQ30D4fi+4dIUSBMAy5yMcs7WdJo=;
 b=AOTu8aSKLvgMBbXa+siq/ZRPXrg0PS7h2h6FsSxqCJNo+UYLC3JHvgIzBrA9dswdCcIwNmjOeGUk2wh1y2LlKKo8jziJQd8KpvpR5qoqOwLslw3SbUbq+WqUt5nF1zlCx4uTmhWmtSD0RZ9sDq1Yiqe/s2cQVLyrqw8jhV1jxSztIJFYemmqKr/QP4Dci2vUZ3OEjdhp16776LNGH+Maf87aeq5RNAFbF6QF3V3WncbJeNDC+VpyJRGTJ/XTUpyUqBPk9nPMo7P1xLWli1cdKofgWFngFF1sQ7DY9Zhal8Fi7wMS/a67RGnid8Unm2Dlgfb+l4ba9M768g5t0qa/cQ==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by CH8PR02MB11090.namprd02.prod.outlook.com (2603:10b6:610:2c5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:16:05 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 16:16:05 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Shaju Abraham
 <shaju.abraham@nutanix.com>, "yangjinqian1@huawei.com"
 <yangjinqian1@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
Subject: Re: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Thread-Topic: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Thread-Index: AQHc55O/x+/NiUinyE2TjkVGnlGvpbYiAA6AgAAQkoCAAAJLAIAAAgYAgAAEFgA=
Date: Wed, 27 May 2026 16:16:04 +0000
Message-ID: <3A56B398-0213-4962-B27C-96F716DAB799@nutanix.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-16-eric.auger@redhat.com>
 <E5402D74-AE00-4088-801C-C87A749E17C9@nutanix.com>
 <80fa5157-2376-4010-88b2-deb6ab50f87f@redhat.com>
 <6CA1EBCE-BA44-42A1-81D3-1A723C6F0CC3@nutanix.com>
 <72f22825-d810-4fa1-8fc5-123ae06af91e@redhat.com>
In-Reply-To: <72f22825-d810-4fa1-8fc5-123ae06af91e@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|CH8PR02MB11090:EE_
x-ms-office365-filtering-correlation-id: e7455ad9-e834-43e4-8b8c-08debc0b40c2
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: kqHM3Dyd56m8ws4eRL+ueNO4Q0pbd1kZNRlDhFGDWS8kp2Mtw7NMCrBl4adSSS2pq6ee9RP+bga8lYvw3SvUu5IcCR0wsUQ44b99e6dhEsLxdP7VGo26X/BaRk0dIZiXmUK0RH7OLfkidrx+/76CzjE+5EQ8kvdrElWFtAliHo3xhYIKiP7zFQAVmorWipjgVVVtH8W0rpn4p/dMwIkuzZISfEFVWyyBkKYP6xz+fd6Bi03UnwGxpSHH0Xsg7BQ1Ch4FcaxTgNgdXkf+a/Dn4ErpQlbW3Bf5iwXBJYHiZNKGk4GSNhIWP5jTyqTuXd+DOZjU/zlNrNcRKVR5/o0uoK4fsymqDvl/LZi+lZ2jc+hpuq/5/e41IHpm6Ae9z0AjCMevqGHZdGkbb738L2phspYntsOOrp2Y3BnTQjpGdB+lGkdnbQlx03fTosbSB6VCDKy7X+DZa/st+n16Zt9XiWA5b1AXpb6MyDkkMXSFIJc50LMFjmVzqOyzUO5JaPY6DsBND4Ymd0KmNtoREPlmaU0wL9QfOx3+QAf452zsmxRfi63Rh9t1SISRsS53tc2HJNtL+UUImv1QH/Paw341dzvSwo0uoB4zwEeddnKF1ZOGTIVRdw+V6otHt7uA0NeulsCUfuAPnmDXFAtmeFcNDTCAXHhSMfjhZLLWyH0LC//k1Z1eVeECIqFL3XAFcR2FyQOEQjJE0zav3vKGcJXnWn7rDkXIhIrwAmZgJtC7L5mHTV8x/DV9j5v8NPX4qOCE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnBneUM2Ny90dGlZS2Vaa09PMHRBSEhJNUJnWm8zR2xJeHgxQXJMVUttdU0v?=
 =?utf-8?B?WEl0TDdhTlczUDY1RHdoRE5MM1BnZlptUkh5YzVWNU9ub3RXK1pLMEZtMkVu?=
 =?utf-8?B?d2djVHU4aVRqaWw0dlRRaGNIdHFLTFlIcHRhb09ZMDdtdTZwZkk3OWwrN0pp?=
 =?utf-8?B?ZGlVT0pxYWdLb0VqejA3aXljNW5KRHZQOFlWT0dwcHFFVFNZM2R2NlVKV3cw?=
 =?utf-8?B?VVQ5NWFxSURmY3M3a1JDK3FmWS9MbWVlY2ZuRytpckxJOHdsZTFVdFZLV3Zj?=
 =?utf-8?B?OXRmQ3ptYlpCTTVRNVhjbWlUWExON3pzRnRCenJjYjF5ZWpKVitWbUV4T0xK?=
 =?utf-8?B?T2RDTXJ0QmloZkJsTURSbHZ5VS9nVGZidFFJaEw4T0EyYkowMHFma0dvazZP?=
 =?utf-8?B?djVjK1c3dThLVklURXRNV1prQS95bjgxWVhYb1dlU1hSdjI5d0VMOGNnb3Ry?=
 =?utf-8?B?bWM2ZURYVTJpRXgwaTVpZm9qc3FFY2xDMnJOSCttOUdZUGVPU284dXo1UExK?=
 =?utf-8?B?aFVZVXFVUm91cUZWQTFWamVQRVo3cmR4TG0wMFM3c21uK3VTSjFrQ09hdFhB?=
 =?utf-8?B?TUpxNHRGN3BScksvcWxSZTBVU1dSaUtabitrSW0rYTZGWkxoMmhzRzQ4cGp1?=
 =?utf-8?B?d2pLSDNHaHpRNlRkd1ZHT01zVXUzN25va3dsalEwZFBZZ3V3bHczYUFpdXVo?=
 =?utf-8?B?L3J6WnY0Wm13dXNDRWZmQzd5eEMwQjhtTm9FOHIxUmRaWUJQN3RKQTdZd0ty?=
 =?utf-8?B?VjY2Q1I2OHdqKytZdUZNZzVNb2RNaE5lWVprNHpiRXQzVFJFZ3hDUXpJWjNu?=
 =?utf-8?B?WktwNTAyblVhTTF6bDhhbTdZbG0rRTdGYlJTRms0RTlwRG1pZjZJMER4T0wy?=
 =?utf-8?B?MVZwZHdRVmV6ME9lTkxCOER3ZCtmZmVPYkdhRnVyRkYzNVVSWHkxNHg0QVpw?=
 =?utf-8?B?cVZrNmIzeTZFc2psNWlDQ2FuSVltUWZwRFFUbXVZMUlsbndPYmZLZ0RMWWJB?=
 =?utf-8?B?ZGN4STQrWWxLNzh4UENVMTE4VjEzRXRHQ2ovZWVzVFN1RXg1V0UzSnZsL0la?=
 =?utf-8?B?ZEVtMkJmUzVEVmhOeVpWN0VtREFJcUhRQmZueTNMZXNMQUJCdTRUQWh0c2lS?=
 =?utf-8?B?RVlCR2xRT1JpUHFYcUd4dFZNbUhsM2xrcW1BRXpwNmhOZnEreDZpZ0w4Z2kr?=
 =?utf-8?B?cEpOT2dFUEhhVGF1K3Fib2pLb0FyN21Ybm5YN1JQTC85b0NVOHZFN2xDVGhy?=
 =?utf-8?B?Znk2SXBKK3cyYmZoVmNBblVHYTRCL3I3QVErRzVPNE1UOXFGK2VUazIyOGEw?=
 =?utf-8?B?SGFKOEc0bm10MGNSd1NHdkVGMm1tcFV0OFg4WTY2dDIxU2p0aWJWb2kyOVow?=
 =?utf-8?B?L2xqaU4vdC9mTndKNkY0SjBwYmhuSGFLVmJ1cTVWYnI4akcrRU9NYnZQWHVu?=
 =?utf-8?B?aFlqKzAzdWNNdmE4MGpmakVUR04vVkJyWkxPUVE4elMrSjV5TjVQbUVkWUlD?=
 =?utf-8?B?Y3hDT3cvZElTNHNPWisxSytTZHJmOFRBdUN0eGVMcDc2bzBnblhNMk1UME0r?=
 =?utf-8?B?M3Rmak14TVRWUHkzUVR0MTFoZXY0M2dtZVpzQTJIcFNFb3NiNDRzeWExUWFO?=
 =?utf-8?B?azJGd1FSeU5CUHJNSTVqc3IyRUNzTDF2ZmhHZEVTTzUwOUR1SGt3dmx3dnRE?=
 =?utf-8?B?Q0lTblJRclliUkNGeTNrcFY5VVNoRFkyZDl6WlB2TkFXdHR2RGN5MzhrenYz?=
 =?utf-8?B?bHJDYVBaRmxrOEF5WDFWTFprMnBxMUxsYURld0dFUVQzN3pCdFROSjhtbm9k?=
 =?utf-8?B?clFMK2k1TUxvMk5mRkljZENXd056bnZ4b0EzVjhSRnEvc05SbFhzamFpZjMz?=
 =?utf-8?B?NmNURUNKRlpSWG1QNWVkTjg0R3hHQ0Z0d3MvRVpHdDI1blpnbVExQ04yb1k4?=
 =?utf-8?B?eE5SUXdZaVNMZVloUldraGJsUEJ6dTQ4SGM5K2RadjU1N2NwSmxyT04xZk92?=
 =?utf-8?B?UzBXcjFFV2YrOFRlZ3YwS3J1MTBGdHdFU1V6V2pTNmJIcmkzOEk3Sjh5OWR5?=
 =?utf-8?B?WDRNZ1FNMlVENzJKMmFVMnRuYlZtc0VlRlZVOXJzZjdNRGp2dlNlNkdaRXph?=
 =?utf-8?B?QnNubUlHYkk4NGYzUUJ1VVMrY0xZdjQwajFPaEZ1Wk9NWFl3bTZCYVJUVEx0?=
 =?utf-8?B?ejBHRFdqUlc2WEY5Ny9sU0RyZDBvQWxabW5vRzd0OUlrZCtVY2RhS2ZPZUxE?=
 =?utf-8?B?VmxXUG1zYVgyejUzWHZ6NVVUdmI4NExjblBHcC9obGs3cXBQZVZyZkFQVjRq?=
 =?utf-8?B?MVpTSFp0RTVUZmFVeGdWMjJHREFJa2tmOFhUTmpBcC8vUy8vUEptOFFwKzV6?=
 =?utf-8?Q?dLcHKN7b+EyWttUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C5B9022D915ED458B6FA289BE8C1B88@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DSfRg6lgQ1NiG1B3mvm9375jGsmowNQNU8HmdAGtXXalvDB9932MHVL4kwqxxrZxNsUD5t6HUWraB1N+JADXOpB1VseV54jBNmKgb9gDX81EGSmzksrXZN7XTpTl4HkP9EsInmaBiulPDhwlOEOIV83Dfy3hUnRIcoY5oeM+DQCC4cTKCH1x3xRlo1qF5xfWOGQv0KqOakkkGfe4ccHT25LLY3wQN7xky1i6SCppS3ZfCRBKf0LV+ai9RgJD096vF18ZmQam9C0JgxBC4gK2P3eLGPxMMszTVUNkxxaH6Ik5RXPy/dnWxTvH9frAl0l6T/EcY+YmxAkI9R23oIcA9g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7455ad9-e834-43e4-8b8c-08debc0b40c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:16:04.9788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Cox+mWmeeOjmM6o/q19lJAsJDzbARIAiQJxfLIA3NFXYiccE/df8WPbL+V4no33VurMlGrzYTJmapJMlE0hXICZg9KR6OX7IrALtSKSnlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB11090
X-Proofpoint-ORIG-GUID: nIu0zZ_KlTG7nKULHxhzZ_6rhsISfFlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE2MyBTYWx0ZWRfX150NtZRVt15Y
 ucreJ8qO/CLP8AUPoXC8Yapk8tlpLnvV2JHvHw096BuF8+o09lIoqEOhNIbFizW8DZEtOmCzYvu
 xE0eXi/Sbjk+uINIvBAbsvWMT2hqnm3oPGKdc0CdvmWPFpoNfwufkyxlKUjNF0tN4aYBPvLk+RM
 lyqhrPxQx+o8iUDzoir45fppJRbXp8svh+z9Z6DYVBHGMeVJyzZ4Yq7jp5X6KEb9XJgKl5jLDIk
 yHubQMCd0OyylxL658tx1HhIjYdHe6GPXeHBY3g4Q50i+YX+8lLkimEilyv/ONLq/iJehZmeiki
 930VYV3Q+0lzSrz3ag3T3sTfezExcHWfYHhl8R+E57/KJyI59KdaUaoxGL3zhiyfMqkRThR5cjR
 puuTL9g0acQoCqCyl2IvRgCw8m6mFyLfXjnmtoTo5viah4/r8v+hjCjJ42ocXiyTbyIcRJ413Qg
 vMfLPXiLvPQF12992fg==
X-Proofpoint-GUID: nIu0zZ_KlTG7nKULHxhzZ_6rhsISfFlK
X-Authority-Analysis: v=2.4 cv=f7l4wuyM c=1 sm=1 tr=0 ts=6a1718c8 cx=c_pps
 a=IVKdG2MezXXsalPeTMxobg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=20KFwNOVAAAA:8
 a=nvCKeZooNwCA-4aqevUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=khushit.shah@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gT24gMjcgTWF5IDIwMjYsIGF0IDk6MzHigK9QTSwgRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IGJ1dCBpZiBhIGZpZWxkIGlzIFJFU3ggd2h5IGRv
bid0IHlvdSB3YW50IHRvIG92ZXJ3cml0ZSBpdD8gQXJlIHRoZXJlDQo+IGNhc2VzIHdoZXJlIGEg
ZmllbGQgaXMgUkVTeCBkZXBlbmRpbmcgb24gYSBjb25kaXRpb24/DQo+IA0KPiBUaGFua3MNCj4g
DQo+IEVyaWMNCj4gDQoNClRoZXJlIGFyZSBjYXNlcyB3aGVyZSBmaWVsZHMgYXJlIFJFU3ggYmFz
ZWQgb24gY29uZGl0aW9ucy4NCmJ1dCB0b28gY29tcGxleCB0byBnZXQgaW50byB0aG9zZSAoQ0NT
SURSIGZvciBlLmcuKS4gDQoNCldoYXQgSSBtZWFudCBpcyB3aGVuIHdlIHdhbnQgdG8gcmVhbGl6
ZSBhIG1vZGVsLCANCjEuIElmIHdlIGRvbuKAmXQgYWNjb3VudCBmb3IgUkVTeCBmaWVsZHMgaG93
IHdpbGwgd2Uga25vdyB3aGljaCBmaWVsZHMgUmVzMCBvciBSZXMxLg0KMi4gSW4gZnV0dXJlIHdo
YXQgaWYgUkVTeCBmaWVsZCBiZWNvbWVzIGEgZGVmaW5lZCBmaWVsZD8gSW5zdGVhZCBvZiBtYWlu
dGFpbmluZzoNCj4gDQo+IA0KPiArICAgIGlmICgoIXN0cmNtcChyZWctPm5hbWUsICJJRF9JU0FS
MF9FTDEiKSAmJiBpID49IDI4ICYmIGkgPD0gMzEpIHx8IC8qIFJFUzAgKi8NCj4gKyAgICAgICAg
KCFzdHJjbXAocmVnLT5uYW1lLCAiSURfSVNBUjVfRUwxIikgJiYgaSA+PSAyMCAmJiBpIDw9IDIz
KSB8fCAvKiBSRVMwICovDQo+ICsgICAgICAgICghc3RyY21wKHJlZy0+bmFtZSwgIk1WRlIyX0VM
MSIpICYmIGkgPj0gOCAmJiBpIDw9IDMxKSB8fCAvKiBSRVMwICovDQo+ICsgICAgICAgICghc3Ry
Y21wKHJlZy0+bmFtZSwgIklEX1BGUjJfRUwxIikgJiYgaSA+PSAxMiAmJiBpIDw9IDMxKSB8fCAv
KiBSRVMwICovDQo+ICsgICAgICAgICghc3RyY21wKHJlZy0+bmFtZSwgIklEX01NRlI1X0VMMSIp
ICYmIGkgPj0gOCAmJiBpIDw9IDMxKSB8fCAvKiBSRVMwICovDQo+ICsgICAgICAgICghc3RyY21w
KHJlZy0+bmFtZSwgIklEX0FBNjRGUEZSMF9FTDEiKSAmJiBpID49IDIgJiYgaSA8PSA3KSkgeyAv
KiBSQVogKi8NCj4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgfQ0KDQpXZSBjYW4ganVz
dCBtYWludGFpbiBvbmUgY3B1LWlkcmVncy5oLmluYyBhbmQgaGF2ZSBSRVN4IGluIHRoYXQuDQoN
Cldhcm0gUmVnYXJkcywNCktodXNoaXQ=

