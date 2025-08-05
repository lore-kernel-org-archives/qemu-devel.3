Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E2CC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIga-0001cx-4o; Tue, 05 Aug 2025 10:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1ujIgJ-0001UO-KI
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:30:23 -0400
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1ujIgH-0006as-CL
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:30:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl7Zb7Hw/XIn9CAlY0TwHfjVa8Cc+Juhp7k4zhEOKUulG4as27yoRd3ZUjl4zYE/C0Tch2z7yLCKmC9Mp3U8J3fmv7x2YF+lVr36JeTK7bSGpkbo/x51MphotBeJpQyHr7sUCCbR7dgigxAkltZF0/vRcyaCrvAnbhaW7YaPXL7UGPaEX/BCYULgFT5/MO8q6ysfwv/lFMCOKQx0W27a08l0eF9MvH39rmx4Tj3Pa+H0CRe/4SEaszG8ktQLeut+GTJwOi56dS85c93Yxn4oSlPKyRC1kZer2OX7pdzd4Wco+I3VlRnQU7k1hmhGSv3ImSFuHNiukhlCLfV3nW447w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npMvsqDi/2DgqO9Cq7odbY4qPgn7qwVhrOAIWOAq5I8=;
 b=N56e7mVLccl+JN1rnQ2XtOuXVe5S+zXzx1Jdd1JPOlRzRaIdEBD0j1rB3KRZIo/TxIb6ZqDBFyTPZgwjsLeNnxyazsQLmpv+ADpDBk/ODnQC0FAw3b4O8BAfRjwPdrjHw0ruVQ5nXZGQnKDLh3JDr4AHEbUlkT0DFUar9GSBgWbZ/BKfpQJCjhPrnStx4PEx24AZSylXlTxPrSYlH8sUT9PQtfSQShih48CyVWqu8dpdo0MLzEuZbtkAH7Ugd0M+XJ5ydZnT9sdjjTGzPY1YEd56y/Wjxr3ipwOulKaHZIho+5wQGuefnrVj0/XHJrCGPAzifdZDuquFOSrcvy7eJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npMvsqDi/2DgqO9Cq7odbY4qPgn7qwVhrOAIWOAq5I8=;
 b=oXD2TCyRVM4RVQZ68sHjydFRHdZlnbvDua/2h3Hjqf763xUkuK+HT2GLoUTcqdtLrK+qvj24boBgVVSosxgFDUjIGdHXYk9lnMweu5tlLFW2V/JOdLviP1b/ZgQX/8qhtVkc67TfAcu7Y1f6ZK8GpFgKqKsJOejf1krSg2INxPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GVAP278MB0053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 14:30:10 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1461:a808:5787:602f]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1461:a808:5787:602f%5]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 14:30:10 +0000
Message-ID: <73d56742-5e6e-4e1f-8d8c-2b9783d0ddea@epfl.ch>
Date: Tue, 5 Aug 2025 16:30:09 +0200
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: pierrick.bouvier@linaro.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
 <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch>
 <874iul26rp.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
