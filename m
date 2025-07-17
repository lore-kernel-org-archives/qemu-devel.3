Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7844EC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTaw-00030F-Ok; Thu, 17 Jul 2025 14:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1ucQoH-0003xP-Pi
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:46:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1ucQoF-0007js-6P
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:46:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCEggo007306;
 Thu, 17 Jul 2025 15:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pdgAa3LUoV3xjG88FodHcfQz
 5GTH0ydu6+q2VI1Mo+A=; b=VYw6y4LA+o059wIFnAdVpIvmJR2mzdeNFXYCR7/2
 ZbcFx62RREnfDz8Pg5j14QZBYusktKmILLN7R1kK3Vs1811gqjeengV//PjvHmy1
 gWYjzwjhADGWCDySZnTG16t76FRPlTw6YdMqQXL6ce2gko2YnpadnVdfOo1SFdaA
 zsMEmSxB2C83WlPUS8bTXKGJQ5cCf2tFpYTzN69496y/RYmmPOJSuzRCLri+i3mQ
 3+Vk3X3obrdVBi1Oohe8mHx01wl4cJ95SBIwX+wzGVQyijw4ScUC1lM3WUaqT5zN
 5FcorfTzhv15I+axgpFDJbvKHntu+vZco+YXkT1QNKogCA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca9dwb-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Jul 2025 15:45:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLJVRiDY0HhuwWGrZmu8ZshMh4aBAFS2koSY2AbP18JNL/H5wJEgrOAj4JyhxkjYTX1xUGAG2A3bi2bIM0j0BjHJ3IpvtmLEvsOOjcYf/u6Cxrt/g6HCch+XDNQ3DqM9zs/yS/E7EMvfivoCWckauK1eJu7RICZX62b96gmB0Yt1fByRe1L2Frv6XK3RdJscg5s4rKy0+wpBCUgN9bVvDFQrikxNywdIHPfq7IHIBwYZLOw2S+NA6C4JXD5AX7NBZl0Ava78p+S+L/rWQFkWdt55QUe/4zlQhv/npuMiZkd3Qm0ic0Rl+RaIqmMSSDa/qbr3EATinN/MqXKPUF3yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdgAa3LUoV3xjG88FodHcfQz5GTH0ydu6+q2VI1Mo+A=;
 b=SrUlXyFWVLqGE+Uk9VheaIMpuwg4Ay7KeVK7mzLZTgHYEKXxHLyiJZnBoLdMP6ZSwjGEU8uw74Bluz9W0ACBYk5e3a/ozXNcXg5C+fFzSbg519Ec1omr6Uhh2XQB286C928wgoM3/YDOmx3OT2FhQQiFKG4sDH43M0/RgFJvPmyF330heachuQyW/eLkKrlmyFhiXotj9+2hEnXKQpDxud64vASGRVjPf2f8AMPwMvW8kvHrr/TciTDTHbK0zTLjfpmlELuAii6utn0l33kusCZToun153IJz9IjS9zYxW6b2GYaO/lZhvTb8FXNm1lmb6rweqlodDxg0dTj3O751w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by DS4PR02MB10844.namprd02.prod.outlook.com (2603:10b6:8:2ab::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Thu, 17 Jul
 2025 15:45:37 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:45:37 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>, Danny Canter
 <danny_canter@apple.com>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Joelle van Dyne
 <j@getutm.app>, Marc Zyngier <maz@kernel.org>, qemu-devel
 <qemu-devel@nongnu.org>, Alexander Graf <agraf@csgraf.de>, Ynddal
 <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>, Roman Bolshakov
 <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
Thread-Topic: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
Thread-Index: AQHb9XnZWftNeaLjp0eXvxtixxiKrLQzEqOAgABDgYCAAQTxAIAAUTQIgAHETgCAAAWIAIAAAg39
Date: Thu, 17 Jul 2025 15:45:37 +0000
Message-ID: <CO1PR02MB86174C98FACECFFD6116231B8F51A@CO1PR02MB8617.namprd02.prod.outlook.com>
References: <87zfd5zouv.fsf@draig.linaro.org> <86wm898yf4.wl-maz@kernel.org>
 <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
 <03A3BBBF-6A01-4ECB-BE50-8103B9201528@apple.com>
 <87a554z5wp.fsf@draig.linaro.org>
 <B08AAF88-3770-478A-8589-ADB407878B19@apple.com>
 <CAFEAcA_s2zXkSZCWXqJ7nWTka5wwBPiKJyHmYE7fGr2=fNsOvw@mail.gmail.com>
In-Reply-To: <CAFEAcA_s2zXkSZCWXqJ7nWTka5wwBPiKJyHmYE7fGr2=fNsOvw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|DS4PR02MB10844:EE_
x-ms-office365-filtering-correlation-id: 3fbea751-6a89-4490-19d4-08ddc548f9e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ODc1OVNuWXF6REFYWlVkY3UwYTBhc2ljQk82SzMza1FmZ0FUNWVuQmExUGln?=
 =?utf-8?B?VWw1cG4wcTd5RjRZMWdBQWgrSjF4UURJdjBxRjlCQTdYNDFPSkRSMmVLTndS?=
 =?utf-8?B?eG1CYXNSc3EvUlFkdGZkWForRlNFTHpEYkxQK1NHaDVnUUxuSnhSYXU0ZUdZ?=
 =?utf-8?B?bWtpeUh1cWQwZDJONTV0d3FXWC9jVjlRbVE4QWdRSGwzZGtBQXVvYzI0cGxr?=
 =?utf-8?B?MTNiNzRHejlvNXU2aU9ZNXgxWC9hV3JnaDVacTIrYmFJN2NETWMvdDFheHda?=
 =?utf-8?B?UHdmT3hBSnV6cTU4YkFmdW9oditBR3JDR3ZabGtDRG9kMmFscWprRFNzQm4w?=
 =?utf-8?B?aURiVDdiRGNBcHlyZ2lEMzFneU5oRUFod0N3N1ZLeTZEWnJrYWF3NXpuMlBk?=
 =?utf-8?B?ejYyaXlpdUsvejFOckJaV3pwS25maFFhNjhJREVDVlVPMUcvUVMyMWYxRzM1?=
 =?utf-8?B?Ny9sdysyVFV4T2gyQm1EMURtM3drYmJxWVFnek1taFBkaWlPY2xkTU9EbmNW?=
 =?utf-8?B?SzBWWFlDNDBVZFBHTmRHR1NsWlovWGxnTUViNFhIZlBIa3g5RGhrTzIxN2ZO?=
 =?utf-8?B?cnQvLzl6MWZpMTkxSkljcXZLdUhTeU8rNEtyVVJoVS9nRysxUnFPclcxdXV6?=
 =?utf-8?B?N2thdFVXcEFVMEUyMTRGL0tOUCtwZTRiUkZjQlVZcHFEK3V3RGZqM0xSRkJZ?=
 =?utf-8?B?M28wbUxNL21TK0lQN3VxcmFVazZVM01HM1dmc2Z1WFhsZWJCWTdVTHdJSEFP?=
 =?utf-8?B?eTNKY1VJZHB6ZkRBRGhhREZuenBWQlgvaUNzZkRJTWdhYmVLSlJ1R1lOZU1m?=
 =?utf-8?B?eFBBeXgzaVd0eEE2Qmc0VXk2ZnlQRThsODN6TE1CaHY0dWV2SXE1NnhJSTN0?=
 =?utf-8?B?Y01sMDkrNGN4NldsZlpML0kwbzE0V1RDVFVoMjNrcTRwVkVpMHFYdGlHOHhW?=
 =?utf-8?B?MC80VzZOemoxVFJtcGxIRE0wSUtXZnJpQ0ZuYk1HeWlwQWpJMm5DaW9mNU1G?=
 =?utf-8?B?RHMrRmEyekU1NEowNVAya3pzTWR1ZlZvSXFIRlZlR29meEx2RGpOTDRaV29M?=
 =?utf-8?B?S3VmcXlTZUQzOWRyZ2hRSWgwSDFYWGtjam9zRTFOWTluUm40Y1lwV3FSTW1R?=
 =?utf-8?B?NTJ5ZDVrM1B1QU50aTBmQk1MOVFZb016YXF2VDcxemtiVjQzQ3NZVVpNQkpi?=
 =?utf-8?B?Y1A0NklxN1NuU09qWkFpZ2N2SG1JdVgxdjJ1TVExdnpxRmFldG4vZkRGRUV1?=
 =?utf-8?B?SHRxaGFoSjczVVBlZS9DZTQyM1JOS2JlMVFWZ3llWnFmREVIZmtvTWxkbStD?=
 =?utf-8?B?RzU0Rkl1VDRoNlcrcVRJOE9LemEzSXZkazRuMVJ4Sk9NWkgzMVA3blFEeTha?=
 =?utf-8?B?NlBGZ2pEaTNlZWZhL0VZSGVnYmsycVQvWlB5cGZjS0ZtekFYWlhmS0daSmZN?=
 =?utf-8?B?ZkU0V3c3NEwwQk9CZlZ1Qm1sUzdOQzlzc09yL0puUzZOdSttT2k5TVJHd1pw?=
 =?utf-8?B?MmpjWElNNW0yNGFhZWtnU3AwWFRVUDFHLzVTOFhaQVpqUUEwSXV4Y2xJaXpL?=
 =?utf-8?B?STlVcE9wejNwbWJ2dU5VU25WZ0xLZG9zSmdWR2dOTmNCNEF2bzBuNDA0a1JL?=
 =?utf-8?B?U2xHaFdrZmFLZVBxdWs0VDFKU2xpdE9BKzVWODF0Mk1oYUt5WG5CR2xVTVdD?=
 =?utf-8?B?VE9FVFUvaEd2WTVaL0pwQ01PWGFleHp6MThyUmpNWjA2QTBTdWlFUG5hZGlQ?=
 =?utf-8?B?ZGJ0a2hvN1dxWmhCMWdsaEhzQkFib21aaUE0bEgzR2RETjRJUnk5Y2trK1Bz?=
 =?utf-8?B?S1dKWlIyY1U0eHdTSFEvLy94aHg5RDZuL1lVME5mbGFkb2R4enhWV1d6bHph?=
 =?utf-8?B?dTVXaE15Zm9wdW5RNWhhd0tTcUNPQXBYSXREUk1MOFpPbC94Qnozc3JFTE51?=
 =?utf-8?Q?QO3BJXIetM0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjVrS1VzRlFXZ2lsd3oydDYwaUxSY0ZXREZ2cEsvL2h4bVFTZzNWTndDam5M?=
 =?utf-8?B?bk50bzN0dldhTm03K1NScmEyREh5OU9JYnpRTDJMckI1T3ZOUGlsN3N3emxN?=
 =?utf-8?B?WDZDRkVEaGRGbHVBelBsNU5RR09kV0dFTUVZd1B0dVExMy8vcVk1NmJicWtH?=
 =?utf-8?B?TERHaDIwVGJJc3orNkxtNEhMd0owNGxlTGhybXl2a2lGeFl5bWRzd3JmSHZO?=
 =?utf-8?B?RUlZSXVPcFpXNGZlQnM4NVVLOTZJaGpmYTdUVy9OTXdzNmsvai8rakxJVWlQ?=
 =?utf-8?B?cGE0SDlPOVVNVC9vSFJyZml2dENBZTJQa0xWOTVCSEhiOXBYek5xMmt3K0dl?=
 =?utf-8?B?RVFMQnJPQjlJNGNEOXFENHhUNnI2dEVTVXlieGtHNEJVZ1RmcWhOdUsySGx4?=
 =?utf-8?B?QWliK1JPcFg5bm5oakFmRHIxeUxMcGlKT3BNMmxxUGI1ZmIwcHlhQ1FjSHpk?=
 =?utf-8?B?WU1xbXZlRWsreWxJSFBXZ01abGJKSDN3L2wwRjhNR0RUdEt2QnNUKzhHdU4v?=
 =?utf-8?B?MWZyeVJEWWZRNVpMM0NJNW02UmR5WGREeUlVVklobkpzanBQTnRRVWN6Q3ZZ?=
 =?utf-8?B?S01SaDZvdURqYm1lZUpCRnJlOFRRbVJ3N05YbW9SbWlsMkVPTk9hR3RjUGU4?=
 =?utf-8?B?NmNuYTlXMDgxTkEvRXdBWWl2a3d3cE9yVDFaZDA3NGF3aGEyd1UyUDI1Y0hC?=
 =?utf-8?B?N0o3QUpXRFBpVlFxbElkcDB2ZmhSb1NiUlp1ZXJzam9IWTlIOWFmdVhnaVpG?=
 =?utf-8?B?dThVcWVpYU9neVBMWWVYYkJnWFF4bW9ZN0xTM05vdjcrVys3UFAwdGMrK0JX?=
 =?utf-8?B?WlZHcVUzUVdoMys2Z1YrNEJraTJPeDNKemF5MHliWXJoN2pzSFZFVkRxWXRT?=
 =?utf-8?B?Rys1ejBmaURDa3dFNTlXOU5hWWU2SDBIV01nRFR5RTk0T2xBWk1jWFpBUUFK?=
 =?utf-8?B?aUgyd3ljZUJHNVREbXFoU3I3ajNGZHp1V2xDVi9vUFRMbXNnVDM5dGk0bmM2?=
 =?utf-8?B?alVubGhyaHJnUDVxMGVXc1JKMUIwRWV3UkgzSjZaQzE5bHhFb1FjWnBkMWZo?=
 =?utf-8?B?UHBRanlMN2NUbGlsRVlCT292L0RtVnhyaWtJNC8zUldrUmhjeHpZeVVpcVQ4?=
 =?utf-8?B?SHg4TTY1Szl1Vy9FVnlDNTJqQW1yalZYNms1cm1jNHAvTUFWWTZkcm1sNzVC?=
 =?utf-8?B?YzBXcEYyUzdhT3NBUTBHYndDUXhXOXlZMGhOMmp3U2txMkVNdENYc0RKVVlr?=
 =?utf-8?B?Wi9CWVVyUmVIQVRWU2gxcGpOSExRZmhqdjZ3VVZkVUlHUCtkN3Rjb0UzTGFm?=
 =?utf-8?B?cUhzSzdtZUhGTVU5YXdvaEJYM3pFajVSWFJIZWJVM0Fid1Nlbk90Z1pCRXlQ?=
 =?utf-8?B?RUM5UVFaMFRHWVZDNWE2RDZ4cFQrUkNzTGtqd3J3Tkh1MWVYNm56c0M0aXZT?=
 =?utf-8?B?NjhFcnV5c0RjengzRGw0T0cwQ0RrRUVjeXZ2RXJRWFhya2dmVit2UTZPNHVZ?=
 =?utf-8?B?WUthRFY1Tmhad2RmWmVpUEl6bnRXYzVnMlFqVHJ1MlppRVg0SzA3NFUwTXA1?=
 =?utf-8?B?a3lGUHB4eGRXRlRWUEptY1NmYmF0ZjRlTEpCUnRkdEUyL0ZTLzdSbGNTeDRs?=
 =?utf-8?B?WkZ1SUcxWjZDenVXclJZYnFBWUNSSVlRZHFjSlNyMXk4djBVMHN4UWJvaTZ2?=
 =?utf-8?B?YjNlbE90MUNjVjNrWEFidHdNcnZ3T1A2UVljK0JyY0xpWDJMVHhYL0tldHQ5?=
 =?utf-8?B?Y0U0MDh2YnlOeFhGR1Q5bTA1N01QN1VCLyszSWs3VllrYkpEaXVIS1pQNGZB?=
 =?utf-8?B?Z2hCOVRLc001VGlNZ3NwNzNjSlJna05pb0NSa1BtdDc5aXZ1YXZ5V0h4RXZp?=
 =?utf-8?B?S0NuSzhOZzN2YlVuVkVnVVEvcVJIVE9mQ09XVlEyZ3UvOGxVWWtZTFVXa1NF?=
 =?utf-8?B?QzlTQ1RxWEprd05ZY0M4VC92dWxBbnFBb3MyVVh1dFJpa0ZxQVlGNXZwYXBm?=
 =?utf-8?B?YU1KZTZHWGpTdE1PaXcxWHNySDhlQXNOZFpNb1FlcFNjZ2lwRUFRQitqbzBQ?=
 =?utf-8?B?ZVQwUFRERytSNzFhYnRvNzMyaTc0ajd4KzFvVUpYSHNqVEF1VmZxYlpMc1Q2?=
 =?utf-8?B?QThIUG1LR2hTcVFFNmU1azhjdWkzVnJ2WnpBdUJDbkJnU0V4enk1S2RqYTcx?=
 =?utf-8?Q?IQuR0jdAh9z82oFK020rFPQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO1PR02MB86174C98FACECFFD6116231B8F51ACO1PR02MB8617namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VHbTMR2V5oQvEdriB7ej7HuwY3fUg+2WmW7S9oEsdEmv3k7RwICrH+YByQGLn85B3oRFq1OFp729fP5SL6JmWTDb/hlVv/kgzvNdFxAvlW39ztLnlXBLNI5irCi9KKCDZ+eUypNcvFC1Xs31Dg41O3bKCfIsjjWtFyWj/JL0qmkfyuwXDfyF6nBfNlzt+xpC0Hyf+0NE9qhIcaVIxzPCasvi1bF6eqggUUSk+T0OWGGuajhUy+0RHua4UYcApfwnd05N8PlQVr4esnS05QzMwFOEaSXH797EL30L0GRWRTt6zRqVzNWJocylvUqJTu7aPncHYtAELlD5Q0Nm9+kavIMp6OlxbXM0Xh93Khv7E4Y+RNElX8ie6mlkI0tpyPwkIZ54CSzwWDjaJc81cAhbr76csN/35QJJczXacKDDvxBem7FoYcFAmhiXO31ssXpKxglRLPKrdqSi+BVncSvpJ/kNRYZlvQY2jEylkYbsLXK9huzw5yYPNWikIlBmKlb1aD92ZHsmOxQ4dC6aF84Kg8XBHn27bnri2ADiEGgKe5RaTKx9DLD2HEu4UkJ7wmWDT5c/FBPyvvUGB9ls6/WDRMIeFCFcusEemyQlF04/bNGwvcd6h35CohPopZdG0r5R
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbea751-6a89-4490-19d4-08ddc548f9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 15:45:37.6374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsFNA3Vle4hPKDpoqexANshCPP28EuuhFMwfm06P+tg3rkTGbMP4duo3nZU/8id6/WxzrRNudZz6d909OFiyLyfG7ll8nKbZyCaOHzJGPpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB10844
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzOSBTYWx0ZWRfX2qUtP3TsSzaN
 22CTc7Tlkc7/UWa7pmDGJxxyT4uWwh9NvHtVIvKbVVCjcSjJei2Z/gbajPLudrFe++92UwUucgV
 URElu6xT6XVd2QufxbnTqUmFXPdCFG+a4hDSqgnvNSaKpjA5bdJ3LT4SgO1oMFNdG+xwKbDcX47
 VzTU4p/ICEjKiupSeN+LMsEB1x6USkSAekMCOUiQE9k6DHxQMCwNiHtrIKTmwTLfuZOx1NMzJiU
 04bkh7uPj2VdrZ4U2hUHQ5sxCrSSmA6/QQATb6m3Tq3I0PLn7Na9lpy1OyrryeNCMRFQzbkGHK4
 uKPonDkwRkY8YFUt6Hd8DVeVChTQ5GulM1B31H4ea5ZtLfqQAdYPp72Ba8MvSGc4vhzPzFmVjAc
 Sdxnc3oyqZh/mbvb1+ETrRlHeggewsHogZRNFKr9raBGGfihMKyluY9KJyHLNuVAC9l1fL8M
X-Proofpoint-GUID: UabIOZBNu2ZM8sLe_VX3K-iEYnf3FxNf
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=68791aa5 cx=c_pps
 a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=_EeEMxcBAAAA:8 a=t-IPkPogAAAA:8
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=69wJf7TsAAAA:8 a=lB0dNpNiAAAA:8
 a=2ORJyF7xAAAA:8 a=EUspDBNiAAAA:8 a=j20NNIL-lD1gF2nEcA8A:9 a=QEXdDO2ut3YA:10
 a=05P37ETJZswX0SZU:21 a=_W_S_7VecoQA:10 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=c-ZiYqmG3AbHTdtsH08C:22 a=4vzVo7jydstbtNDrrb0h:22
X-Proofpoint-ORIG-GUID: UabIOZBNu2ZM8sLe_VX3K-iEYnf3FxNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_CO1PR02MB86174C98FACECFFD6116231B8F51ACO1PR02MB8617namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U28gbG9uZyBhcyB3ZSBjYW4gYWxzbyBzd2l0Y2ggdG8gdGhlIGVtdWxhdGVkIEdJQyB3aGVuIHdl
IHdhbnQvbmVlZCB0byA6LSkgKGxvb2tpbmcgYXQgeW91IEtWTSA6LSkpDQoNCkNoZWVycw0KTWFy
aw0KDQpTZW50IGZyb20gT3V0bG9vayBmb3IgQW5kcm9pZDxodHRwczovL2FrYS5tcy9BQWI5eXNn
Pg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IFBldGVyIE1heWRlbGwg
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NClNlbnQ6IFRodXJzZGF5LCBKdWx5IDE3LCAyMDI1
IDU6MzY6MTggUE0NClRvOiBEYW5ueSBDYW50ZXIgPGRhbm55X2NhbnRlckBhcHBsZS5jb20+DQpD
YzogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPjsgSm9lbGxlIHZhbiBEeW5l
IDxqQGdldHV0bS5hcHA+OyBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgcWVtdS1kZXZl
bCA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgQWxleGFuZGVyIEdyYWYgPGFncmFmQGNzZ3JhZi5k
ZT47IFluZGRhbCA8bWFkc0B5bmRkYWwuZGs+OyBDYW1lcm9uIEVzZmFoYW5pIDxkaXJ0eUBhcHBs
ZS5jb20+OyBSb21hbiBCb2xzaGFrb3YgPHJib2xzaGFrb3ZAZGRuLmNvbT47IFBoaWwgRGVubmlz
LUpvcmRhbiA8cGhpbEBwaGlsam9yZGFuLmV1PjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPjsgUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxp
bmFyby5vcmc+OyBNYXJrIEJ1cnRvbiA8bWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tPg0KU3ViamVj
dDogUmU6IEhWRiBFTDIgc3VwcG9ydCBpbiBRRU1VIChha2EgRkVBVF9OVi9GRUFUX05WMikgZm9y
IE1hY09TDQoNCldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2Yg
UXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5k
IGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KDQpPbiBUaHUsIDE3IEp1bCAyMDI1IGF0IDE2OjE2LCBE
YW5ueSBDYW50ZXIgPGRhbm55X2NhbnRlckBhcHBsZS5jb20+IHdyb3RlOg0KPiAtIFRoZSBuZXcg
R0lDIEFQSXMgdGFrZSBjYXJlIG9mIGludGVycnVwdCBpbmplY3Rpb24sIGFuZCB3b3VsZCBuZWVk
IHRvIGJlIHVzZWQgaW4gY29uY2VydCB3aXRoIHRoZSBFTDIgQVBJcyBpZiB5b3UgbmVlZCBpbnRl
cnJ1cHQgc3VwcG9ydCAoaGlnaGx5IGxpa2VseSDwn5isKS4gVGhpcyB3b3VsZA0KPiBiZSB3aGVy
ZSBJ4oCZZCBpbnZlc3RpZ2F0ZSBvbiB0aGUgUUVNVSBlbmQgZmlyc3QgdG8gc2VlIGlmIHRoaXMg
d291bGQgZml0IHdpdGhpbiB0aGUgYXJjaGl0ZWN0dXJlIHdpdGhvdXQgYSBidW5jaCBvZiByZXdv
cmtzLiBodHRwczovL2RldmVsb3Blci5hcHBsZS5jb20vZG9jdW1lbnRhdGlvbi9oeXBlcnZpc29y
L2h2X2dpY19jcmVhdGUoXzopDQoNCkFoLCBIeXBlcnZpc29yLmZyYW1ld29yayBzdXBwb3J0cyBw
cm92aWRpbmcgYSBHSUMgbm93PyBXZQ0Kc2hvdWxkIGRlZmluaXRlbHkgc3dpdGNoIHRvIHVzaW5n
IHRoYXQgaW5zdGVhZCBvZiBvdXINCnVzZXJzcGFjZSBmdWxseSBlbXVsYXRlZCBHSUN2MyB3aGVu
ZXZlciB0aGUgaG9zdCBzdXBwb3J0cyBpdC4NCg0KdGhhbmtzDQotLSBQTU0NCg==

--_000_CO1PR02MB86174C98FACECFFD6116231B8F51ACO1PR02MB8617namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBzdHlsZT0i
Zm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCAtYXBwbGUtc3lzdGVtLCBS
b2JvdG8sIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsiIGRp
cj0iYXV0byI+DQpTbyBsb25nIGFzIHdlIGNhbiBhbHNvIHN3aXRjaCB0byB0aGUgZW11bGF0ZWQg
R0lDIHdoZW4gd2Ugd2FudC9uZWVkIHRvIDotKSAobG9va2luZyBhdCB5b3UgS1ZNIDotKSk8L2Rp
dj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfTVNGb250U2VydmljZSwg
LWFwcGxlLXN5c3RlbSwgUm9ib3RvLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250
LXNpemU6IDEycHQ7IiBkaXI9ImF1dG8iPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250
LWZhbWlseTogQXB0b3MsIEFwdG9zX01TRm9udFNlcnZpY2UsIC1hcHBsZS1zeXN0ZW0sIFJvYm90
bywgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyIgZGlyPSJh
dXRvIj4NCkNoZWVycyZuYnNwOzwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9z
LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCAtYXBwbGUtc3lzdGVtLCBSb2JvdG8sIEFyaWFsLCBIZWx2
ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsiIGRpcj0iYXV0byI+DQpNYXJrPC9k
aXY+DQo8ZGl2IGlkPSJtcy1vdXRsb29rLW1vYmlsZS1ib2R5LXNlcGFyYXRvci1saW5lIiBkaXI9
ImF1dG8iPjxicj4NCjwvZGl2Pg0KPGRpdiBpZD0ibXMtb3V0bG9vay1tb2JpbGUtc2lnbmF0dXJl
IiBkaXI9ImF1dG8iIHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX01TRm9udFNlcnZp
Y2UsIC1hcHBsZS1zeXN0ZW0sIFJvYm90bywgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsg
Zm9udC1zaXplOiAxMnB0OyI+DQpTZW50IGZyb20gPGEgaHJlZj0iaHR0cHM6Ly9ha2EubXMvQUFi
OXlzZyI+T3V0bG9vayBmb3IgQW5kcm9pZDwvYT48L2Rpdj4NCjxociBzdHlsZT0iZGlzcGxheTpp
bmxpbmUtYmxvY2s7d2lkdGg6OTglIiB0YWJpbmRleD0iLTEiPg0KPGRpdiBpZD0iZGl2UnBseUZ3
ZE1zZyIgZGlyPSJsdHIiPjxmb250IGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiIHN0eWxlPSJm
b250LXNpemU6MTFwdCIgY29sb3I9IiMwMDAwMDAiPjxiPkZyb206PC9iPiBQZXRlciBNYXlkZWxs
ICZsdDtwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcmZ3Q7PGJyPg0KPGI+U2VudDo8L2I+IFRodXJz
ZGF5LCBKdWx5IDE3LCAyMDI1IDU6MzY6MTggUE08YnI+DQo8Yj5Ubzo8L2I+IERhbm55IENhbnRl
ciAmbHQ7ZGFubnlfY2FudGVyQGFwcGxlLmNvbSZndDs8YnI+DQo8Yj5DYzo8L2I+IEFsZXggQmVu
bsOpZSAmbHQ7YWxleC5iZW5uZWVAbGluYXJvLm9yZyZndDs7IEpvZWxsZSB2YW4gRHluZSAmbHQ7
akBnZXR1dG0uYXBwJmd0OzsgTWFyYyBaeW5naWVyICZsdDttYXpAa2VybmVsLm9yZyZndDs7IHFl
bXUtZGV2ZWwgJmx0O3FlbXUtZGV2ZWxAbm9uZ251Lm9yZyZndDs7IEFsZXhhbmRlciBHcmFmICZs
dDthZ3JhZkBjc2dyYWYuZGUmZ3Q7OyBZbmRkYWwgJmx0O21hZHNAeW5kZGFsLmRrJmd0OzsgQ2Ft
ZXJvbiBFc2ZhaGFuaSAmbHQ7ZGlydHlAYXBwbGUuY29tJmd0OzsgUm9tYW4gQm9sc2hha292DQog
Jmx0O3Jib2xzaGFrb3ZAZGRuLmNvbSZndDs7IFBoaWwgRGVubmlzLUpvcmRhbiAmbHQ7cGhpbEBw
aGlsam9yZGFuLmV1Jmd0OzsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgJmx0O3BoaWxtZEBsaW5h
cm8ub3JnJmd0OzsgUmljaGFyZCBIZW5kZXJzb24gJmx0O3JpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmcmZ3Q7OyBNYXJrIEJ1cnRvbiAmbHQ7bWJ1cnRvbkBxdGkucXVhbGNvbW0uY29tJmd0Ozxi
cj4NCjxiPlN1YmplY3Q6PC9iPiBSZTogSFZGIEVMMiBzdXBwb3J0IGluIFFFTVUgKGFrYSBGRUFU
X05WL0ZFQVRfTlYyKSBmb3IgTWFjT1M8L2ZvbnQ+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPC9kaXY+
DQo8ZGl2IGNsYXNzPSJCb2R5RnJhZ21lbnQiPjxmb250IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTFwdDsiPg0KPGRpdiBjbGFzcz0iUGxhaW5UZXh0Ij5XQVJOSU5HOiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBv
ZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy48YnI+
DQo8YnI+DQpPbiBUaHUsIDE3IEp1bCAyMDI1IGF0IDE2OjE2LCBEYW5ueSBDYW50ZXIgJmx0O2Rh
bm55X2NhbnRlckBhcHBsZS5jb20mZ3Q7IHdyb3RlOjxicj4NCiZndDsgLSBUaGUgbmV3IEdJQyBB
UElzIHRha2UgY2FyZSBvZiBpbnRlcnJ1cHQgaW5qZWN0aW9uLCBhbmQgd291bGQgbmVlZCB0byBi
ZSB1c2VkIGluIGNvbmNlcnQgd2l0aCB0aGUgRUwyIEFQSXMgaWYgeW91IG5lZWQgaW50ZXJydXB0
IHN1cHBvcnQgKGhpZ2hseSBsaWtlbHkg8J+YrCkuIFRoaXMgd291bGQ8YnI+DQomZ3Q7IGJlIHdo
ZXJlIEnigJlkIGludmVzdGlnYXRlIG9uIHRoZSBRRU1VIGVuZCBmaXJzdCB0byBzZWUgaWYgdGhp
cyB3b3VsZCBmaXQgd2l0aGluIHRoZSBhcmNoaXRlY3R1cmUgd2l0aG91dCBhIGJ1bmNoIG9mIHJl
d29ya3MuDQo8YSBocmVmPSJodHRwczovL2RldmVsb3Blci5hcHBsZS5jb20vZG9jdW1lbnRhdGlv
bi9oeXBlcnZpc29yL2h2X2dpY19jcmVhdGUoXzopIj4NCmh0dHBzOi8vZGV2ZWxvcGVyLmFwcGxl
LmNvbS9kb2N1bWVudGF0aW9uL2h5cGVydmlzb3IvaHZfZ2ljX2NyZWF0ZShfOik8L2E+PGJyPg0K
PGJyPg0KQWgsIEh5cGVydmlzb3IuZnJhbWV3b3JrIHN1cHBvcnRzIHByb3ZpZGluZyBhIEdJQyBu
b3c/IFdlPGJyPg0Kc2hvdWxkIGRlZmluaXRlbHkgc3dpdGNoIHRvIHVzaW5nIHRoYXQgaW5zdGVh
ZCBvZiBvdXI8YnI+DQp1c2Vyc3BhY2UgZnVsbHkgZW11bGF0ZWQgR0lDdjMgd2hlbmV2ZXIgdGhl
IGhvc3Qgc3VwcG9ydHMgaXQuPGJyPg0KPGJyPg0KdGhhbmtzPGJyPg0KLS0gUE1NPGJyPg0KPC9k
aXY+DQo8L3NwYW4+PC9mb250PjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_CO1PR02MB86174C98FACECFFD6116231B8F51ACO1PR02MB8617namp_--

