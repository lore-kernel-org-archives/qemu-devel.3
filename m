Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24232CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zd1-00057q-Qm; Tue, 23 Sep 2025 05:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v0zcx-00056w-Pb
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:48:05 -0400
Received: from
 mail-switzerlandnorthazon11020082.outbound.protection.outlook.com
 ([52.101.186.82] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1v0zcl-0006sj-PK
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:48:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNklUq1m38B5rPw4ZXOvmW+ZoGeLTu01fIACZn0EQHxsOjFdRhlUEnIPuLwK5vD8WNd5jTe+DiS0sl4YtXPuJjVv3oLgjV0tkEsC5Up/N0sGtIuo0Ciadu1O5r01KAzqnkij6oWQkw/OMT/vNH6FczyZzUlXjtgIpP2x5RojeTrljOud+hpctrUMqW03PvsWycl8w99/WnHAeXoF4NeEIxcOyFyR3ipnofoccAe7iwX2FkpTJxnVD4gd+oZyourls+8R498/0MBP4motNFDrUGvELn3qonn17HCCYxBvEpk8Z/hrAu7Tds/PJ6i3i/cP9Zj0wX0TNddQhWnNQVXoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w+PgzPOoJYRSDHH88rWLUlgnDbwmJR9xtU8Y+ECZKo=;
 b=uBOTmQ6nyJa0hF/0IuSr+ktyOIV5R/SOCaJ2r/lMETyRZ8zUDrlEpDM8HZexaOj/rAUdqKpEjF3AUCr6y3ciXtFCdYPsWRqyNsYOyNlhZMxJJKiUmHSK4LK2zxdGy2vuWdnZay/p4ecBVulkklKOguSjvbFG5C9kVTafTKApmD1Qsc6kHMaNd6D1yBIeYoh/krAuQY3z6Rh0oYGtHBJ6GGhUoNwGSNgnybGsu12sjkY9qEAwuQAO015NX/8KRgo7+zPtOIQhS/Nh+G7F/WB4zAq5tQUgHkdFo+Pu+mqBcX5MVJ4dRVx4E+B3yKnttrM+8eYhoeMvtAeYL4jclC2m/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w+PgzPOoJYRSDHH88rWLUlgnDbwmJR9xtU8Y+ECZKo=;
 b=d4ZqVZHLQUvkw3vkLlBlzz0iAH4dWjGCbBhPO+yi7wBvzWhVw4NlP1ik4rMTeCGgU9n6F4VdfwESkR91ReIz7f0x5Pl6ta2witPHMCBOy+VPo2Ye24BBYx2boYsdULsa9OhDT0KOMjvqvEgm8lt5JbTeTUxtYPsNw2EVoio/ZjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1624.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:8e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 09:42:44 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::db00:2f5f:f4ca:ef69%7]) with mapi id 15.20.9137.012; Tue, 23 Sep 2025
 09:42:44 +0000
