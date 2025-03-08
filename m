Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC39C282DE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 00:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqiAM-0005qi-0v; Fri, 07 Mar 2025 19:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tqiAK-0005qU-Qp
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 19:35:44 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tqiAI-00077e-Nu
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 19:35:44 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Nce4k002298;
 Sat, 8 Mar 2025 00:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LnXWtX+WGHLHEwyE0v+cYh6JllU5sqrv4tzm/h5BdXc=; b=lE045YpcHLkhpuRz
 AzVIe7H8vs9xxyPs7c++t94o7/ABqjzqA9/bd0CxsCEM6R5QATELnYVaIn4eHhC9
 YpSdsmiK5NwWyl3IovMcArL0/pZtu4nJyLSfOQ0Bbmb1aNSef4Y2cb9uibmE30T+
 cu2Sh/rHo+00Jcx8pOFoCJChtfWyf1+6MAK8ZhHDsoqNqhJlnYuRTxSL2KqW3wSH
 VHpUZsMB4U7UaduYOjK35M0Ep4r7GPFHSuXmGxSbB6OK9V0wf+WB7GxYP0YY41/Z
 SEgjp8DfORhOcz9Ac4HiQZVw1mTixzeaQn1Hve8Z5Ud/mDm7SBc1OUDRNzON29qn
 wXCLOQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17011029.outbound.protection.outlook.com [40.93.12.29])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4577mxdj9s-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 00:35:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed2FhHtETYJS3pYwrRUSATvTbk4USaUOnDL2V7Ym8rf3PpV2gN2tprrzedbE47ILuWIT5EaLF9JQvOqPC05KPi2YQCUdTmZPBf6qhv1Wqxh1ok+U0PoaOElRJG2vC6FV5AEAq5pOFyatXC/tXp9V8iYCx9D9d86tJlHx+NZrICvY8WZS4KySMZU4rUFzhCnXRTLhjM/PX6/eYFqXa0P7YMwXJ0txXu/KALNR3VfPJIlqUVt4iN6AtcheWtNWDv/7y+VB8yPo6QZ5h8NBXEqYkJRiglAIcvT0uWEx5DdRU94h6XSh6d6x1/bcC3SL1fe/cVFhp3CUpO5kGDGDZyzPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnXWtX+WGHLHEwyE0v+cYh6JllU5sqrv4tzm/h5BdXc=;
 b=oL7hvaNjfxAFITW/MHviqZBQKJ7ucHQVpgOQ6EatUGNYzGuySl5/JigbK8ZM64iMKiHxS5MV976hD0Jl9lpjJkFRymA9x7VrjyLKX6WyJKKexq8C1kpWGzChfJ4aVDeTK9gHY3ucpNQvrI8Pr8ZnyeAO4ngZpFzTZSXLMn6i3461mkyZsMBd0DBoVFTmSUscitd80TU4eLB5baV8NuIFekGDh5irMJM8J705xUotDA0alX2mZBT/wVYSt9OCW86cAYD4Ixjkj5HvUKjrcL8hTPN2CrGnTeeIH9cOuvF4OlmwvbOtVxuFrWTEFmiCshd2gQt2EXEnrPgU0rRfK72J6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by SJ0PR02MB8466.namprd02.prod.outlook.com (2603:10b6:a03:3f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Sat, 8 Mar
 2025 00:35:32 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8511.017; Sat, 8 Mar 2025
 00:35:31 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, 'Brian Cain'
 <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>, "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng"
 <anjo@rev.ng>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "Mark Burton (QUIC)"
 <quic_mburton@quicinc.com>, Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 08/38] target/hexagon: Add guest, system reg number defs
Thread-Topic: [PATCH 08/38] target/hexagon: Add guest, system reg number defs
Thread-Index: AQHbimqRHv9mBCNW7USkyM9/YzEdI7NmqRqAgAHDHGA=
Date: Sat, 8 Mar 2025 00:35:31 +0000
Message-ID: <IA0PR02MB94867EE572C37C2833808B5BBED42@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-9-brian.cain@oss.qualcomm.com>
 <023901db8ede$f8dc6980$ea953c80$@gmail.com>