Subject: Re: New capabilities for plugins
In-Reply-To: <874iul26rp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::22) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GVAP278MB0053:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c9c20a-441a-47c3-5cd2-08ddd42c9523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MCtQbVBxbElVbWxWQ29WdW1HNk1icUUyeFRSdVJiendhZXJBMXV2UjVNYUtW?=
 =?utf-8?B?T1Y4elBWdG5BTlppZzNiYlVzL3ZyelU3d2QzaS9KUUkrb01XV2k5OEt5SE1v?=
 =?utf-8?B?dkZON0VoK2xsUDZYWU9lRG1FK1J3d2xsZnBlWFRVOEFOZDFCSGZCaDNEQkpL?=
 =?utf-8?B?OWw1Y0dyd05HWEtHbDVqR2hqMENYOGVNdDZlVGRWcjFIbmRCZlBrMFdyWnR3?=
 =?utf-8?B?UnhvZW4zbXBJTENESTZ6dWhpNnd0MWk0ZVArLzdIWCsxcVpDMEtuVHdkSE0w?=
 =?utf-8?B?VGJEM1JyR0xXR3FubmxrbjhWYU54MkhWZ2ZHcGhTWnJ5Q3o1am4zSXV3cEFo?=
 =?utf-8?B?NEx2YWQ1Q1pNdWp4dkVuMDJYZUttTHdCRmE4amt1YWIwb3JrU1JJMmwyWHow?=
 =?utf-8?B?ejZ5TVFnSWhWQ3JUenNGeHl4MG00VnVwdzh5eDFSWlZkQkNVUzJCTGNHRXI1?=
 =?utf-8?B?QnFETEh2WUM2UkV3QzB3eE5zaS8zRjIrbFk4b3JQazEyR0FDdDdSQ0JBaUdR?=
 =?utf-8?B?dm1nZE9OSmY2RGR2T09BM2JpNnBtS1FnTVpXenF1bEJjRm1DMVVaVzl2SG1j?=
 =?utf-8?B?MmNHbWk3ZUtTb2NQZy9abXJJdzlpMUd4dm5nYmZKWXYwL1hBempsb2xrK3NY?=
 =?utf-8?B?NDdnWFhuNDlhdlRkTHR2VDA3Mk5iNmswYnJwQkJSYkdGdGNVUy9hc0hLYlJM?=
 =?utf-8?B?LzFVaXRBUENpUHl4K3lpMjUyZTQwYUl2ZlpCRkNkeUpwdnpjY2hzVEdHa216?=
 =?utf-8?B?QWxCTVVzWEdTcWl4V1haWEczT0xGWnNmZmZSRlFCWCtlZ0plWWQ2UGx5djQz?=
 =?utf-8?B?Yjc5NjAvd3ZnR3VaRkZhRzZKZWQrRElpMXlxYzg5MFFtcDh3Tnhjemd2amQ3?=
 =?utf-8?B?OGZkTUJCNVVZUkdyNEg0UndsL2RDV0lNY0RZVjR6SzVLL3hmSkxKcjN4VzNL?=
 =?utf-8?B?cWpTZjdUOC9teDlxR0hjMXdGSkp1UHNabjZtOGdKREp1U0plek4wUlh3T2RF?=
 =?utf-8?B?VEx1K0k2Tkpzc014TEFyZEROWE93dm5kb0w3Y3ZmZTdKejlzd3ppTllqVmxv?=
 =?utf-8?B?TkZjT09NN2ZPTkNmMnhvYlRWSXZLWEUwUU9QdC9rTDl4amoveXB1Wm1aYVF0?=
 =?utf-8?B?S1hMWWc2REROSGg5SkFuWlJHVS9ENVRRT21GQkdIT1FrS2dnQ2tFcFNLV0o1?=
 =?utf-8?B?bkZPbVJCZ204Z0JYM1VjeDNreC80TW8vMk9DTDVhV1A4RklBakRJL0JLYlJQ?=
 =?utf-8?B?Yy9pTWNSd2x0NHJWVEJ0YWNrbzFVQkpKQldKSEF3QkV0RHFWV01ZSUQvMjBa?=
 =?utf-8?B?NDNXMFNvMmkyMHBnUnhPWlNpNkRwYTgxMHRSTXlKQ3huUXF5M3JTbHRXTjBH?=
 =?utf-8?B?RzdaR3dQNHFBMXhoNElwMWhCZjBXb1ZzNHBHanpsZVh4WG9LR24zNmt2VTU1?=
 =?utf-8?B?YXlqTzdoSzJFMFRDSDlVWnBzL084RklCREFqNFVsNU1VdEJqbk1xSzZzUWh6?=
 =?utf-8?B?Z2ZSOFhjODV2L0FtVWN0cXM1OXpibEJiQk9jd1kzOWd0VXZIRVQ3VG5KUGdI?=
 =?utf-8?B?eHZYUzdDV2pZOTZrYnBTWjl3Qm8yRkUrbmVRd05GVXErSG9xUWFONWtsclBs?=
 =?utf-8?B?eXgxYkxLNS8vSWp5UUpZZWpCaUpCdDBEaVBtb2xtMDh0OUVCcW1qR2oxZ1g0?=
 =?utf-8?B?NUpDaE1YWlQxbE9HZTNGRE9JNzUzNXpQZSszd1U5LzBzTkV5S1BZMU0yczE2?=
 =?utf-8?B?QVF2cTVFNFl5WlhvOVpCZlRrLzNSK285R3c0c21Xa084TE1vQ0NPWUoycE85?=
 =?utf-8?B?b09jVU0wOEFzNEdROVY4UmhnSTdIZEpNRTkwTjY2Rkl4ZkRUa0s3UmxVQyt0?=
 =?utf-8?B?MkdnYW4rQ1hEeFFpcDJvUHBadVp3S01RV0NiUkdsYmJZUTA0MlFpSGthVXhx?=
 =?utf-8?Q?HhCtle2Cokg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNUVTNDaXVVWGJGRWszR0xJRTlPM2hZeFRzWFBHWDlPWk5PY1JoLzFNNFNQ?=
 =?utf-8?B?NTF4d3UvdUs2dTJYamd5VUlUK3c0VXZaQUpqUjl3MW9NOXJDQ0FGK0Q2OTg2?=
 =?utf-8?B?ZUlnZnB3a0wxUXRYK1h6M1c0RzR2NmNSbnVPZkVoaGNTZCtJQkRRbkMxT0pi?=
 =?utf-8?B?L2IvaTdoK2ZWOE95Q2JnTXNMb2NDbTBRS0xKakJ2ZVhPWHUyMUJXU2NjblIx?=
 =?utf-8?B?ek9OMmxtTmE1L3ZsUFYxSmMrVlR5R00yNGhqMWxtQ1pzekduYUJPRWIzSERj?=
 =?utf-8?B?cVJQNUc2dTRoNU5OVmVuRUZNNkVDYnBIay9Ka0EwU3ZMMEZsVXM0U2Q2eHNZ?=
 =?utf-8?B?amsrZVVPNnNWeVRkUjl6NldjUkxOM3N1VXU1OXBxeDZuaEdjU2s0d0dmRytq?=
 =?utf-8?B?d3FJUTZ0UTRZa2hXSTFUczRDRkZHbmc2T3lTYmJ6TUdScVRUbEEvMXhRdkwy?=
 =?utf-8?B?WTFyQk9xTnYzNDhNYXlGQzFORkgyUVBJMGtMdWczVS82UTNFdFpTanp1QTNv?=
 =?utf-8?B?cHd4MjFCb1RtZ29RRFlOZld4WnZSb2I1ZFRXM3RJSU16N25DWUdmWUhIYjJs?=
 =?utf-8?B?dTFtd3ZWZXYzVmtMQ1habWg1MjBuREZpbTRob2c4bERjSVBRcDhoOGRpNStj?=
 =?utf-8?B?N1JrOERzWGcvdmI4dlJKWEJRYS8vWVpHRk8wZldKMkZCR0ZoRDFrbUZMQjJT?=
 =?utf-8?B?K25mQWtONjNmdnpUZ0xPdXQ0MjUzNHNVK1pXVmxxVENMT3Fod1NnejJXMENr?=
 =?utf-8?B?S2hkSFE4VTVMUjVUUys5a0xwemF0d1VpS2hiNTcraG43RjhCRVdKaWk1YkN1?=
 =?utf-8?B?NjByWDFqdVRGYnZocDR4eVNveER5QjlmVkRRMXFNTUdDMXZCZmFBbTdlSi85?=
 =?utf-8?B?Z1dQZ1J5MVhOM0RYK1dPYkdjOVhlWmhPcEJ4WEEwMldHeXN5THFQb05Nc0JZ?=
 =?utf-8?B?S2dBcmE0d2JqblJGbzZqZGdzNGF3ZXpBcjQ5UXg0TGZNYTloZitTeUphbHd1?=
 =?utf-8?B?VEJkMkt4UmZOSFduTFpTOWlFTzVqVnNuSWFaWmRzcC9qSmREU0dzNVdaNVpx?=
 =?utf-8?B?RzRvN2NLSCtHTUF4UE9yZ0w5NTJUU3Y4Z1JkQnZ6NzNQbElIQ0NPQ1M3bS9S?=
 =?utf-8?B?bnpobThBeUhMZEhoUlNHSjFSV0F5VVp3OVN1RFMrVi9LS1A2clpsaUZDMkUv?=
 =?utf-8?B?cTc3QlhlTWUvUWc5dUZqTE9BUnpJV0Qvc0FpcE4ybDVkVHREZ2h1UkNaQ3lp?=
 =?utf-8?B?NTMzY2lLY3VGaGxOWXQ4TE9kRDRvQnpINHQwcWp3TURYajJXOHAzeDUxMUEr?=
 =?utf-8?B?K2J1YWJTNXRZWEt4V3NEaW4rbWg5UzVUTjFtMXAwV1VKMDlLTXk5TExBK2pV?=
 =?utf-8?B?UWxFeklpTlBBejIrTnZWR294czQ3NGlzY1Noa21kOE1XTHFBdFRhYmRhVmc1?=
 =?utf-8?B?U09ucEdMTHFWZnkzaTMvcmJtNVoyMkgxU25wMDE0S0RFSnpZT0QyWGFyYjJF?=
 =?utf-8?B?ZEYxWjhUWWl6aitMUTZabWNjVENKWUQvUnRFdmxoODRDWEl2SEFvZ05KMzNS?=
 =?utf-8?B?QmtPR21zOXQzS0trR3ZxSzJadzU4Nms1NTNHTHVrTm9sN3NtRE9HU0ZZWlZv?=
 =?utf-8?B?UHZhOEpWYzJIMHZDRGcxcjVHNzNickZ0SkRWOUI3NmxHWU5TKzJGK252SEdv?=
 =?utf-8?B?b2IzR2k5RFZ4b2FJMkw1VXY4VmZUL2kvMnhpOFZLZmFMS1dZY21mRE81U3NW?=
 =?utf-8?B?d2lEc0J0ZndBRFhXR21PbWJQK3l5a0pteEhiaTUyQmpCY3U1Ykh4dklEaXJN?=
 =?utf-8?B?aDExbnNOOEUvOWFvNDBJOExwb0J6WFo5by9Lb05nSElTNWFzQmQxUGVvSy9p?=
 =?utf-8?B?bC93ZGdaVEdEb2lrb3FkZ1Q2bXZHRldnVTFJYW43MVUyTGtVbDJaUFJRNDYx?=
 =?utf-8?B?UVFzbFg3WHA0emRWaUNodnFiQ3RBQTJPZzQyZEZjRXZNbDBSZSswRW1MRXpr?=
 =?utf-8?B?YXk1Rk9MZ3ZRYjZkczFwZzA4RmZpZnVScTdhZHNEVitUUUl4b1EwcjNLNDhD?=
 =?utf-8?B?YTlvSjJqSXdJNW13UXR4bjlvM1JyUkl0R2FJL3o3U0dzVFZGejY5NFVnbmlp?=
 =?utf-8?B?TWl6aUJZWjRsZkRZVnorWTFXOGlSUm0xYjJPejE3alZiRmxmc1VIRlBaWlVs?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c9c20a-441a-47c3-5cd2-08ddd42c9523
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:30:10.3717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQRVm+zVPL/9kXln3DWoPu315ZjO6CwjV55VcmCl7aHVtH+sP+b4mFLkgyTtf/PyIkW/BNLnvJBPdRQFmhj4rN21TSQt+IRyjNf5EE7VViM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0053
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 05/08/2025 16:16, Alex Bennée wrote:
>>> Another option would be to have a set_pc function that would restart
>>> the execution at new PC. Then the vcpu_syscall_cb callback could set
>>> the PC to post the syscall with whatever state it wants to set up.
>>
>> Such a set_pc functionality is already covered with the register write
>> API, as long as I have a handle to the PC register, right? Please do
>> correct me if I'm misunderstanding something here!
> 
> Ahh we should make that clear. It requires special handling as the PC
> isn't automatically updated every instruction. For analysis this isn't a
> problem as the TB itself knows the vaddr of each instruction so can save
> it if it wants.
> 
> Currently if you write to the PC it won't change flow - and it will
> likely be reset as we exit the syscall.
> 
> c.f. https://gitlab.com/qemu-project/qemu/-/issues/2208

Thanks for the clarification, I haven't fully thought the implications
of updating the PC on the jited code through.
Do I understand correctly that this would likely require hooking into
the TCG in a way so that the target address of this set_pc function gets
retranslated? While I've dug into the QEMU code quite a bit already, I'm
not sure I'm familiar enough with the TCG internals to be able to tell
whether such a set_pc function could determine the address of an
(arbitrary) already translated block. I.e., if the target PC is not just
the next instruction after the syscall, can QEMU determine whether the
target address has already been translated and if yes, where the
generated code actually is located?

Thanks,
Florian

