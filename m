Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0637AD2ED1E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDdW-0001KV-Kl; Tue, 20 Jan 2026 10:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdV-0001Jo-0l
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:17 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdS-0006ub-GD
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTV0Qq2l8DQtQm926DqPIhZ/admUnaNgZNwaDOMEUenAgxFuMaVjDOHJ4zez+c/dsx+WHGNvmcHFjcTE2uCGO7eKOV4vVjnBnrq55wX+ghDEtBW9dHm1xcXNzYWWr0DDkYkrG+bpv1sRRrW+QaEPOlGhN9fQl3qgM8+o7+zg1m6ygsre3663C6Oj6MjCf1GpQFlUs/jtU5PyPz5MYCqPQzzZ73Qr4OREuOzUZv+OFpGFZbCwNrm4ZJtk9twPcL3p+CgFH8ySzUQT2mrIXiouMnmo2mCeA2mPfz28wNwfxcbt7q0h8vqv8i1P1rNpeXMbvlsuWQGB6egmLWLMgTGDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLJhPUhtV8JpYp5/9Pa84WQhIp6fn072yrF/HSNkUxA=;
 b=kMOePK8CIMH7zK7dBlG2jQJ7R74JXkuve2zBs4XcVYdmERhLB1IRwL94TzV0OO0BSjf3hiENQ60KlVU50euGFkCWdjtth/VPkBI7e07LzAzLb9TLNtArC4jwJvuChZe+o2Cm8IimJD8m8HvsCvWLctQaS7LDbISN/IrSv0jeTqOX55tSJJUxe4tWCUH5XEza2LbRZZT0Le4sqZ0q+FqF6JuuVXSKF2Sev6SFYUXX5rsaausGK4OsKvpQyzfbuaRhrMpgWx+k2MI8jWavevIMWOsk5JrPEOgFlwLPBsT3BjgNZRDcPs6ssmckEhtwtqY0/LUBOnCDGkMM+di+EM+EAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLJhPUhtV8JpYp5/9Pa84WQhIp6fn072yrF/HSNkUxA=;
 b=OEEhO5rkHIihjMjROkuybZPe6dovNDam4fuMFFMFUD66QyrkHyC2yZUCneiitFJjzJ2n1l4SY0HQcaGeNnrSmjpwK5qPpg04mHsvidGMS6D0UHnrFBYAdCaCydUxWIGLiwesu29Vdd5JJ584clWpDFQGBV5L/Ebz1tH1lECnMHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1PPFBC9E76CBE.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:27:11 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:27:11 +0000