In-Reply-To: <023901db8ede$f8dc6980$ea953c80$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|SJ0PR02MB8466:EE_
x-ms-office365-filtering-correlation-id: 30a72a79-a3cb-44eb-b3bb-08dd5dd92213
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QmhmVHZlaytXN1pyS1VWdHpwckhKUmt1L2RPMkMrK25vdzdlSkxaV0U4dEVM?=
 =?utf-8?B?Y1JjRDc5VmxOYzJ3ZmVMZTdJVGUva2RHWlRPQy9CL29hRjBNTktFTFU3Y0hF?=
 =?utf-8?B?UmxVSUNXd3UzK0l0dHpiUTBvdTA0L09qaGJESUJsUXZjTGNvWkRkVUFWbnRL?=
 =?utf-8?B?bExmeGF4aHJtRjNhRndQZXdIb2J3RW03dUo1RTVzUm5Odm5TZlNYeHNPWXJH?=
 =?utf-8?B?U1Q4c2VxbkN5L2kzdDcwV3duSjlxMlZLaXU0ZXp0MEwrTk44WFJoTmh3NTl5?=
 =?utf-8?B?NjVhM250Q0FqTGM4RHduVi9MV2F4VDd1SVVRNWcwRGR0VzlvbWEyL3NCM0pq?=
 =?utf-8?B?SUZGVnhoYXp6bVNDMHFVUjRKdmtmcDhPUS9nMkNCYk04Z3B6aDZGakpERkdW?=
 =?utf-8?B?Z2t3Y2J3T2ZPbHZGZTZMRjBXZUVUSEZHd1V3eDJDc0JpOWlDd2pOcm4rN1cr?=
 =?utf-8?B?MnIwblU2YVRwQ3FCS2ZCYXN5TVZuV3NMcmFCRWoraHloVldnOWN0NDdpNkk3?=
 =?utf-8?B?ZHVZbVlYKzdibmFxaVJqdmZNRk43MmhFOUVqL3RzbEl6RU1TS0hrSzVpSTYz?=
 =?utf-8?B?emhTdmJMMlJwNnZvRGxRN09pVEI4aFFFQUEvbkN2NDA4Y0t0TzJlSGd0ekJw?=
 =?utf-8?B?UHcxbDF4VVIwMmFGL0hOWHVSQkxpb1h1dlBxOUhxSzc4bWtRMGExZXAySGdT?=
 =?utf-8?B?WjA1Nkc2MENWMlcwVDBnQjZTQlpwRzBUQW9wUUFldFYvUHR4bFBCYWtkQlBk?=
 =?utf-8?B?SXFBeHc2L255MVJ3WXM4QWhaT2tjTGVib29CaVYrZTd3TFlpdllhUXEzdFlj?=
 =?utf-8?B?QlMzTXVwN1Rmd3FWWHJZS1RsdWthRU1DUFdxeHk4SUgzVjJxNHkzNVdmcjBw?=
 =?utf-8?B?M0IycFZqZ0dMT1ZLSmQ3WnVzeFJyMjhyYld1UE1XOXovY3owRk4xcVpsNFVH?=
 =?utf-8?B?TU5ZeUhUNVlGNFpWZ2MzdEdINTdtYWVqbTZtdGlFbDFyZnltMnQwdFZ4L1JF?=
 =?utf-8?B?VkF2NGdTcUdBOVFmTytGbHl3eERoQkNnL09xaTR4eThSc09wYTFMVk5ubWxP?=
 =?utf-8?B?U29pQXMyU2syMU1NdzdhS3BUZWpqUFRqaFVVVDlyenkxZTJId09YRENJaHpr?=
 =?utf-8?B?a0lPNlZ5ZS9La29JNFl2cE85WXpFMTVOOURnZi9hb1pjQzlXa3REUGFnR0JD?=
 =?utf-8?B?Nzk5NHFVTVJPVzhpSzdvQkdnMUh1V09QNVpxcGwvb211RlBTN3hRK1o4aHpC?=
 =?utf-8?B?QVNpT01TTWp6em0xV29HK1RObnhzNGhRL3hZNWo0ampPdm5BV1poWTNjQ2FT?=
 =?utf-8?B?cUtLTHNHbVNPbm9ScUI1VVhqMkNJLzBzSUQ2L29HWmxWVHpLbzZEL09hanpK?=
 =?utf-8?B?RjBXTk1GYmhRN1pmOXl0Vzk4ZFZJb215b3MzVW9qaGZ3bVdlTmQ3NHZXOEVD?=
 =?utf-8?B?T2pZWmh1ZmFWYWZFQ1JDZkdCYTJNVVNWUE5Sdy80USswNHkwMi9BeHZNNmZ3?=
 =?utf-8?B?K2dscUlGaDZVZjZpelplcVo5ZTFNMENudzlucTdiR1FPeEJDdm55UzBad2dN?=
 =?utf-8?B?eFhVZTVFb2Uwb3Q5d1JoOWNDSTNjSCtkR0N3WmpGbVRFTVE1UisyZ1VWZ0dC?=
 =?utf-8?B?UnJhVENVeFBWUGNEbnR1VjF1Sk1xUDhRTGp5WUdRYlpEVDJRUWMvSEdhc2FZ?=
 =?utf-8?B?OUNGNk9FQ1JOTzEzWWNBc011Y2NTQTBkVWxmeTl2bG8vTVVDc0FNZC9OamNK?=
 =?utf-8?B?bC9VTFJTWFB0WUQycTE5TEhpNm5iTHlIT3pZbWZqR0ZzOVh2TmNzQmg1OGdG?=
 =?utf-8?B?MFA3NjkyMjV4ZlA1UFc1NWg4ZEZ5cGUwZmhzZVB4b05uUERmd3hiWld4SFR1?=
 =?utf-8?B?RGxINzY2bmJWTEtFVFFZdXk5aFJmSHFpb0xGamgwZEdpOUtTTjljYmpVeCtE?=
 =?utf-8?Q?LJtkVzKfjaAnXvqPvPTeiMVCXGxtBqHG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZ4Nm4rdVZhQXVjcW4vaXVIVE1tdjJPZVFQaE5aZXVqTHJzR3Y1VWFhc09j?=
 =?utf-8?B?dlAwQmtGcVphbGxVaGozbkZ2MGdkcEJVRk9sVkdqR2pvSXNkNEVvTWZ1Q0Fr?=
 =?utf-8?B?bnRXV0NSOG5MdXpmMUhzZHRsak5JbHhrcUlUNElmWWM2bXRMN0hJbEhNZTFZ?=
 =?utf-8?B?WVdsOERGS0JZOXNoZEIyOEpxRW9MeGtPMXR3UnR0SklRZUtvaloxN2JUZUFB?=
 =?utf-8?B?R0N3V2V6dEQwNTBRN2Q1M3VScjlpREh1TFYwVUd3ZDVsRERpMElSM3M3OUJo?=
 =?utf-8?B?VjJKRUEvRThXbjJWS0tpTjA0Qjk2dEYzMU0vSFhwWnBJZTFCMG03Nm1QUVlS?=
 =?utf-8?B?N2hHbVBmWm8ycWxUMVVWR1QyY05iQzIrejZhK2dlc1g5cmFkb2NyM2x3WUtX?=
 =?utf-8?B?ZVVSYzJIdkNqazBXK2YrYUIwanhldkRHMExybjAyQS9zMTBQcDU5cjFuM3Za?=
 =?utf-8?B?cUpLT1NDNWZ1MXB1dEsrUytzVXlFYTF1bVR1OVRCSkVqUHRCQ05LN3Q2Q0l6?=
 =?utf-8?B?THczMVIxWmlFWmhBNzdlTFRZY0NxNm1RcmxLVXEyalJYMjJjZWNrNEJlTFEz?=
 =?utf-8?B?ek9zdnI2enBTODJ3M0V5d2hweE5TMzBIdHppN2wrcXoySEpOUjhLZWQzcFJP?=
 =?utf-8?B?TUZHUVA0djZnNWFDMkNwMlc1K1dmMzhreTlBQ0Z0RmdiOUdndVRGdWtBKzBB?=
 =?utf-8?B?L3orQVRWSUhaWFArNFhkL0RWTFpaL3Jhb0RqeExkbUcrNkVXTXBDNEN6V3Na?=
 =?utf-8?B?SGdNWkxDcC9WakxjRjJ0T1lBeFREMFRzbXN3SUh0TWlQZkFQa3JmWTJmdEdz?=
 =?utf-8?B?bFc3QTdIOXNhQzE1bUpnTkd1K3M5OGVGSDVRV2twSUdKNlJSVk1vSXFvL0g3?=
 =?utf-8?B?VW9wWTlXd3YvdlBMWnRzdkRpejhUZ2ZyaUJsOW90THdsU2dLWWk1WC9UNEtZ?=
 =?utf-8?B?YzV6aWtSWGtxTFh2Q2pDZnpTUnVPcm0yTEtOVE44QVV0WHl2VWRYZ0xMZ3V2?=
 =?utf-8?B?V1BXNndqdjIzQzBTL213RnBnOGZIQXhWNmV0QU1CN3l4MWhQWFRDSzNDL2lw?=
 =?utf-8?B?WlFpeDg4a0dlSXgzTkdQK29KWDk0R1FqNkZsaXRkNnJwUWV2SlY5cU83N3Ix?=
 =?utf-8?B?RC9jcEVPWGRnTWNUMXJYREtnY0s3d08wWU54ZzJRL0FtK1dKMFlNaCsxZVdS?=
 =?utf-8?B?dGNqZTJOR3pBemhEUWFSYkVqMy95a2kwUUM2ZWttNXhiZ1RRaUVYNU1Cc2ty?=
 =?utf-8?B?TTltVm1GUlYySmltRE1yd1YyWmdwSDhpaVJNUDBFVVFzYm5iUVFqbWN6RXlF?=
 =?utf-8?B?VEpucCtZZXkyWHN4eGdPMUt0VndmOU1lbytDejArUE9oZjducU1vQUFKdzhs?=
 =?utf-8?B?bURCOUovcytxZkpyaHZrOVZHYTZrcHVSa2xjeWlhMSs1YUwxSW1jU3NENGIr?=
 =?utf-8?B?aitYZFBzWXZBa0dLM2RWV1MxL1Z1TWNQNFYzeWhzZDNCU01kcTJOZmlLSzg3?=
 =?utf-8?B?TjVoTDE5SktyaTdXZHZZYjhQM3dBTmxhRHdzN1dmUm92SDlmWC9ZN3JnenB5?=
 =?utf-8?B?YjNUL1JwbkRCUm1DeDlIa0d0ZjNjSFdNSWY0N1NMZ0NsOUI4R21ZUjJ6ZzVy?=
 =?utf-8?B?c0tKeitTcWZIZ1lCbnFZNFN1UU1JbDlhSWEyWGdwcFVRcGZ3U0M4ckdpWHVr?=
 =?utf-8?B?aENXTTYxYkNBNzlhUUI3dG0rQ0cxVVFyRzlLWWJRTDdRNlpNS1lqWHN4bCtI?=
 =?utf-8?B?QlpBZWpHUEFndEpjdlhvQnhxWmxkUjJNM0VPcWNyOVlDSHMwd2RrQWtLM2Ex?=
 =?utf-8?B?NkNoaHJQM2U2cFdpNVVYQ1R6OHJLNDJzVWJGeGFzcmthOWZqUEFNaEdmSXdB?=
 =?utf-8?B?L3JkVGkwT0lFUS9lNUhiSEY0NkR1Nzl4SmkwaFpBYndPSGs5RGZpU2ZneVZE?=
 =?utf-8?B?SWszcnpSREl5TmdPOC8zT2JBakZsOFd2Q2gzbE0yM2pxczhPdXVjNENETDE5?=
 =?utf-8?B?MEtJc2psTGZWNE9KQjZFakUzVlV5dTI1b0RkSEJOWVl4UnRpOWZkU1BENUE5?=
 =?utf-8?B?b1c5WU03SlJsZm54QVhRcXh4TTdTWVh0VzIwMFBWR0ZKNVlMdFlTV1Vib3Qx?=
 =?utf-8?Q?ouolgo0WMOVYJRv7ogJLKqMXz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: web4dR4ZPPBRrPDsRM8hZ9JSkJSjKNvbI+FtQI3ondVR+DSv3KadtRaPKvJaR2EuepXKfe6XrY1U07JMEBP4xSBMXa9zwyh5MiTMrKjCqIOJS9gjjFxOWACK644Ued38WsRyE6Ri7oqCTu8y8VUecxOlJp7EkoeR/iiNUri2bhTy0JZfFzxg3vLxb/S73nci8/g8jZiGlQT5moUfu53IhTM+ounqraVRwUhikx+shGZm+FEZh658fbPRbA8lM5yO6pRQAVW8qQ9QF7ZouFyWIBOnR+rixjMd8WLFTHof9mcpJfaF9Jy7XIGzI03sKGS3GA5HPajTXVWplYs8an5gDpFx0LgJWa7WzKpAxEb6S8nM5oLFy+RXuB4yuxXocH/uurSKQrFIDrnx3H+xBMK5gxCpWxTh/g1TojH/JuHBc/kf/I0MvcJry+vVHr96esMCcAqKWbBLu6naKb3tzIWZiz+nGdC/BSI26deAhsXBS4vecQBVzMIXymQ2e++FwWA08lH2W49vadbsK209PyeMuJaTIKMJtAwc5/3LnaV69vj3hCtuFubQQrgoIXDR7/gVwyVftwD2/jPWSLwy5HTs/kVuedA36thTzKpHycXYVHxIqhv6nZTfhd2+3nFkWugG
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a72a79-a3cb-44eb-b3bb-08dd5dd92213
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 00:35:31.7247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOyC/sbpFju8H5teo8GhmVsj54UG1O56mglw7UP9oCshKwNAx1Wot7arvCJqxb1g8ZCIGjOWkbUQXsaiWMYKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8466
X-Proofpoint-GUID: B3mvZTATvWu2AD0nOmnkbpBGdcBdOSZM
X-Authority-Analysis: v=2.4 cv=cOIaskeN c=1 sm=1 tr=0 ts=67cb90d9 cx=c_pps
 a=djVjp5eVWc/OO4qUaLGr8w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=Je83v-lnS0Boj8GAR3wA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: B3mvZTATvWu2AD0nOmnkbpBGdcBdOSZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080001
