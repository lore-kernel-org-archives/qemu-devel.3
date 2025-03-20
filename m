Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38263C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvMSu-0002PE-MT; Thu, 20 Mar 2025 16:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tvMSp-0002OQ-KO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:26:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tvMSn-0007Dw-2U
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:26:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEYOSZ025394;
 Thu, 20 Mar 2025 20:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2PxHpB0gGr4x2sYpZ3gEanXaHazV7c8+B5tVEot0Yfk=; b=Xa3ZP8IGtKwW/6Vj
 bPEj9LQJmQ48Lac7PsecDtQ2yQnC/tkyC44lH3ecCIrdQ5ofLGcZr7wK1AXaHyNM
 Rskj8+GNOVwG9hPfMNY8Ie2K+o0dfoHwd/rlXJG55xr8/YrLmzxREBG3aiEMIe7j
 r8ggkwQdJknTvKrUYyX5giQ4nUFBzVXOeqGdVIdVOlvQNxJwCrxZUwrO5LaOTiQz
 WlPAEFbPNN47Xal3l6RfAGbNy7MvbsHhn7wvXKQCwKiovCknDpMRMTdSVVhuuyaC
 c9fKQmSF4hF2SoWmVnYxv0AgBI9wyxwOba7F7fJO2SjwQXQ+O2aizLVcnHbEjAHa
 OY55VA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y49n8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 20:25:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCpyWaTKPt5otR5duCHiRa5sPLajIhFZSltnJVsNfz+icLaKxRpGphV4cvdvq/WWvbHOOnk6mmLsUSOrAvgcH3XPEZ5By60fWLRdgD0rJvUOq/FTPq6cKVOF11i2tb3OjKC8AyIoYBe0AbZ23ZNWIdADkvj9BhHpFdjqzuz07gjvhnJYGb868SMYZLEPf9Lpwggazdg01+UzM4Eud5m9TXtCtnnP5O4pIo9hmziV5wP4pgOB5s6hTAwkfHsk1DB/U8SV27RlsBuic2wMHdbuCfbcYCP9REf/qKCFdL3MrCg5mVaEMVZ5QlYbMQlbEYmCzm/HTXHSKvgxZZHmf9cLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PxHpB0gGr4x2sYpZ3gEanXaHazV7c8+B5tVEot0Yfk=;
 b=sRu1ZKsMpeBc7FdRMl9j/ok3DR0GYSVN9sVBKk1YglxZ5GPHRL/d9y/NNgmzXQeUQShGsQzHYBsX9wQXU2hHMOOUBgXm+vnLDpxrk0Y3Csx1yK9iocZdUmY/tl5LtVpvFa+msBEFWV+9+LpbELYyccgHFo61aLHOi2r9i2qKekAFej22qCG8J1cbMy5OhODdPNUyJsdseet/I74MT6fUKeTCf+GsnUMGrnqk5p8SCq8x3sZFElT/yCTf/C9+xntgsvFkV5msV/34548VukH4WqoV8HH3BEPXgDQacpQKw9eM/juMmxphBzKtr1418jU2uoQKk2MGicq9qySSC+Kzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by CYXPR02MB10193.namprd02.prod.outlook.com (2603:10b6:930:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 20:25:54 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 20:25:54 +0000
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
Subject: RE: [PATCH 22/39] target/hexagon: Implement setprio, resched
Thread-Topic: [PATCH 22/39] target/hexagon: Implement setprio, resched
Thread-Index: AQHbimrlTZH7uCjgI0Gq1ZsMt1lQi7N8jEGAgAAIOwA=
Date: Thu, 20 Mar 2025 20:25:53 +0000
Message-ID: <IA0PR02MB9486BDD73D3CBCD3468C367FBED82@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-23-brian.cain@oss.qualcomm.com>
 <03a101db99d0$8c67c5e0$a53751a0$@gmail.com>
In-Reply-To: <03a101db99d0$8c67c5e0$a53751a0$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|CYXPR02MB10193:EE_
x-ms-office365-filtering-correlation-id: 791c063b-67d9-4572-3dd6-08dd67ed69f8
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?di9xRlNkNmlMWGg5ZUJ0amxhWEtQeko5bmlLMXRpOGJWUzlSb2xscTlQTHk3?=
 =?utf-8?B?czRXZmVzQURmU0ZDYkRwZDRyYU95U1dVSEg1OW9JMXFRRlp3OTRIV1p2SnZ2?=
 =?utf-8?B?S242ZUVsaHNDdXhQb2llWmFXSWhkZUNYU1FsR1JWUGRYdHJrMEtGamRSd0dU?=
 =?utf-8?B?aVVoYzB1bDlvYm1VRDlGWCtnbnZTbEpHWGZ1dGlFMFNFT0llM2lSdjdsQjRs?=
 =?utf-8?B?cWc3M3ZVTlBxOW9LS2xhZUY3dmFzUmJvTjgyei9rTlRrUStnRm1uNzhPOTU5?=
 =?utf-8?B?LzJSRXhEbnBxVDBXOGFURHhNckhwcG12WWtjZERQM3doVytGV1c3bUhPQ2pG?=
 =?utf-8?B?U1MzVjh6cTAyMTVndmQ1QU5KU1RaRytSN0VBczBkQ1lUdit1WkppTWRjbTUz?=
 =?utf-8?B?enpDQnFwV2dLTHFRc0RaNTI2WTRIcTJUTUJkOUE5WXRLVW10WlE2a3NVVFJO?=
 =?utf-8?B?a2o0a2MxUVNlNDBoQTFIaTdPVHVDWGRxRnAyeHRENHo1UElOT3ZYUlZ6bWZa?=
 =?utf-8?B?ZE5kbiszY1A5SWo4REhIZE9Ha1EyQ2w3TCtVN3ZrQTRiWElOZFNXTjFIQjdx?=
 =?utf-8?B?SW5lL2VtTE9CNXc4MHYvVEFoMDNWNkRlNkZac1REcDVCVXgyNFE1TzZxOGE3?=
 =?utf-8?B?RVlrQTBBc3VKc3dzQjcwR2dENFFvQW5peDVOQXNFZXZENCt0KzN2MUxxY21h?=
 =?utf-8?B?M3FTNFFiMjNXODVrQnRhZXBlM1Q3Y2lLZll4bWFjelRKWEZydi9vUXVkRlhU?=
 =?utf-8?B?YWxOSzQ5dURNbnRsTVhwYkt6RjU0a1QwajRuV0U5RUpyeEJpeVNyM2QxMHZR?=
 =?utf-8?B?NkhnNm1kcmxSbE1uWnJpMnBLTUMwelRLSWYvcnpSWUpVRVVxeE5ENndHOG5l?=
 =?utf-8?B?Nk5EamVQYUFubHJvM1ByNE95YTdNVXlSRDhiTkRKZmhZNHhCdXpvWW1MQy9q?=
 =?utf-8?B?ZFBTc2RibklxckxKNGE5R1NTcWlVSkNZaHRuTVAzWmErb0s0T1h3RDRlN0lw?=
 =?utf-8?B?OS9QcHpCb3VNS3BDTmpoa3hlbzdjVWJGWG9TaDVDN2lRVURlR1ZqakVuMzBk?=
 =?utf-8?B?MVEvUGp1L3k3SzI5Z2JzTVo5WjBGU3hMdnpYSS9GTkYxaDI5U21jUWJtOVlG?=
 =?utf-8?B?ZUZLR0xDZlcrSElCVWNHV3l6dllqbk1teDQwOWFJdTBzeFg4QmJrTUFGUlMy?=
 =?utf-8?B?WGMvQ05DS2JrMVFGWFFlS05rTERQNEVwWFpVQ0NPSHVMYS9MK1JXYjl6aStr?=
 =?utf-8?B?elVVdXRoT2pBWTlyakJhQ3lBYlJuUm44ZXpsV2JYc0xDbXBwRzV6YXlHZCtO?=
 =?utf-8?B?RWZoRWVUOC9Pb2xHQkpOS2o3Q1J3ekR3QTlmRG1ob2thYnYvTnVmVktSYXNI?=
 =?utf-8?B?OGRONjUwREtZTmxKQ1hkaUZjK2E0MFJEY2twUnJSbmNkVm4ydVMwSWxTUlhO?=
 =?utf-8?B?bEU3Q2lnVkpWTDgwRU1zZEpnSDNWWUxTUUEzL1dTYXQ2cFpELy9pcjMxRFlN?=
 =?utf-8?B?UGliQ3RHeGxEd0EvMmI1dUpPVjQwV0JzTXFMWi8wQmJ2KzFhNzc0cHZtTlA0?=
 =?utf-8?B?emtNNk9hN2pXam51TUQzajhyckpHc21JdTJEMXdLcXRXeFYxKzZhRUxGaW1Q?=
 =?utf-8?B?cWRuQmxUV2x1V1FuS3VTMUNaeGxhVjBlQ201R055QlpqSTdDbVdNNHRteXkz?=
 =?utf-8?B?M0t2dnY3Y2ExZkp2V3lkUDFRSXN4TG12OE5OaWFya0c1ZlpJMnJYZ2JZM1hj?=
 =?utf-8?B?T0FUVUJPcm8yK2tYZmlsdmp2Qlo0UmxIeGlDQ3FRZVh5SGllMnVnSE8wMlJx?=
 =?utf-8?B?dlZ0Si9PVEhiZ01tVCtGTXhuM01CL1BHWUhEelRaeGdYeXUzb28xUW5lV3pq?=
 =?utf-8?B?bGNIdjREWWJaaTUrMU5YTHNjOVI0SVJuVjErN1lHdzVBVm9PVkNyd2NsVmRo?=
 =?utf-8?Q?Wcw6ccq18hugNyjaxE2giAXlGcxV0hbg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUpkMHpENWkvUGZpZzBFaDNIbGthN0ZVSVhBS3QyQ3IzdW42ZHJib0c2OUx2?=
 =?utf-8?B?Z0EvMmg5eURaNkNFNGd0YjBvNTd4K2todFZZSExGb2R1ZUxaTW1LVFdDeTZr?=
 =?utf-8?B?N0dyZDBSMWRoMXdCTjNPenBURU9pdFNmVE45dEJkU0hnWk8vQU4rT0NrNUJa?=
 =?utf-8?B?Y2JpcjlvdHcxV0NWWjJodURmQm1oYXpGbFkxWXM4Zlp2L1JNYVR4M2lNZGEx?=
 =?utf-8?B?THZMMnhpdTFIaEMrS0JyQnFza3ZDc0h1ZWEvcU5pVnB5QkxiSnRWZmVHWUcw?=
 =?utf-8?B?S0JDWDJ1UEhyOHJYR3ZtdGtTNW0yWGJPV245VTljQXRqZFZMQ3A2ZmRPbyt4?=
 =?utf-8?B?V0h3c254ZzBWekd1bGpWUlRLTVRQdDhHbEozWTBrU3RqdjNvSy8wOXRDTGhG?=
 =?utf-8?B?STE5VkpNWTU4R3VXamsxT2k5SHppcjFLVmRtNENwWXJPa3FmbGdkTjYzbWNC?=
 =?utf-8?B?SU5QQ3ZVa2FMUFJmeFI2TnpZaXhwUmhwaDA2dVhJOUNnaDNobXJBOE1KS2Vt?=
 =?utf-8?B?VWF2RzBXREd4QjJNaFhaeHBVSTV2MUdBVEhxY2VqZXRITW4xTVZ3Z1Bpb3E0?=
 =?utf-8?B?NFFabzZvZHlPQjNQWUNkWHJ4TEl3N2E2RHkvRmEwc1Bla2MvNWxWQm5lNUtr?=
 =?utf-8?B?SXVYWVV2TkkwR1UrdHBrcGs2MGl6d2tiZFNxTGFiRDVRSFhPOHQ5Z1lsMFRo?=
 =?utf-8?B?MExua0g4RjgyT0pwSnJZcVVTUDRTUG9HVkM1NzNNVTRZZkZWOFFydTdDQnU3?=
 =?utf-8?B?a3A2SkRxWHlyczB0VWpuRnRaQnVOVjExU1lQYVlaZW44c2VFVVlQWngvdlkv?=
 =?utf-8?B?RDJyZjNOTFZCMFQ5YXlUMnRweWdNczRwNWk5eFJod3JBL3dKTDhvQzR5Q203?=
 =?utf-8?B?OXpNaG16RTNnbWFkcE1YU1h3RUhrTzNNSWdnTlgxazBOZlZnRmVNbC9FWm9Z?=
 =?utf-8?B?UjVGRkFrUklOVlZUNUptaVBtL1p2dDUvdHluNE0xc2V5UWt2SHEwbFFYbHJK?=
 =?utf-8?B?dk9QVGZiYk8xUWQxcmg2VUlrYVczKzRCUEhldFVoeXdWNncvWXd6K25oMDJW?=
 =?utf-8?B?Y24vTXpkbm1KRm1CU3VJbkZSbFUrUkowd2dnRVdCYlVaSnM3dVh5NG9zZlNT?=
 =?utf-8?B?Um9aRVhJdVJZek94OWlPSUljeVJDSW9FdWNWWko2ZnNMNmZ0ZzE4Q2pDakxL?=
 =?utf-8?B?YitDRTYrZWxNZFBWcEtpOVBuS2tYMG01MGg1T1RWS3VWY2ZlZkNHem0yWjRm?=
 =?utf-8?B?S3BTYy9XQnQvMmdMb1VVVHpGLy9BK1JyMTd1akRnSktUY3ZxR2NoRHNFZzVp?=
 =?utf-8?B?MThJaDRjdXVrMTFRSUExNGQ0TTdPY096bnBQSkNpRE9UYys4d0dkWG1MNi83?=
 =?utf-8?B?dE54Uy9nQmpoQzNuNXdzdDlDYm1WMUx0T2dNSVhLWkhpRUs0TXNkbnVoR1hv?=
 =?utf-8?B?UHN4ZElzSTBMNDhUU3IxUlJMQW1sL1hPQVNPMGhQVi9XaFhrcTdKaTlaS3Fy?=
 =?utf-8?B?RkZzMjMvMFFma2ppODZtaCs4QnUwM0h3YmVvaW11Z3QrNTlyQWlXKzhoSUEv?=
 =?utf-8?B?UGpqZ1hJVllRa0RzclpTWWxIZ3BJRWdSdFIxU0xoWVFlMW5uNisrZFUzcHJP?=
 =?utf-8?B?ejRJajdOc29pZzRON3I0MG84M25rOXQ5S2s2dlBCa0F4Nk9wV2JPei9icU9C?=
 =?utf-8?B?bUVJSGtIWmtObnV4TXB4ZkxnQ3d5Q1NKVkhNWXBqSFp6aDR3UHZSQzFBVncr?=
 =?utf-8?B?MDdmK2NSS1dEdkc5SzlSbVEra25nVy9BWWdxS2FLamxIc2RVak5rbWo4dXAz?=
 =?utf-8?B?bGlsdW54ZjVtSW5hKzFnRjRzeDIyL1E1bHJKTVQ2L01QZ1BMSGpmVnB3WDVQ?=
 =?utf-8?B?aEYwQVJmUU8zZXBOdEt6VitjRHJJcWJMTnJHVU9IeUNMUkJGU3N0MHJyVkV3?=
 =?utf-8?B?aFRmYVNJMVI0L3JIK044bHFhVG42MHF1Ymp0RFNadGFsUEgvQktxN1V1TW1m?=
 =?utf-8?B?SVl3OFlZdFFqcWN3dmFTeXdlRklrT0loUXBxaldPTmRDWlplazhYYmpKZUNT?=
 =?utf-8?B?QkNiWU5qQWZIVjdFTktzd1U5ZHJuYmlQeFp2VTFIRjlXd2dPK3c4TWZrYzBS?=
 =?utf-8?Q?INOlrwOmeOhKIdU/3zGaDMnAA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cehONJP52pfBkeg4cqiEX+gzh30E3tVSVs4SmbBNtQ+ehnUhWpQP/TNPvgPQdVK3rK00itPlNHSHYvMHsBncFN+fANw7XpsrSK+VTs5KFCwhZXefn0cD3Cx8tcAihPmPuqzfO+m//Xs5Eebw6tLdpWr0CtqMWjCPNnUToDYnnOYjnzAgeJ9R9ealBW80M/rXAPh3WYw6SeKs95cg6AyUqgR6Rv12AoVtxDXt0gLSOIed8E0ZYr6QoFBzkn2ejbq4bFD9SUetFt9H9fnu3YjERnpLNB7b9l7ElhntgHa2zXLSdFo6qnrhHTTvO+6XjgvQYVkpnc+fYe+ltZLg5ziiN+aklzOzcvAA3Zrntx3mV4x0UwWZ2U4oZxiKy+2JEvZXIwDdVheEm7r1eFmiqZwlq9GSMdxitflFHfYph4R/vzep2iKsucl1V6uYBEbCTzK6OnoTVRK4KofyuKVLbAU0G3+eaU9YR79DKaCpFzZxd0LgppGn3t4cVL7zgQFtVH3c7FNmvhKjusYUeojfqVuD95vaugDDP42NJhCdO8QxXLiAjZazKqZD1b0Faf0SoMu7m83xezQibKOZb2NRBXXu5mz4Pfzfuc+BwhkrOv3HI6Ydtm7oGFcTjUoWfgwATQSc
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791c063b-67d9-4572-3dd6-08dd67ed69f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 20:25:53.9001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPNEWVyMdsnFqWGyKvWSJBghg+UQzIGCqKdHNc8cC2zAfL4+FycnCJwMM4BO+HCnSPwOTaiU8ZUFSswXuAeUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10193
X-Proofpoint-GUID: mMzzEimwJstyJWw-qAwxaerJJCO3L2Uy
X-Proofpoint-ORIG-GUID: mMzzEimwJstyJWw-qAwxaerJJCO3L2Uy
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67dc79d6 cx=c_pps
 a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=at0bhs02LLflEQY2P9UA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=965 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200130
Received-SPF: pass client-ip=205.220.180.131; envelope-from=sidneym@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbHRheWxvcnNpbXBzb25A
Z21haWwuY29tIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAyMCwgMjAyNSAyOjQ1IFBNDQo+IFRvOiAnQnJpYW4gQ2FpbicgPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZzsgcGhpbG1kQGxpbmFyby5vcmc7IE1hdGhldXMgQmVybmFyZGlubw0K
PiAoUVVJQykgPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5jb20+OyBhbGVAcmV2Lm5nOyBhbmpvQHJl
di5uZzsgTWFyY28NCj4gTGllYmVsIChRVUlDKSA8cXVpY19tbGllYmVsQHF1aWNpbmMuY29tPjsg
YWxleC5iZW5uZWVAbGluYXJvLm9yZzsgTWFyaw0KPiBCdXJ0b24gKFFVSUMpIDxxdWljX21idXJ0
b25AcXVpY2luYy5jb20+OyBTaWQgTWFubmluZw0KPiA8c2lkbmV5bUBxdWljaW5jLmNvbT47IEJy
aWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIyLzM5
XSB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHNldHByaW8sIHJlc2NoZWQNCj4gDQo+IFdBUk5J
Tkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFz
ZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFi
bGUgbWFjcm9zLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4NCj4gPiBTZW50OiBGcmlk
YXksIEZlYnJ1YXJ5IDI4LCAyMDI1IDExOjI4IFBNDQo+ID4gVG86IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZw0KPiA+IENjOiBicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb207IHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc7DQo+ID4gcGhpbG1kQGxpbmFyby5vcmc7IHF1aWNfbWF0aGJlcm5AcXVp
Y2luYy5jb207IGFsZUByZXYubmc7DQo+IGFuam9AcmV2Lm5nOw0KPiA+IHF1aWNfbWxpZWJlbEBx
dWljaW5jLmNvbTsgbHRheWxvcnNpbXBzb25AZ21haWwuY29tOw0KPiA+IGFsZXguYmVubmVlQGxp
bmFyby5vcmc7IHF1aWNfbWJ1cnRvbkBxdWljaW5jLmNvbTsNCj4gc2lkbmV5bUBxdWljaW5jLmNv
bTsNCj4gPiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFU
Q0ggMjIvMzldIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc2V0cHJpbywgcmVzY2hlZA0KPiA+
DQo+ID4gRnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4NCj4gPiBUaGUg
aGFyZHdhcmUtYXNzaXN0ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVu
IHF1ZXVlDQo+ID4gYW5kIGludGVycnVwdCBzdGVlcmluZy4NCj4gPg0KPiA+IFRoaXMgaW5zdHJ1
Y3Rpb24gaXMgZGVmaW5lZCBpbiB0aGUgUXVhbGNvbW0gSGV4YWdvbiBWNzEgUHJvZ3JhbW1lcidz
DQo+ID4gUmVmZXJlbmNlIE1hbnVhbCAtDQo+IGh0dHBzOi8vZG9jcy5xdWFsY29tbS5jb20vYnVu
ZGxlL3B1YmxpY3Jlc291cmNlLzgwLQ0KPiA+IE4yMDQwLTUxX1JFVl9BQl9IZXhhZ29uX1Y3MV9Q
cm9ncmFtbWVyU19SZWZlcmVuY2VfTWFudWFsLnBkZg0KPiA+IFNlZSDCpzExLjkuMiBTWVNURU0g
TU9OSVRPUi4NCj4gDQo+IFNlZSBlYXJsaWVyIGRpc2N1c3Npb24gb24gcmVmZXJlbmNlcyB0byBk
b2N1bWVudHMuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPg0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDY1DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBl
ci5jDQo+ID4gaW5kZXggMGRjZTEzM2QzYS4uZDBkYzRhZmFjNyAxMDA2NDQNCj4gPiAtLS0gYS90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYw0KPiA+ICsrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jDQo+ID4gQEAgLTE0NjUsNiArMTQ2NSw1NyBAQCB2b2lkIEhFTFBFUihzdG9wKShDUFVI
ZXhhZ29uU3RhdGUgKmVudikNCj4gPiAgICAgIGhleGFnb25fc3RvcF90aHJlYWQoZW52KTsNCj4g
PiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgUUVNVV9BTFdBWVNfSU5MSU5FIHZvaWQgcmVz
Y2hlZChDUFVIZXhhZ29uU3RhdGUNCj4gKmVudikNCj4gPiB7DQo+ID4gKyAgICB1aW50MzJfdCBz
Y2hlZGNmZzsNCj4gPiArICAgIHVpbnQzMl90IHNjaGVkY2ZnX2VuOw0KPiA+ICsgICAgaW50IGlu
dF9udW1iZXI7DQo+ID4gKyAgICBDUFVTdGF0ZSAqY3M7DQo+ID4gKyAgICB1aW50MzJfdCBsb3dl
c3RfdGhfcHJpbyA9IDA7IC8qIDAgaXMgaGlnaGVzdCBwcmlvICovDQo+ID4gKyAgICB1aW50MzJf
dCBiZXN0d2FpdF9yZWc7DQo+ID4gKyAgICB1aW50MzJfdCBiZXN0X3ByaW87DQo+ID4gKw0KPiA+
ICsgICAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4gPiArICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19J
TlQsICIlczogY2hlY2sgcmVzY2hlZFxuIiwgX19mdW5jX18pOw0KPiA+ICsgICAgc2NoZWRjZmcg
PSBhcmNoX2dldF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdfU0NIRURDRkcpOw0KPiA+ICsgICAg
c2NoZWRjZmdfZW4gPSBHRVRfRklFTEQoU0NIRURDRkdfRU4sIHNjaGVkY2ZnKTsNCj4gPiArICAg
IGludF9udW1iZXIgPSBHRVRfRklFTEQoU0NIRURDRkdfSU5UTk8sIHNjaGVkY2ZnKTsNCj4gPiAr
DQo+ID4gKyAgICBpZiAoIXNjaGVkY2ZnX2VuKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+
ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIENQVV9GT1JFQUNIKGNzKSB7DQo+ID4gKyAgICAgICAg
SGV4YWdvbkNQVSAqdGhyZWFkID0gSEVYQUdPTl9DUFUoY3MpOw0KPiA+ICsgICAgICAgIENQVUhl
eGFnb25TdGF0ZSAqdGhyZWFkX2VudiA9ICYodGhyZWFkLT5lbnYpOw0KPiA+ICsgICAgICAgIHVp
bnQzMl90IHRoX3ByaW8gPSBHRVRfRklFTEQoDQo+ID4gKyAgICAgICAgICAgIFNUSURfUFJJTywg
YXJjaF9nZXRfc3lzdGVtX3JlZyh0aHJlYWRfZW52LCBIRVhfU1JFR19TVElEKSk7DQo+ID4gKyAg
ICAgICAgaWYgKCFoZXhhZ29uX3RocmVhZF9pc19lbmFibGVkKHRocmVhZF9lbnYpKSB7DQo+ID4g
KyAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAg
ICAgbG93ZXN0X3RoX3ByaW8gPSAobG93ZXN0X3RoX3ByaW8gPiB0aF9wcmlvKQ0KPiA+ICsgICAg
ICAgICAgICA/IGxvd2VzdF90aF9wcmlvDQo+ID4gKyAgICAgICAgICAgIDogdGhfcHJpbzsNCj4g
PiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBiZXN0d2FpdF9yZWcgPSBhcmNoX2dldF9zeXN0ZW1f
cmVnKGVudiwgSEVYX1NSRUdfQkVTVFdBSVQpOw0KPiA+ICsgICAgYmVzdF9wcmlvID0gR0VUX0ZJ
RUxEKEJFU1RXQUlUX1BSSU8sIGJlc3R3YWl0X3JlZyk7DQo+ID4gKw0KPiA+ICsgICAgLyoNCj4g
PiArICAgICAqIElmIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhyZWFkIGlzIGxvd2VyIHByaW9yaXR5
IHRoYW4gdGhlDQo+ID4gKyAgICAgKiB2YWx1ZSBpbiB0aGUgQkVTVFdBSVQgcmVnaXN0ZXIsIHdl
IG11c3QgcmFpc2UgdGhlIHJlc2NoZWR1bGUNCj4gPiArICAgICAqIGludGVycnVwdCBvbiB0aGUg
bG93ZXN0IHByaW9yaXR5IHRocmVhZC4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgaWYgKGxvd2Vz
dF90aF9wcmlvID4gYmVzdF9wcmlvKSB7DQo+ID4gKyAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVf
TE9HX0lOVCwNCj4gPiArICAgICAgICAgICAgICAgICIlczogcmFpc2luZyByZXNjaGVkIGludCAl
ZCwgY3VyIFBDIDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICBf
X2Z1bmNfXywgaW50X251bWJlciwgYXJjaF9nZXRfdGhyZWFkX3JlZyhlbnYsDQo+IEhFWF9SRUdf
UEMpKTsNCj4gPiArICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGVudiwgSEVYX1NSRUdfQkVTVFdB
SVQsIEJFU1RXQUlUX1BSSU8sDQo+ID4gMHgxZmYpOw0KPiANCj4gV2hhdCBpcyB0aGUgc2lnbmlm
aWNhbmNlIG9mIDB4MWZmPyAgVGhlIGZpZWxkIGlzIDEwIGJpdHMsIHNvIHRoaXMgaXNuJ3Qgc2V0
dGluZyBhbGwNCj4gdGhlIGJpdHMuDQo+IFNob3VsZCB0aGlzIGJlIGxvd2VzdF90aF9wcmlvPw0K
W1NpZCBNYW5uaW5nXSANCg0KSGkgVGF5bG9yLA0KDQpUaGUgdmFsdWUgMHgxZmYgaXMgY29ycmVj
dCBidXQgaXQgZG9lcyBsb29rIGxpa2UgQkVTVFdBSVRfUFJJTyBpcyBub3QsIGl0IHNob3VsZCBi
ZSA5IG5vdCAxMA0KdGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMNCg0KSXQgbG9v
a3MgbGlrZSBpdCB3YXMgYWRkZWQgaW4gIlBBVENIIDE5LzM4IHRhcmdldC9oZXhhZ29uOiBEZWZp
bmUgcmVnaXN0ZXIgZmllbGRzIGZvciBzeXN0ZW0gcmVncyINCkkgd2lsbCBtYWtlIGEgZml4dXAg
dG8gdGhhdCBwYXRjaCBhbmQgY29ycmVjdCB0aGUgdmFsdWUuDQoNCj4gDQo+ID4gKyAgICAgICAg
aGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCAxIDw8IGludF9udW1iZXIsIENQVV9JTlRFUlJVUFRf
U1dJKTsNCj4gPiArICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gDQoNCg==