Message-ID: <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch>
Date: Tue, 20 Jan 2026 16:23:00 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/5] plugins: add read-only property for registers
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::27) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR1PPFBC9E76CBE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5d3c20-6311-4c06-aae1-08de58386056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|786006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUNBNzN3WGRxUnNPZUFRMDlob1l6NnZoN2F2RlJRa0dReHk5NEQydGsrN3hD?=
 =?utf-8?B?MklMWWxHdytYd1B4S1dxdUVzZVhrbWI1UFZ1ejFuY1hVUUszbUtPbmRFd0VJ?=
 =?utf-8?B?Vnh6TVYvUTRtbEFKbXdmTzFrQmJ6RHkvR1hEZ0dROE5ZM0dycGoyR1FVV2tE?=
 =?utf-8?B?VUZCWEZuYlNibDhSZTNPYit6MmJLTTRaMHIwbklYcGU3am1RSDk2NFlUeGpj?=
 =?utf-8?B?MXlpNUsyWG1BalVyRk9Kc0ZocnY0N3FuNUZ4bU0zNDR0YkpObTQ5YU01T2g3?=
 =?utf-8?B?dFpnOXJoY3lFMjFVN0NwSlEwV0Yxamo5QUtyVFV3VzVRQnk4UStUTmtRUndo?=
 =?utf-8?B?VnE3VWNBekVkbWNCNktENHJjbmtRNmNsbDZDV1NjNkNDRnJXdXZLcGp1dkEy?=
 =?utf-8?B?WklLODY1NXlhZHZIcko0QytnY215OWM5QXJJbHNERmlaTnpwNVNXNWxBVFRW?=
 =?utf-8?B?QjJBbHJHbnZsQld2aTZvVGJKZm92eHJiVWlSVTdiR1V4dzhoUk1iMjc5ZFVN?=
 =?utf-8?B?SEhhZlE2enZYQ0JDbXZPcHZNSnFkd0RPUnVJVUlCa2VBNmN4SWlZSzYrclU0?=
 =?utf-8?B?dFdtV2FOSG5WbUE5MHpuUW5QVjl5RnBmbHJWRFZZQW9mY1RyWjU3eTl3alZY?=
 =?utf-8?B?TVhucXk2d3VCanJQR0lkVzVYa1RIYlZhaEVCMHpPMGwwdytmZjlpbXBIa1Y0?=
 =?utf-8?B?K3NQZlpSNGRWb1Q4Y21BU0dFREdub3YwSEFOWGVzRTlqbUU5a254b2M5NWp6?=
 =?utf-8?B?cURyODNWWjhySnlUcEdVUlJYVFZhNmRDSDdhYWMvUmVRd1crZnpnRWJhdXBE?=
 =?utf-8?B?NkpQeU1uOGovdk9kTjRlRS9zLzlEYWFQeWVaQmVLYmp0emMrazZIK1F4VlFX?=
 =?utf-8?B?TVRjVUZHS1Rqbmp5WGRnRy9zdXREVlNtVy9ONUxGd3dJYndETmp5MHdqNDBm?=
 =?utf-8?B?R3hhU1ErN2h5clZhZEdqSjZHRUF6TTRDVkNVUmt1NXhJWGJKSnlzMVYyTWN6?=
 =?utf-8?B?OVhPSk05THI4KzNlSGQ2L0k3bnhLSkd4NitaWXRNbWMwSExlMElnTnFjRWs1?=
 =?utf-8?B?WmVJSUVrSDZ6T1d6dDhWd1ErUzNEWFRFMzZLbmlSZ3B0TVRzalhGNThGakpE?=
 =?utf-8?B?ZUhxT2NhVHB6aXEydHgrNzZBVjVNdmtNTjJIOGJXeTlYWkdYNjliYTVRUTZ0?=
 =?utf-8?B?bkpDVVJkMkVFQmQvTXJCdy9CNW5tMVJ0WjZDQTIxT21kZnB3NUpIK0JQWXNi?=
 =?utf-8?B?SzFkcUVBUEc3b09laTdqQmFRR1RRTHdZVmhhMmtqZ3YzM2ptQ0Zqamd0UTlx?=
 =?utf-8?B?Uk81UWxHNFJ2MGpsd1ZndlJHTTIwMkRzMi83NzhXd21ZbUsydWJ1ekErSlUy?=
 =?utf-8?B?alhiN3MzN0hjc3hTMUdrY2dxMm9xRnhLVWR2ZkM5a1ZQc3hZc2xXdTIwVlQy?=
 =?utf-8?B?Q2lEQmgxcGZJcWRrMThRMW9IY2V0OTF4RW0yUHViRXB0OVJVTU1VdmUvZGlP?=
 =?utf-8?B?SDBlZnBPZXRUSmV3YmpUVHpkQlJXblhnL2Zrc3ZMM000S0FyUk9nWndyNlNO?=
 =?utf-8?B?ZDNJMXNmUmNNdDFQZTZET3J1THNsZWd3cENsSnZrZmJoM2paTktiTUFUZFQ1?=
 =?utf-8?B?Uy9JaUlBYjg2c2tjTTlJNUNFVmhPWTliQWhrdXlhNXlVUkQzY0l5TEZ1bHVn?=
 =?utf-8?B?cWkwakw0YnNUQWtuKzM4NERmRTRJOWJlQW9IekpERnJrRWxqTDBDNkxEVGNG?=
 =?utf-8?B?SEdwdXFZSXBnQjJ3K0JQR2ZKRzE4WDRvM0NxOWc3R29YMmhpN2p4dkZhVTM0?=
 =?utf-8?B?TGZ4WGtrOHNWcldEeEFsdElnRFBYcUp5VTFxazRFNWgrRnFQTE5FY3ArUkV2?=
 =?utf-8?B?cm9LL2piR0kwWjl3YkpQNEQ4SU1UeS8vazNvVnVCWjBNcEtUbXJBVUxUUDli?=
 =?utf-8?B?dHlld01Bd0k0SnI4eCtacjVOekhuOWZNN0pBYWRFc2R0SlRMZDY4bjJTbVJN?=
 =?utf-8?B?bWJYcWVQWDNGOHZWcU05WHFFaEYwUXh6YzA5cXI2U0dTcG42cUg5MlZjMUl4?=
 =?utf-8?B?SUl1WWVkaEw1akl1bGhaK3NuRWo0VWErK2RjSlgySXZZdkF3SXlQUlA5SlFi?=
 =?utf-8?Q?2S8Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHlnMHcrN01aUHRWZDQyREU1RG85Nk9BWVgwb2N3OUZ1bWVFQThKbnBQUUtn?=
 =?utf-8?B?OWN3UDVoeDJ1bGJCcHZ4VTFSOXlyN1oyS1FBbEhwWXNYZDI5a09RYll0bC9O?=
 =?utf-8?B?Zk1uUUhONmlkalI4eUFPY3ZoMlgxeHlvMjZ5dHA4Ry9pZXh5c0pYU1NVTDI2?=
 =?utf-8?B?QXpQSzZlY0NSaXVnSVJ2dnZsY2NOekNJS3RUdFB1ZStRSUVRMFh4d3g3UlJW?=
 =?utf-8?B?ak40bUpDcldkSVBqQzlJMmxjd0JZNStXdzJxbmpvLzY0S0dtYW9WSEtOM0Zl?=
 =?utf-8?B?THZYMjVCWXB6SnRVeGFuejc1UEpuRDVxOFhPTlFXblZTWmR0K0hFN2FnTHlZ?=
 =?utf-8?B?UUJpSmx0eGMra0FOeFpBcE8zNkd3Mm9tVTZSWVk4QkRSdTBEQVNOdWl3Ujhv?=
 =?utf-8?B?bTB5YzJsaE9xUTA5V0xTOUx2TVZoR05wSGVoMUlGZ1B2S085V0tXOHhaNk90?=
 =?utf-8?B?NEtoRnZEVmhhSmowMjc1c0luR2M0ek93bDZzNkxVakx2OG5uak9YQzBySTF5?=
 =?utf-8?B?NS9QSTRkSDFkNDZOZmJtYkhzbDJLWlY1blJobEQvM3hCbGtoOVVaUFpiTUtv?=
 =?utf-8?B?Sm56QjRRcGxJZGJtTmdBR2FxQTVUUGVaUDVlMGlySWMrY2tKOVpVU2V3ZnBa?=
 =?utf-8?B?ZEtnM1dzUWFuN1hKZGZhWGhySnhBTDZzUjZna3NTZ2p2SWlrVHptRmxWTkQr?=
 =?utf-8?B?Rlo0Y2NhSHRkRFpDL210c3drQkE4Lys3eDZQQ09WMXJ4NGFsM0tpZ0JEaWlW?=
 =?utf-8?B?SElQTUVrVkp6VkpQdTYxMzVIaFRVVytYVDVoY2tpUWx5S0dVZzV3ZEhtWXAz?=
 =?utf-8?B?VUpBeXlXZkYwSmV6SzZwKzdsV1NvNTVybGsyNjFIWTZlU1lQUmsvK2JRSzFQ?=
 =?utf-8?B?V1JCQzRKRGdpUlJ1amhjYlFmL0M1eVpTLy8wMGlZa2NuaTMreHFYa2VSS0wr?=
 =?utf-8?B?ZmhmNWh2U21PMTBFNnJqaWFFZlNlMW04Q0dnUW80V3VXcjJaZ2dWenJQOXVj?=
 =?utf-8?B?Q0hEdm50ZTdSeFpVYTkzQWd3R3hFM0d1YWhHc25wTzdldWpUU3ZaTzJBRzB4?=
 =?utf-8?B?SmtvSGFBVnhJWXc5eERYMnlRUG5CcXJBVXJHb2FJbDBKVlN6Z2dleUxDb25F?=
 =?utf-8?B?cXdnR1NFQUZHcWFIMjgvYXREbDg5bXlYNzM2TTJmMkMrNFdlUGNEckNNaFpO?=
 =?utf-8?B?M0NuMjZWL2F0VXMwbkc2WWNEeGFVcFE5enYzWGpiRWErQXBOdHpNeEtTcVdu?=
 =?utf-8?B?VEx2RkJjbFp6K1hjT3YyTFZVdXlZZnUxeVU0S0FScjNrK0tjTVBvUG5VNk1z?=
 =?utf-8?B?S2VDdW10bkJFOFdXekVwdktqTlZ2bGxST2pKUUZMRFVvMFpZRnBxQTNXb3pI?=
 =?utf-8?B?WVhRYkdxRnFBZ0llNFE4MHRuMFNnekRzL2tBVjJ4K1dDMGIzSVpES29wOXJD?=
 =?utf-8?B?QkNueEJmVEhCdks0QmNqcitoS0VhYXJEOFVBbFZ5TGh3bW9tOUZlUmxOUXRQ?=
 =?utf-8?B?WDhXejQvSVhiZnFvNGNhV1RML0JqaUt2djhaODVGeGRKaXVrZ0tMdlJWN1Vz?=
 =?utf-8?B?cnhLdmdXcFp0SVowWXErRTlsYzQ4cVlrbzFNK0dBRmc3MTJoZTl0Y0lWd21F?=
 =?utf-8?B?OG9kSmt6aG01U2RPcXhuZUIxQW83VXUxS0FHWk1pQm52MklVTG1vS0MxbGpQ?=
 =?utf-8?B?UFFiNUZIUWxhK1JPVXdNRTZMdHgzNVBXQ2RNZlJuTmNZOEVWbkhBVG92enBQ?=
 =?utf-8?B?czBsVDFXRXIycE40NFNGZFlWSHJQUXFvK2lNbkxCNGdWbWd6bThNNFRNYVZ4?=
 =?utf-8?B?L2ErdjdoMVlucS9DWXU1U3pFQ29QRnk3MnJmVGN5RDNVVUp2MU5TUkNZYUVS?=
 =?utf-8?B?cHlkTzMzSVVvQkI0VjJpWkdUaCtRcFdNM1krL1R6REU0L2I2a0NQaHpXbDhU?=
 =?utf-8?B?UFZQQlM1QlJXakdVTmdtRytxT2hFRE1zaUloaStDQnhhMVh3RjArNEJSTEpH?=
 =?utf-8?B?ZTNMcVorTUNVUDNvUTJJYkl1cUw3VFFsMGlHY045S2orckdkU0lQZW00bm9n?=
 =?utf-8?B?TEhGTDd3ZjAwQmtUWmxxOGhZWk9PcFRNNEhzNGxKSWwxc2tGRlRHdzJiNTZm?=
 =?utf-8?B?dy9idVk3cjJEVERlNnNKWFg1VHl1bzNKUmRXUllRWjB0TTBzM0xqK0psckhZ?=
 =?utf-8?B?Nmh1bGllN2w3Ry9ITHhubXd1Wk4yeVlNekFSWTh0c29BTUtnQU5FZ0Q2aXBV?=
 =?utf-8?B?eEdYNnRBbEZydjQvbXZKNU1pRHY0dFhCelNBUHpKRmY4aHFuVzJLMFM2RVR6?=
 =?utf-8?B?cGV5Z0RvOGdGUXNYTTFHbWpjcVJ2aVBaeGdMOHhDd1J0SDMyTE1zVW9KRlR4?=
 =?utf-8?Q?tgtavLY4RKO9akWY=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5d3c20-6311-4c06-aae1-08de58386056
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:27:09.2068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ2D2n3GDD6fKGxliAAy4VY3VUf2KrA1iEL9ibVI0Uay3x9qiiZzGg2CTKAJt+3wuUtfLGqTlCAt6pkn7eTLd+2pqgFsWEYspQeBzj0Pqns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPFBC9E76CBE
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Some registers should be marked as read-only from a plugin API
perspective, as writing to them via qemu_plugin_write_register has no
effect. This includes the program counter, and we expose this fact to
the plugins with this patch.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/qemu/qemu-plugin.h |  2 ++
 plugins/api.c              | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index f976b62030..1f25fb2b40 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -942,11 +942,13 @@ struct qemu_plugin_register;
  *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