Message-ID: <1588608e-2ba1-43d8-98e7-3601b7a0acb3@epfl.ch>
Date: Tue, 23 Sep 2025 11:42:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: Add PC diversion API function
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <f56b02b1-3b50-424a-8b20-c5e5e3e0212a@epfl.ch>
 <87bjn6n1x4.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <87bjn6n1x4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::20) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1624:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d0f8f1-afd1-4fff-addf-08ddfa858b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW4xVFl2azFLTGJJTnZIbVROSVB1U3RnNmRJZGV0Q3dFOGx4NHBHWmJjclVB?=
 =?utf-8?B?bDJWbXZZQmowYkxqVWh4RGFSYUYraDZUb25BREZ5L0x5K1hpczM2eU9VMVJi?=
 =?utf-8?B?bGUwQnNqUWxQOElDaEpBak55SXcvK0VQajBCeGZqRzlEbnRBcWl6QXQwMlRN?=
 =?utf-8?B?S2VBbVlFTTZ6SUgvYUU5Y0kvenZleWVpVTFXbEx1T2RVVi9pRnl3clkxZHhS?=
 =?utf-8?B?a1dPWEtFUUJEOE9uZ20rdnJ2ekR6MHp3czExNkc1YWxYTllYZS9OMkhQUjZ1?=
 =?utf-8?B?NjlLUk8xc01JNkF1WkQxNGZSemFXSVVmTTRjVm5GVER6WFFLeEpweEtoSXEw?=
 =?utf-8?B?LzJYTWhlRjVuSTAwamNiSElhaW1CYkprZ3VWUytTakh3SHB2V2FVV3hoWFZW?=
 =?utf-8?B?YzVDV2ljc0w5ZDBqZGhqb3JGVWlKclc4ZjlTSlpzRXdQQWNsUG85VE83VnIw?=
 =?utf-8?B?M0tEVW9ZcGtOdHpIQ2d6UlVuWUJFL05pOHM1ekpYTkVSRzlSUnZUMk13VXpu?=
 =?utf-8?B?ZWhSVzZHVncydDdzVjZwS3k5aHF4bkU2dkxDTVlNSG1yUWFtN1YrOWVPTnZ5?=
 =?utf-8?B?T0lPclpwZEdNVGJGeGtoUHhLR1gyZUFvd0ppcFRwREZtTXdkMGxIUnBVd2pG?=
 =?utf-8?B?eWtGM2NETlBhTmFTcXZuOHVUL0NsNE4zd20vM0lUbVgvWHZ4S3RXK21XZVpj?=
 =?utf-8?B?VC9BajhQWmFXYU9hSGZKejVJWm5qZE9obWFhQTNmQXA1djI1QTlnOW1QeVZs?=
 =?utf-8?B?WFNRZHZTR3p2bWYvSTBNTXArMTQrYWEvUFJVVnpyRzN1NWFnbjJVQ0RnTDBD?=
 =?utf-8?B?SHFidXRNTEVRWGl4TktYSytYbUc2ZDVJRGd6RmJGUEFwLzIxMmFEQTZOUWkr?=
 =?utf-8?B?cUhnM3BFUDZ1NTY1dVlyUk5RV1RzVWgzMytHL3ZMNnBrb0hGOEVyRGx4endU?=
 =?utf-8?B?RmN2VWlrekV2R0xXUmNVS1hZZ0QrMEpSVk0xZHhmUmp6aWZJeUR3MStLb1lI?=
 =?utf-8?B?UVJGQ0N5TEEyOXJzY04rVTE0dE52dEFSaC82M3lSVEN5czYzcUd5WXVxY2RI?=
 =?utf-8?B?anB3V0xMcEErSDRhRjN1MzYvc0Jrb2tiWVlMb2dWdjZlcWYyRFhLd1JwWUg1?=
 =?utf-8?B?RjAvZWN4Y1BhbjlseW9YVzVuWFJyZlFXQ25ZcTlxekxDRzdEQjhmSm1mcDU0?=
 =?utf-8?B?bjYrYTFTMWpVb0gxRGNubGNmMnJKcGJleUhqUHQvTXdwV3FyajQyRU5TSWhw?=
 =?utf-8?B?NDdRU2lDVTVnaEoxcTlMRjJmc29MMGwyeUI5dENLMU9xMUUyVFd6UEwrTHpO?=
 =?utf-8?B?aGRXRnpISituTnI0QjI3ZHl0RUpxblIzVFFNZS81WnRFRURLa2ZnaXI2bFY4?=
 =?utf-8?B?TWVwMFc5MWFUS3lnQ2FTWnhVWU5BSnNibTZITmY1Um5UL2R6eTFkNkRlVEFl?=
 =?utf-8?B?QXpZcVlwR2t0emxka21ydU5pb3RKWG1peXN5ZEJTQ1luK2NVRmdpOEU2dlVD?=
 =?utf-8?B?ellDUVpMT1lmRU9GaHdLRFFNck5LL3FZblQra0pwM1pDaWRsRWNuUXhRRDdr?=
 =?utf-8?B?NHllbUtDT3hvcUwyOFdSYnpGVFdINERXeXgzMzc4bWRlSER2RW03eFFvOGJ6?=
 =?utf-8?B?bWcvai9qelpaUHQwL0JiTEF4Skl6WElmMXgzV2t3SXBLZ1FabjVZeERSNFlE?=
 =?utf-8?B?bzd5OUo2cXp1TjJhdjM5NWVOb0d1U0J2a3AvdFdhNEszTGJTckxURmFMVXVz?=
 =?utf-8?B?VGZCcW1vUnQwK0x1Vkcvc2gvVS9XQWt2Tm1aQmczUmJHemtnSUs0ZVpZNXpH?=
 =?utf-8?B?a2ZUZDdMY09TT1ZVRUxVZHJMQ2lVM0l6NXg1WFpDSkpoMm4xUmVZZHJMbjRJ?=
 =?utf-8?B?aUZHRmxRUGF3T3phYVNKY1RKdUpzaWFkZERrY1gxQ3FhbGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dHbGZFNWlkYk5MdzRNWDZKMG51R0wwb2xhcFN6Q2hMeiszczRtNWNmNTdK?=
 =?utf-8?B?b1J1RW43MEUwNmswVFBYUElLNnNLbkZMT0w4SjRHdk9aR3JyY1ZEL1dqRlpI?=
 =?utf-8?B?TVQycFRqamxyR0kyeGZMdkpuUzEvWkxMWWh6TUlhRC9OWXQybFFYVTZJbVJm?=
 =?utf-8?B?RzZiSjZVcXk3MUFzV0RTUU5kYjgzUGlHaW1WckVRdjBWNnJuUytqV0FreG5W?=
 =?utf-8?B?UGZ3VUlCVGJYeHdvUVpjZlRFZXVsOEFJUlFYdlhjbVVEaWVJS3V2d1l0Tjlh?=
 =?utf-8?B?Z25SQlJQZU5oOCtBNWVVQkhvYUFEcWovZEExQTJmNG9RM0JCcTduelRZOVN0?=
 =?utf-8?B?WWowK09sQUZJU2Fnb3lWdVlqSWI0M2VPUlMwdTNSVGFhZ1R5R2VEMkNsZ0lZ?=
 =?utf-8?B?K2pkbTRyOHZ3dWxGdC84NERWV0N0SWFMNkIyQWpMY2RXaUdSalBlUkpMM0U2?=
 =?utf-8?B?L1c4b01KRTZ5SERpSnVjRUp0eFM0ajNDdjN1Nm1PZzE0VE1SOTdDT2JtUlln?=
 =?utf-8?B?clFpc1lJQ2ExUTY5NXZjY3ljQVdEYUkvNGNhUVlwcnBoOUN2TG9aV3FWRHJW?=
 =?utf-8?B?c1l3YVl1YzBteVd0ZEpjdUJFYWJMQUZQeXh0WmpBdHhrTE1pbHk4ak9pSjh2?=
 =?utf-8?B?L24zYml5aU1hWFEwT3Q0ZGV1Wmx2UWZnNEJ4L1hSTU94L24wSjlVNlpLcGNy?=
 =?utf-8?B?NWVDYWhFQllvOW1VUGZxWUJoUjR4QW9EU21XVng4Sm9xYmV5cjdUVjRqV2U1?=
 =?utf-8?B?U1lDQzZGeTNTY1pIUHB5TWVWbkZmcWpxY3ppTGF0M3BqaVEvcHZtaVFCWVFL?=
 =?utf-8?B?ZFkra2dNY3VrYzJKNW5uQkJlOUVHNW5RWm1RTVBZMDUyZGtPSmNISHNEaW1P?=
 =?utf-8?B?R0d3aitsU2JSc1NLT28vaHRUQ0ZOTHR6dnlvWmVJcER4UjB5elJ5ZGtxUGxS?=
 =?utf-8?B?Z1F2UlppZzk3aFVnNGgrajV3cVBZa0FkVWhHZVVZODJCb2RDczc1N0pKRkNz?=
 =?utf-8?B?YWg3RlpBSmVwNzBkVis5L25Fd0JhMW9rUFljM0UxLzVQYXBETW1UVmM2dGVZ?=
 =?utf-8?B?a2s1T3pRL29LRVFndW5IOTkrQVZpNEF6QXN6clBMOXlkODE2R2JkOGlmWkxM?=
 =?utf-8?B?Tkl0UHNKWVpOSUlaNnJmd2JrVlpINmJmMThKbERWUkN1Z0p2SDEvK05EbnNE?=
 =?utf-8?B?TjRLRk1tVE5JemQybm5yUURUSG9yMVZJd1UvOGdDTkYwRll3ZUVISEhGOGwx?=
 =?utf-8?B?VStaMlBzUDhjRjFCOC93aHgwY1c5Y1RoTHhKc2l6ZmkyeFJhY1hoOXg4b2Uz?=
 =?utf-8?B?OEN5SmI3ZWdTbkFmbkQvbzg4WlhTMTc3bFZ4c0lPMjgwOXhSZ2taemtSQnVJ?=
 =?utf-8?B?c25hY25CMUF2MlJObE9PbEMxZGhRdHE5TWlpN3JnYmNUaFBINk5VOVh4WjRz?=
 =?utf-8?B?OWduR1IreFZWWEJlY2VLNDExcGhVL0pOeXhIVWVoL0M5ZmpyRFZMSUMzWVZX?=
 =?utf-8?B?UU1MS2txbVhVRVhJNDNKVVptWDhtSFZyNkpIQ3d2RlVzaFp6K0N6MS9WRzZz?=
 =?utf-8?B?N1I0ZUoyT292Ung1cUg0OStWdEZUSzJ6QVdwOVk2cjI3UlNPQmZHeXJpWnJM?=
 =?utf-8?B?V2FaNkEwc0RyWG9JSDRCT2UwNUhOekhFSlQwQjd2Q3d3RWdUc3l6akt4WTRn?=
 =?utf-8?B?MTdBT1BVV09pS0dyS2dYL0RPQU9YcVJ0WTdhaUJ4Vy9jeEp4a1dNSGVVa2pP?=
 =?utf-8?B?dDdIWWJTVm11RDcwNTg3Z1RrUXp3RDd4a3FOejhPTXEyeGp6ZitORDBBSzVK?=
 =?utf-8?B?NndLNTltQmNEaFdRM2xzNEZZc0JHWFkyaHkrOENwalNnMEowRTBPU05KakVp?=
 =?utf-8?B?RXEzZzJINmltQzhEVVdTMmxHWHBRU2FUMm8veTRKeVp2aG5ySmtId0RXKzhL?=
 =?utf-8?B?M0FKU0lTOXBnaENWMGhDQytSUFZiV0RLTktJVmIxMUpwUm43V0gzeEdzeVQz?=
 =?utf-8?B?RThMTEliTmkwWEdMbzh2ZElvY2NEdm5DVDRBblJmRDVTMnI4RXdreEFZdUtZ?=
 =?utf-8?B?bEI5cStpdS84ckhPcFVVNDZzMHpQeTJUNkRvNmZkZEZLcHNoOUM3UkdzZVFi?=
 =?utf-8?B?TFVrSmVmL092M3picE1ZNCs4MjZZSTVMWVlzdUdWN0poVTF2MFFwUERFblYr?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d0f8f1-afd1-4fff-addf-08ddfa858b99
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 09:42:43.8973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU1BF8bbwCZPhxql8fbU5CtTYI80aLl2Vwwcb24E2A8yMM1ZLkSbqgid/fhLFBWoFUx9BKtEMwFw83QB9oHzBu1Xp+uXEMIukISlYJ/FreI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1624
Received-SPF: pass client-ip=52.101.186.82;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 19/09/2025 12:59, Alex Bennée wrote:
> Thanks for taking the time to roll a proper patch. I assume this is
> working for you OK?

