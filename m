Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E23C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 09:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u25Lq-0004p4-7y; Tue, 08 Apr 2025 05:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1u25Lo-0004op-9y
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 05:34:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1u25Lm-0000Kh-8Y
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 05:34:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GLQp019229;
 Tue, 8 Apr 2025 09:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=b66O06yL/ykfATaNzDC0FmmtP8pw3XsUkI95lvQa6EU=; b=Re
 gN9C+aCJqfaWrGoR7N3y0cCEEFRrJHv7Ho9wnVXsylD5x/RebAU3DffzU8ltATaB
 OazrpYu1xoYxkeRjmJ1CQRiDI2iPOAn4vzULWEXB8ajEYi9EM7+ZEp7531qQuh3x
 Yz3Sii7I0Jm5ZiThw9zL8lWPIZc04bETJb7NY6FatsEW0wfMAf4S0Qn3+JD4mns3
 nyIJMXnyQVOPcg5mrSVVKpP/DKpT/znwS6AgluMuLp74T/uo2nOMUvDlsgZ5Vg9w
 uxwuiBcsPnvQEoIqCzz+KAP2wv9N1qxrtmnqJ67nia5klogsOwUmbnG9X0DCNK1z
 phTtAj5aJLBXA6a3+Btg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgf99t-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 09:34:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvDzAX/TrLnJTmLEGfptPncMgeA2Lb+jwCd6Uh44Qiz1khL+GfslSp7vPD7WjsdmXwmG51rN3uYAkwdS5rwGYdd3y+snVGt7ZKp3WynsehBQtnIqWsKpY7/BkSbqUKqRengCWiUMkRUppoHVVkN24uhZPOzWvSJJX3Sp1Qzpqw9Kn7cSn4+H6A67p1OiJxheWmUx/hJTVM1LDRNfKqQROYbFXO6iwcUEoScFpIR0NoffVoe9CZk3VI+sAi6MkPfGB1IMSgEKz0xliUOAfmWtkL1J56+tpmKXC5CqGeKE8CmUQRloTp47LuhKL36oQh/9rjdte4F6yzK8xsMN2BHoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b66O06yL/ykfATaNzDC0FmmtP8pw3XsUkI95lvQa6EU=;
 b=WK23nY569w5RJ9+pGK7kDsbaP9tFwMomcqUa72A2grzYa/9sFMId93d3haw37/vwi5DrYmHGOmtWfX/G5RS81aI6vJCcMQ7EDxbMrDSXy2T+LViNLrNnNKmuWH1MN6p4wMGsKvIuQaRMGajVK0elW/+UUgh2FYdwH4xNY7qPoROOOM9UiKBp+r5Gb/WjlZlPmp22U4Qgp2r1SlglMuWR3woYbKJzEuF97h3ktMSBcS9riJ44MZiDPTUtrizm9Ja5+1UGHurttWXCYr5+hnpFgkcLkXZp9NsGMLis/xBR/Bx7FzoyHPUiHElHEcTMWDhXnfv9QflwJjQD6k7I5gFDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CY4PR02MB3174.namprd02.prod.outlook.com (2603:10b6:910:77::26)
 by CO6PR02MB8803.namprd02.prod.outlook.com (2603:10b6:303:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Tue, 8 Apr
 2025 09:34:19 +0000
Received: from CY4PR02MB3174.namprd02.prod.outlook.com
 ([fe80::6071:b74:af7f:ba09]) by CY4PR02MB3174.namprd02.prod.outlook.com
 ([fe80::6071:b74:af7f:ba09%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 09:34:19 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Alwalid Salama
 <asalama@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 1/2] accel/tcg: add get_virtual_clock for TCG
Thread-Topic: [PATCH 1/2] accel/tcg: add get_virtual_clock for TCG
Thread-Index: AQHbpIz+PwnmGEbrzUqamrIv2DpbtLOZdRKAgAAIDHSAAAyIAA==
Date: Tue, 8 Apr 2025 09:34:19 +0000
Message-ID: <404302E1-4A41-4E5D-8287-7F7E5D87CFC4@qti.qualcomm.com>
References: <20250403113851.4182190-1-alex.bennee@linaro.org>
 <20250403113851.4182190-2-alex.bennee@linaro.org>
 <84ECF705-6BC3-42C7-9F37-D0C81DFCAF7D@qti.qualcomm.com>
 <87frijhwce.fsf@draig.linaro.org>
In-Reply-To: <87frijhwce.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR02MB3174:EE_|CO6PR02MB8803:EE_
x-ms-office365-filtering-correlation-id: d0deba5e-51a6-41ef-d774-08dd768089c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YnIybFBhY1Q0eHhqM2dOTE1yV3ozTElGanZCL1Q1MkNvWmJNaUd4RytudWlI?=
 =?utf-8?B?em94c1ZQMGZGUFNWMDRtNDVBajJvc3BpQU92OW1hNlo0YXEyMjZjQjNsRUlV?=
 =?utf-8?B?NnNiWm5YQUJkMHhnTWtEdkVFRWhiYzlhNjJHdXpOM0ZKalRLb0UwTnhvUnNP?=
 =?utf-8?B?UStVdjlyS0tFQXhYSXNlSENmY2E4YnFEbGhuRDNpSlRvanlqOC9meDBHVUor?=
 =?utf-8?B?UkUvOHR1SUNqMFpjRSt5bVlMK2t5dGttUFZJOFBzYlF0bnZGb0JscWQ1UEZZ?=
 =?utf-8?B?VkNyNGxhR2Rib3BoN0VNSUFhY2hMZmJvQlBYSngzSXJBNVJoVjloaHNTSVl1?=
 =?utf-8?B?d2o1bitVSDdRZ3ZPRjhVUTUwdFc4dHNIT04yTnBjcWZNb0VjY2VHVExJaml1?=
 =?utf-8?B?cjBCTHh3ZkxYTVFpUUdZMmo2UnVnaERGZ2dGUFNKYXpVbEhYUmppbmZQTzNT?=
 =?utf-8?B?cXVYODFRSGF2SWZ2bTlXOWttRGcrTmd0Z1B5MExmeVZQOUpmVGxBTnRKb1V1?=
 =?utf-8?B?Y3ZaZTV5TmVsaTREbENzaEcra29FVmNEZkNQcHJFd1BXMXpTbE1hRDFRdG1I?=
 =?utf-8?B?N3prdVBLUjJ6dmtKcnVhamVSZzdxazdGQzhOU1YzdjZPUmowMy9BOEVBS2Ny?=
 =?utf-8?B?ZkxReFlrTDJvdnlaVEFUZUNBTVhVTTJodVFhSjJJNG1FYW1Sd3NhN1Y3UjA3?=
 =?utf-8?B?YmZoSVVyRzVvY3I3NUUzYklmdW53bnBEZWtOeURvcnFFazlmV0c2aitTbFRy?=
 =?utf-8?B?OXRqb09kOWlpYmpVYUduUHlISWI0K2RoazRaTEJjeVQyU0sxd3dZMFdTdTBo?=
 =?utf-8?B?cmNZdzBMSHpneGlmUzlvaGxndEVRWUZUM29SbmJVYTBadmFSdnV4L1ZYRXVJ?=
 =?utf-8?B?aVFaK05GcmdyNXdZbkhCK2F6ZWNIMTNwUVBZRXI0dVkvMEovNytGU3JxaEQw?=
 =?utf-8?B?WTZQbzgzUXJORkIveHp2VkxodTRLSTUvYnorNlBEdmlGTWw2SkNodzVqYWRM?=
 =?utf-8?B?b05EUlpEZUo1T2NFb2kwVU1FYmpreXU5eDg5d3RSMXFqNnVGV0hCY1l5Z0VE?=
 =?utf-8?B?VjV5VTNkNXcwUzkrZ1RFVll6eklSZEVPTG9qK2MzV2NJVkNEQVdXQVNHWFIw?=
 =?utf-8?B?Vlp5c3haNmNvM2pKaDFmT0lEa2d0M3lLYXZiRUJGRmF0VGJPL2JiRlM5bVFZ?=
 =?utf-8?B?b3ZUTzNUclgweFJZS1hHZkNDT0tCUjA0TXB6aXhvNnordGhXQTFGQkFJQmQw?=
 =?utf-8?B?QzMrUG5LVklZbDRNWkdJdktjZjFZWTIyUWF2Z2RFMDRkdEtEcWkrSG5xMTdX?=
 =?utf-8?B?ckN0YVhYdW9CbU00alIxZWNHUG00c0JTdXBteHJoSTljcGVJMFdUOEgzMXpy?=
 =?utf-8?B?MTJhclhEdXJtbCttek9vZ0k0L3gycXRSdXN3YUZnUFk4SjlPMUo5OXlvUHFY?=
 =?utf-8?B?Uk9PUGRiR0RWRno4ME5uVWVLRnhpNW5qQWVydThnMmhlQVp1aUxkbHVuZ2Zq?=
 =?utf-8?B?WGozcnp3WjZaSWZGc3pHYmhINnhmTkNYSVVTY0granczc1hvNWsvYTFQNUpu?=
 =?utf-8?B?TU9uUFVBR3FwSFZTVCtid0ZmeEltYU5tVTgxRDlXekZIbklqeitFdXJDRUlN?=
 =?utf-8?B?ZE1BUTREOHlTc2dXeTM2RElybThxRk5LbUs4RklMc0N3WUtESmNTcTJHYkw2?=
 =?utf-8?B?RHpmTzd2YUhId0F3UkdFZnBGUElFZkpZb3pWbnp1UjNrczhUNU83TTVtdmdE?=
 =?utf-8?B?U0xBbVhFdVNxcWJEM2xVVFNIdVRoMEZLYkYxVStjWWJid1RNUU9qYnBRWGda?=
 =?utf-8?B?SzF3Q2M2cVpGRlRYV0ZoaVVTNE9VL01NUmdOelJoU0ZxVW1PS1RNcDdTRUVk?=
 =?utf-8?B?ZlBRVVM4WDVCdlZ1UVREV1A1S0JwcExtR2owMkZVdUFnWm0yNE1JdlIvZ2dF?=
 =?utf-8?B?VmhwS1ZCYStCeVo2Q3Q2WkFWYUo5MnlDaE95ZkplSHpjdmJKUlROVGxEUWRy?=
 =?utf-8?B?bHBLbUg5eVZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR02MB3174.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGJzZE9Jd2NiZUJVVDFUS1A2OE5qaEFRZm1reDF5ZjJobnFvWUhsUjB5TVZk?=
 =?utf-8?B?STZ1V1RWVWs0V0pOK1lQZnVpZGVzTnJZMmxhSzdaTWZ5WFdNVGcvRlhkalhU?=
 =?utf-8?B?V1hVMDFwR205MlRLSk5WU0M1WWFpYW10NnpzZWVrcHQ0TW9jTFVPWTdENTlm?=
 =?utf-8?B?QjA0VFphbVpoQVlEOGFxbUtiSVluU0cwa04rWkhRQ1hpbUx2YldsemJmdHJk?=
 =?utf-8?B?MnY1MEZsWnhsVCttRy9HMDk4K1JwK1JjVTZCWkk1ZkVpNFBDNjZFNCtYUnJC?=
 =?utf-8?B?cTNjaVAzU0ZTRHdpVWJxWkxORytkQktCQkF0RjUxYVN2UjY5Z2lhdXUvWnhJ?=
 =?utf-8?B?L0JQL1IyMjBaMFN4NkVJR3Y4Qjg3dXVMbGlXVGxHalkvbGNIMnE4NG5QT1kz?=
 =?utf-8?B?a2s0V3JNbTJFN0R0WHpKaklYYkIrQjZmbVM2YU1mNFBObmRqSWVoOGd6YzVW?=
 =?utf-8?B?TU1HV0FpWEN5N0FrK2pkZmN1Umc0TXQ3WGtrY0ZGNnJ5VVFYV2tDcFhrY2F1?=
 =?utf-8?B?RWJVT2IwMjFvT3ROVTNaUmlTR1lBdll0Z3A5NmxtbzRaOURHREJqN1pVeFRy?=
 =?utf-8?B?NklDb1lia0FQTW5HVnJTbitDbDB4OHIzeUdtc3ArWkVzbTl6Zkh5a0lORzZK?=
 =?utf-8?B?cExmeXh1QmdDTU5EQllGMDNLZkdDVkFLVmp0TGp0RnE1TUpieGZpZmxEWlhZ?=
 =?utf-8?B?NzhvSy8vSXFzS3BoQzd2VE1Sd25uVVltTk1yNDZ2SmxzMHV0ZC9kenk2UEEz?=
 =?utf-8?B?cG0zZElNZWowN1FsRlcvWnFnWUlFNTNWaGpUVkRTK0dkWUV1aGozQkVtdUph?=
 =?utf-8?B?cHpVRTZkWW5oR0Z1M2JEMlFzaFNHZG53NndleVgrSVFlR1V1dDR2dXNiWTU4?=
 =?utf-8?B?WnV1UDZwRmliMnlia0RhVkJFcEllMzB3d3hiS1RobUNUNk9yc3hvaGtOVVFR?=
 =?utf-8?B?NDNxUFlLWER1NXgwUW5Sb3NvWkl0WmdPdC9FUHZESVNsLzZWYlZJTkdxL0Y0?=
 =?utf-8?B?RllRTytuaThwMnRIays5TGp5cmVBY2QyRyt6OUxPUkVxMnlYR3NNV3lpY1My?=
 =?utf-8?B?eG5GUE5ENFZLR3ExNzRRNzN6cmR3UlpiYjJhRUdlSTU1WkFOSDc2N0MvQWZS?=
 =?utf-8?B?dk9PWjA0TTUxOFpZMmJaSlZpZGhGempENU41ZGtBZm4rNDRaQ1B4VE02SnVL?=
 =?utf-8?B?ajVRMm9lellTS3NhdDJYbllQdUZJYm5ua21DU2hhY0tZekxqZGZDbi9BVzY5?=
 =?utf-8?B?Rk9aaE1JSVorV3hWUUt4MkYzV291dEtkcFhkUWI3aEUxK1BHNUJCVHpQalRz?=
 =?utf-8?B?OUptajFRRGEycEN0RzZudTQwMzBzQzFCVzRNV3BRTUx0WUZpUjJHSHlzMEdx?=
 =?utf-8?B?SGJVbUhvcjBUdGc2NGVIczY0Q1JPRjlhdy9ab2ppdExtU2dOeFNvZXg0ekFz?=
 =?utf-8?B?clBqbnFTTEEvR1ZiQmNxTlRXWkVkck5XeDNuZFNaVisvQzVRWGxpNGQwTnlZ?=
 =?utf-8?B?THUxQzRqMVViUTFxTWpXdTZhK3c3VnA2WUNsK3d6KzdvSWo0U0lxUEVoTmlL?=
 =?utf-8?B?cWlLQlhSRGl3Mncxbk1vZ2ZYVGFneStxNHFSbVc4K0tGOTByanVBaVppYjI4?=
 =?utf-8?B?NzNaSi9oUHhiRDJ1SUxDcE9sbDVqWXhYaGJxVFRxRU9YSy8rN0l1TGpZSVQ1?=
 =?utf-8?B?SWNqV1lUTWNCREhlQ1kxdjVSL29jdVFncWZOUTU0UmdKWUt0NWpKcXpNTE9n?=
 =?utf-8?B?SW5zLzM3WTF2dk5XeHVESGF3QUZ3UnUvNDZvZ3VlQUV2ZUZ5R3d5QTk0SzRZ?=
 =?utf-8?B?M1ZWd0hIeWZVdTFIK25wcWg0VCtQZzYxei9tMTAzY2JJZm1tb09FWXdBS2Qy?=
 =?utf-8?B?anVKZzBUZ0ZNWnI1VnM0UlZKZ1NaNlhlMElUazIzU2F1Y1VRYnYvajlOa3pr?=
 =?utf-8?B?QW04VXhhTEtZQnZVUksvZDkzRHRkV2sxMUUvTUZqWmF6K0N2WUt0NkIyS0Zv?=
 =?utf-8?B?b3pXZmZaeWdrMHBya05JWk1CbE5KZnRHc2YzbkJ0dmJnTGYxNVYvZnFXb2tn?=
 =?utf-8?B?Q2RJMUN2STFiT3M4ZkpsR1VLazZ2RE5uTXNsVEVtZDhOMWRBdG0zNlpzVk5O?=
 =?utf-8?B?N09mczJydTdnUnNtMExBTHNaQXM2bFo5dExxdERVOEpycjdRTFh0STFDVDA4?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CAC2B99A20B67499D059E93E2A63E55@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /RwyUrQdpplDHAE7XTY6TsohewJf5mxwk8PvP2hBm/QNXpB7/2UkyRJ5aj8zrAI2fInfddLzTO9SMPjCp7REugeyuURjj5ZsFbLXN5eBFYva2YxmZOrqI/V4DiGnveTLPQ5WkUXfVeBY8UePL6SjP/kXDLRU3VkgWJ/kcUePC4Ttn0BY97nXEMYZB4lslesc1MkYtILHmEVQJVMxSIlmrtVhj9kpEDcPCfuHXYEHkkulWQlw8vfDJXQfnJ4VqctNA+7rwEWQXmOADwMABljJKoo6SkcH0kpx08RAMiKmBkmAnTW1AHiDJcZDeIhZJtYFfsL2oNfzCTA9k3F+781wP5+uzEaETZGow+dcQ8goM/ZFh3jExhbJStbjHdNBQuPIBIrCy90srof9+GQr+Xq2D0a+P6NcPOxPGVHcyHKy0+ECakRy0yGRT9Z0X/CSOMMtZiUGWlnJqLhMQ0C6Y7RAgavjx/mTEeGiITfD6ttm8xLNaOYoxuoY1frlWqVffipeXr4pTeb27iwXZj5ZMYGKCqU0XrkYXnJ1blDaWy8qIE2c/wcpAYga7zX2pgSr34SzZjLAGfDIDhHSjaHBd+JKH2hcm+9ZjwdRQhXJKrw6FUQB00kARVX+HJ+sfePr6enW
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR02MB3174.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0deba5e-51a6-41ef-d774-08dd768089c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 09:34:19.5194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBB7fA3/37/ut2gOndpxz0AeqptlJHC5D7nvK1oRL+RfcU6yGXQ4t/MR7TLunTiuosVRbgNCyrJqPlYP0YbjcnWVEJ31OQK/A67W5YSVEVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8803
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f4ed9e cx=c_pps
 a=6dLVn7RwcbTzQ1hpYGxp6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8QTP89St_vzaCnReobYA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=vUsbdJjsiYsWhgVz2Rkt:22
X-Proofpoint-ORIG-GUID: HO3skWUqizgVamuHnIDhG8dEOB4nwbdf
X-Proofpoint-GUID: HO3skWUqizgVamuHnIDhG8dEOB4nwbdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCj4gT24gOCBBcHIgMjAyNSwgYXQgMTA6NDksIEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZiBhbnkgbGlua3Mgb3Ig
YXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE1hcmsgQnVydG9u
IDxtYnVydG9uQHF0aS5xdWFsY29tbS5jb20+IHdyaXRlczoNCj4gDQo+PiBJbiBwcmluY2lwbGUg
SSBsaWtlIHRoaXMsIGJ1dA0KPj4gMS8gdGhyb3VnaG91dCB0aGUgQVBJIGNhbiB3ZSBwbGVhc2Ug
bWFrZSBldmVyeXRoaW5nIGNvbnNpc3RlbnQgc3VyZSB0aGF0IGFsbCByZWdpc3RyYXRpb25zIHRh
a2UgYSBoYW5kbGUgKHZvaWQgKikgYW5kIGFsbCBjYWxsYmFja3MgZnVuY3Rpb25zIHBhc3MgdGhh
dCBoYW5kbGUgKGFuZCB0aGUgSUQpDQo+PiAtIHJpZ2h0IG5vdywgc29tZSB0aGluZ3MgZG8sIHNv
bWUgdGhpbmdzIGRvbnQsIGFuZCB0aGlzIHNwZWNpZmljIGNhc2UNCj4+IHNlZW1zIHRvIHRha2Ug
YSBoYW5kbGUgb24gcmVnaXN0cmF0aW9uLCBidXQgZG9lcyBub3QgcHJvdmlkZSBpdCBvbg0KPj4g
Y2FsbGJhY2sgKCEpDQo+IA0KPiBUaGUgaGFuZGxlIGlzIHNvbWV0aGluZyB0aGUgcGx1Z2luIHNo
b3VsZCBoYXZlIGFscmVhZHkuIFRoZSBwbHVnaW4gaWQgaXMNCj4gbmVlZGVkIHNvIHRoZSBmcmFt
ZXdvcmsga25vd3Mgd2hvIHRvIGRlbGl2ZXIgdGhlIGNhbGxiYWNrIGJhY2sgdG8uDQoNClRoZSBw
bHVnaW4gZ2F2ZSBRRU1VIGEgaGFuZGxlIHRoYXQgaXQgZXhwZWN0cyB0byBiZSBjYWxsZWQgd2l0
aCwgc3VjaCB0aGF0IGl0IGRvZXMgbm90IG5lZWQgdG8gZG8gYW55IGxvb2t1cC4gV2l0aG91dCB0
aGF0IGhhbmRsZSB3ZSB3b3VsZCBoYXZlIHRvIGFzc3VtZSBhIHN0YXRpYyBnbG9iYWwgc29tZXdo
ZXJlLCB3aGljaCBpcyBub3QgYSBuaWNlIGRlc2lnbi4gU2luY2Ugd2UgbWF5IGhhbmRsZSBzZXZl
cmFsIHBsdWdpbnMsIGFsbCBiZSBpdCBpbiB0aGlzIGNhc2UgaGF2aW5nIG11bHRpcGxlIHBsdWdp
bnMgcmVnaXN0ZXJpbmcgYSB0aW1lIGhhbmRsZXIgd291bGQgc2VlbSBvZGQsIG5vbmUgdGhlIGxl
c3MgaXTigJlzIG11Y2ggY2xlYW5lciB0aHJvdWdob3V0IHRoZSB3aG9sZSBBUEkgaWYgd2UgaGF2
ZSBhIHNpbmdsZSBjb25zaXN0ZW50IGFwcHJvYWNoPyBIYXZpbmcgdGhlIGhhbmRsZSAod2hpY2gg
eW91IGFscmVhZHkgcmVxdWlyZSBvbiB0aGUgcmVnaXN0cmF0aW9uKSBpcyBhIG11Y2ggbmljZXIg
cGF0dGVuLCBidXQgaXQgbmVlZHMgdG8gYmUgZm9sbG93ZWQgdGhyb3VnaD8NCg0KPiANCj4+IA0K
Pj4gKFRoaXMgaXMgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gOg0KPj4gdHlwZWRlZiBpbnQ2
NF90ICgqcWVtdV9wbHVnaW5fdGltZV9jYl90KSAodm9pZCk7DQo+PiAuLi4NCj4+IFFFTVVfUExV
R0lOX0FQSSB2b2lkIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3RpbWVfY2IocWVtdV9wbHVnaW5faWRf
dCBpZCwgY29uc3Qgdm9pZCAqaGFuZGxlLCBxZW11X3BsdWdpbl90aW1lX2NiX3QgY2IpOw0KPj4g
KQ0KPj4gDQo+PiAyLyBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBtYWtlcyB1c2Ugb2YgdGhl
IGNhbGxiYWNrIF9PTkxZXyBpbiB0aGUNCj4+IGNhc2Ugb2Ygc2luZ2xlIFRDRyDigJQgaXTigJlz
IG1vc3QgaW50ZXJlc3Rpbmcgd2hlbiB3ZSBoYXZlIE1UVENHIGVuYWJsZWQNCj4gDQo+IEFoaCAt
IGFzIEkgc2FpZCBjb21waWxlIHRlc3RlZCBvbmx5IDstKQ0KPiANCj4gSSBjYW4gZml4IHRoYXQg
Zm9yIHYyLg0KDQo6LSkNCg0KPiANCj4gDQo+PiAoYW5kIEkgc2VlIG5vIHJlYXNvbiBub3QgdG8g
cHJvdmlkZSB0aGUgc2FtZSBtZWNoYW5pc20gZm9yIGFueSBvdGhlcg0KPj4gYWNjZWxlcmF0b3Ig
aWYvd2hlbiBhbnl0aGluZyBpbiBRRU1VIHJlcXVlc3RzIOKAmXRoZSB0aW1l4oCZLg0KPiANCj4g
VGhhdCB3b3VsZCBtZWFuIG1ha2luZyBhIGNsZWFyIHNlcGFyYXRpb24gaW4gcGx1Z2lucyBmb3Ig
dGhpbmdzIHRoYXQgYXJlDQo+ICJldmVudHMiIHdoaWNoIHdlIGRvIGRvIGZyb20gb3RoZXIgaHlw
ZXJ2aXNvcnMgYW5kICJpbnN0cnVtZW50YXRpb24iDQo+IHdoaWNoIGNhbiBvbmx5IGJlIGRvbmUg
dW5kZXIgVENHLg0KPiANCg0KQWxsIGZvciBjbGFyaXR5DQoNCkNoZWVycw0KTWFyay4NCg0KPiAN
Cj4+IA0KPj4gDQo+PiBDaGVlcnMNCj4+IE1hcmsuDQo+PiANCj4+IA0KPj4+IE9uIDMgQXByIDIw
MjUsIGF0IDEzOjM4LCBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+IHdyb3Rl
Og0KPj4+IA0KPj4+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywg
YW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPj4+IA0KPj4+IFJhdGhlciB0aGFuIGFsbG93aW5n
IGNwdXNfZ2V0X3ZpcnR1YWxfY2xvY2soKSB0byBmYWxsIHRocm91Z2ggdG8NCj4+PiBjcHVfZ2V0
X2Nsb2NrKCkgaW50cm9kdWNlIGEgVENHIGhhbmRsZXIgc28gaXQgY2FuIG1ha2UgYSBkZWNpc2lv
bg0KPj4+IGFib3V0IHdoYXQgdGltZSBpdCBpcy4NCj4+PiANCj4+PiBJbml0aWFsbHkgdGhpcyBq
dXN0IGNhbGxzIGNwdV9nZXRfY2xvY2soKSBhcyBiZWZvcmUgYnV0IHRoaXMgd2lsbA0KPj4+IGNo
YW5nZSBpbiBsYXRlciBjb21taXRzLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVu
bsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiBhY2NlbC90Y2cvdGNn
LWFjY2VsLW9wcy5jIHwgNiArKysrKysNCj4+PiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy90Y2ctYWNjZWwtb3BzLmMgYi9h
Y2NlbC90Y2cvdGNnLWFjY2VsLW9wcy5jDQo+Pj4gaW5kZXggZDliNjYyZWZlMy4uMTQzMmQxYzVi
MSAxMDA2NDQNCj4+PiAtLS0gYS9hY2NlbC90Y2cvdGNnLWFjY2VsLW9wcy5jDQo+Pj4gKysrIGIv
YWNjZWwvdGNnL3RjZy1hY2NlbC1vcHMuYw0KPj4+IEBAIC0xOTcsNiArMTk3LDExIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCB0Y2dfcmVtb3ZlX2FsbF9icmVha3BvaW50cyhDUFVTdGF0ZSAqY3B1KQ0K
Pj4+ICAgIGNwdV93YXRjaHBvaW50X3JlbW92ZV9hbGwoY3B1LCBCUF9HREIpOw0KPj4+IH0NCj4+
PiANCj4+PiArc3RhdGljIGludDY0X3QgdGNnX2dldF92aXJ0dWFsX2Nsb2NrKHZvaWQpDQo+Pj4g
K3sNCj4+PiArICAgIHJldHVybiBjcHVfZ2V0X2Nsb2NrKCk7DQo+Pj4gK30NCj4+PiArDQo+Pj4g
c3RhdGljIHZvaWQgdGNnX2FjY2VsX29wc19pbml0KEFjY2VsT3BzQ2xhc3MgKm9wcykNCj4+PiB7
DQo+Pj4gICAgaWYgKHFlbXVfdGNnX210dGNnX2VuYWJsZWQoKSkgew0KPj4+IEBAIC0yMTIsNiAr
MjE3LDcgQEAgc3RhdGljIHZvaWQgdGNnX2FjY2VsX29wc19pbml0KEFjY2VsT3BzQ2xhc3MgKm9w
cykNCj4+PiAgICAgICAgICAgIG9wcy0+Z2V0X3ZpcnR1YWxfY2xvY2sgPSBpY291bnRfZ2V0Ow0K
Pj4+ICAgICAgICAgICAgb3BzLT5nZXRfZWxhcHNlZF90aWNrcyA9IGljb3VudF9nZXQ7DQo+Pj4g
ICAgICAgIH0gZWxzZSB7DQo+Pj4gKyAgICAgICAgICAgIG9wcy0+Z2V0X3ZpcnR1YWxfY2xvY2sg
PSB0Y2dfZ2V0X3ZpcnR1YWxfY2xvY2s7DQo+Pj4gICAgICAgICAgICBvcHMtPmhhbmRsZV9pbnRl
cnJ1cHQgPSB0Y2dfaGFuZGxlX2ludGVycnVwdDsNCj4+PiAgICAgICAgfQ0KPj4+ICAgIH0NCj4+
PiAtLQ0KPj4+IDIuMzkuNQ0KPj4+IA0KPiANCj4gLS0NCj4gQWxleCBCZW5uw6llDQo+IFZpcnR1
YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0KDQo=