+ * @is_readonly: true if the register cannot be written via qemu_plugin_write_register
  */
 typedef struct {
     struct qemu_plugin_register *handle;
     const char *name;
     const char *feature;
+    bool is_readonly;
 } qemu_plugin_reg_descriptor;
 
 /**
diff --git a/plugins/api.c b/plugins/api.c
index fc19bdb40b..de8c32db50 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
  * ancillary data the plugin might find useful.
  */
 
+static const char pc_str[] = "pc"; // generic name for program counter
+static const char eip_str[] = "eip"; // x86 specific name for program counter
+static const char rip_str[] = "rip"; // x86_64 specific name for program counter
+static const char pswa_str[] = "pswa"; // s390x specific name for program counter
+static const char iaoq_str[] = "iaoq"; // HP/PA specific name for program counter
+static const char rpc_str[] = "rpc"; // microblaze specific name for program counter
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             continue;
         }
 
+        gint plugin_ro_bit = 0;
         /* Create a record for the plugin */
         desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
+        if (!strcmp(desc.name, pc_str)
+            || !strcmp(desc.name, eip_str)
+            || !strcmp(desc.name, rip_str)
+            || !strcmp(desc.name, pswa_str)
+            || !strcmp(desc.name, iaoq_str)
+            || !strcmp(desc.name, rpc_str)
+           ) {
+            plugin_ro_bit = 1;
+        }
+        desc.is_readonly = plugin_ro_bit == 1 ? true : false;
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
-- 
2.52.0