Received-SPF: pass client-ip=205.220.180.131; envelope-from=sidneym@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbHRheWxvcnNpbXBzb25A
Z21haWwuY29tIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCA2LCAyMDI1IDM6MzAgUE0NCj4gVG86ICdCcmlhbiBDYWluJyA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgTWF0aGV1cyBCZXJuYXJkaW5vDQo+
IChRVUlDKSA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IGFsZUByZXYubmc7IGFuam9AcmV2
Lm5nOyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyBh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBNYXJrDQo+IEJ1cnRvbiAoUVVJQykgPHF1aWNfbWJ1cnRv
bkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nDQo+IDxzaWRuZXltQHF1aWNpbmMuY29tPjsgQnJp
YW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDgvMzhd
IHRhcmdldC9oZXhhZ29uOiBBZGQgZ3Vlc3QsIHN5c3RlbSByZWcgbnVtYmVyDQo+IGRlZnMNCj4g
DQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNv
bW0uIFBsZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRv
IG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4NCj4gPiBT
ZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDI4LCAyMDI1IDExOjI2IFBNDQo+ID4gVG86IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KPiA+IENjOiBicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb207IHJpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmc7DQo+ID4gcGhpbG1kQGxpbmFyby5vcmc7IHF1aWNfbWF0
aGJlcm5AcXVpY2luYy5jb207IGFsZUByZXYubmc7DQo+IGFuam9AcmV2Lm5nOw0KPiA+IHF1aWNf
bWxpZWJlbEBxdWljaW5jLmNvbTsgbHRheWxvcnNpbXBzb25AZ21haWwuY29tOw0KPiA+IGFsZXgu
YmVubmVlQGxpbmFyby5vcmc7IHF1aWNfbWJ1cnRvbkBxdWljaW5jLmNvbTsNCj4gc2lkbmV5bUBx
dWljaW5jLmNvbTsNCj4gPiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPiBTdWJq
ZWN0OiBbUEFUQ0ggMDgvMzhdIHRhcmdldC9oZXhhZ29uOiBBZGQgZ3Vlc3QsIHN5c3RlbSByZWcg
bnVtYmVyDQo+ID4gZGVmcw0KPiA+DQo+ID4gRnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2lu
Yy5jb20+DQo+ID4NCj4gPiBUaGVzZSByZWdpc3RlcnMgYXJlIGRlZmluZWQgaW4gdGhlIFF1YWxj
b21tIEhleGFnb24gVjcxIFByb2dyYW1tZXIncw0KPiA+IFJlZmVyZW5jZSBNYW51YWwgLQ0KPiBo
dHRwczovL2RvY3MucXVhbGNvbW0uY29tL2J1bmRsZS9wdWJsaWNyZXNvdXJjZS84MC0NCj4gPiBO
MjA0MC01MV9SRVZfQUJfSGV4YWdvbl9WNzFfUHJvZ3JhbW1lclNfUmVmZXJlbmNlX01hbnVhbC5w
ZGYNCj4gPiBSZWZlciB0byDCpzExLjkuMSBTWVNURU0gR1VFU1QsIMKnMTEuOS4yIFNZU1RFTSBN
T05JVE9SLg0KPiANCj4gU3RyYW5nZSB0byBwdXQgdGhpcyBpbiB0aGUgY2hlY2tpbiBkZXNjcmlw
dGlvbi4gIFNlZSBwcmlvciBjb252ZXJzYXRpb24gYWJvdXQNCj4gZG9jIHJlZmVyZW5jZXMuDQo+
IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPg0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgIHwgICA1
ICsrDQo+ID4gIHRhcmdldC9oZXhhZ29uL2hleF9yZWdzLmggfCAxMTUNCj4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEyMCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1Lmgg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaCBpbmRleA0KPiA+IDc5ZTYwZDRiZmEuLjIwZWEwYWRjY2Eg
MTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgNCj4gPiArKysgYi90YXJnZXQv
aGV4YWdvbi9jcHUuaA0KPiA+IEBAIC0yMCw2ICsyMCwxMSBAQA0KPiA+DQo+ID4gICNpbmNsdWRl
ICJmcHUvc29mdGZsb2F0LXR5cGVzLmgiDQo+ID4NCj4gPiArI2RlZmluZSBOVU1fR1JFR1MgMzIN
Cj4gPiArI2RlZmluZSBHUkVHX1dSSVRFU19NQVggMzINCj4gDQo+IENhbiB5b3UgYWN0dWFsbHkg
d3JpdGUgMzIgRyByZWdpc3RlcnMgaW4gYSBzaW5nbGUgcGFja2V0Pw0KPiANCj4gPiArI2RlZmlu
ZSBOVU1fU1JFR1MgNjQNCj4gPiArI2RlZmluZSBTUkVHX1dSSVRFU19NQVggNjQNCj4gDQo+IERp
dHRvDQpbU2lkIE1hbm5pbmddIA0KQmFzZWQgb24gcGFja2V0IGNvbnN0cmFpbnRzIHRoZSBtYXgg
Zm9yIEdSRUdTIGFuZCBTUkVHUyB3b3VsZCBiZSAyLg0KSW4gYWRkaXRpb24sIFJFR19XUklURVNf
TUFYIHNob3VsZCBiZSAxMCBub3QgMzIsIDQgcGFpcnMgKyBzYTAvbGMwIHdoZW4gdGhlIHBhY2tl
dCBoYXMgYW4gZW5kbG9vcC4NCg0KPiANCj4gPiArDQo+ID4gICNpbmNsdWRlICJjcHUtcW9tLmgi
DQo+ID4gICNpbmNsdWRlICJleGVjL2NwdS1kZWZzLmgiDQo+ID4gICNpbmNsdWRlICJoZXhfcmVn
cy5oIg0KPiANCg0K