It worked well with my initial tests (basically just a simple
hello-world). After I sent the patch, I started using the function
more extensively and it's triggering assertions in the
cpu_exec_longjmp_cleanup function (cpu != current_cpu). I am debugging
this and I'm trying to figure out what I'm missing in my (arguably
very minimal) patch that would cause the stack and with it the pointer
to the cpu struct to get corrupted.

> If we were to go forward with up-streaming we would want expand a test
> case to cover the new API. Maybe we could expand the syscall plugin with
> an option to emulate a system call.

I'll add test cases once I'm certain it works properly!

> The current potential foot guns I can see are:
> 
>   - are we called from a callback with QEMU_PLUGIN_CB_RW_REGS
>   - could multiple hooks be wanting to set the PC?
> 
> Not doing the first could potentially loose you register values which
> wouldn't be rectified until later in the block.

Good point, I'll add checks for that.

> Currently we maintain the list qemu_plugin_insn.insn_cbs in the order
> they are set. However if the callback that changes the flow is in the
> middle we risk not calling the others.
> 
> Currently there is no protection against multiple callbacks wanting to
> change the flow.

As the function immediately changes control flow, the first call to
this API would win immediately, without any further callbacks being
processed. Do you think it makes more sense to set a flag and check
for the flag after all callbacks have been processed?

In that case, the question arises however how to handle multiple calls
to qemu_plugin_set_pc in different callbacks. Is it the first call
that should actually win, or the last one? Or should later calls
trigger asserts if the flag was already set so that we ensure the
function is only called once? Happy to get your thoughts on this!

> As you see the actual mechanics of restarting at the new PC is the easy
> bit ;-)

Well, if it works properly... ;-)

Best regards,
Florian

