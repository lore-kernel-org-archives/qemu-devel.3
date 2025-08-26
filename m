Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DCACA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqusZ-0001K5-Nq; Tue, 26 Aug 2025 10:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1uqusX-0001JP-2t
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:42:29 -0400
Received: from
 mail-switzerlandnorthazon11021082.outbound.protection.outlook.com
 ([40.107.167.82] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1uqusL-0006RO-Eh
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:42:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJulvXmKUQAD8xpNnHgVl388Y/ORh0nepVreck4ejNgGT8JDKgbc5jHyBAs0TeOHGpITgpHI5z/W8Kntom7BAT4BwT0N5ojAOteO5ZeBHh2XEnSAaDz+5bLQVWOEaPJMJByhDK+CclKSfh498EmgcBij/0iBQy0hHEIIMt/3uTuSoLnMt0nwbbHJxjPBYc+xcRgN+Cbbn61xBQhMKNP2jYgqWa0hogA7aKcr8nywbI+hrzTUqXj8oueLUBpTkujMe71EHqMdFLjNvsbFP3+/04qCs3HJdNhdTKkkCmxIJOAlIDkxY8netoWOeGyBh82nWtdLeF1KqbJDgv8VE+46UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkfYrPDUz4lmXnZGq8rBJQyiP3Tve9Mddx83rNl01OA=;
 b=v9R3T63ImE9Oc4bKSEs8R0tzvkLKwEEa5tNx+16G9pgN0MACWSgkb9IKpm8sT7kfCNkF3R9Ftj5/+MvNT8uoUEHL7rUtR/gIPLoBOcPWQCgtagcvZ2OBYgpmZ1BKTisM5LaB6ohcTRfRwdWrgRu0KFEkcxUF0cEVqC3HAk5N0Fc+MhXm9Xk+wFR61rGa4FuVbdDTGIiMLsdoxqUIh12Ms4/da14JSEZDiDkEsRZsdGcZBBFYxdKYSKULk1CW4s/5rgT5vtsfc+c5ohZ6Iyewi6ciSg9EdqdSpbjc5jBY3T2F5S0mW6cd2B3plmcfguOU3oEUn7NnQIqyXR18CX8VgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkfYrPDUz4lmXnZGq8rBJQyiP3Tve9Mddx83rNl01OA=;
 b=Fu8pWRBJMYdIsxTEA0cINveXvjysIkPIqj2L48iJlrFIUrzU3T3DrNMfSS2axbKWIAhE/RDgfj8QOapftPbiR9uOUVsZUB0C9GeLHHDMBoCZdMGVrqoztFjKaa99dHrp1iKMsyPSIvDiat2VUZgI5m2MrND6yLT6W91THUj6vzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZRAP278MB0128.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 14:37:02 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::781a:c3f2:3706:82d%4]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 14:37:02 +0000
Message-ID: <14d8ce11-a15b-448a-ac6e-2b50c66a46b3@epfl.ch>
Date: Tue, 26 Aug 2025 16:37:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: New capabilities for plugins
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: pierrick.bouvier@linaro.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
 <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch>
 <874iul26rp.fsf@draig.linaro.org>
 <73d56742-5e6e-4e1f-8d8c-2b9783d0ddea@epfl.ch>
 <87y0rxzsz4.fsf@draig.linaro.org>
 <7e0bd15e-d022-4de1-814b-9d9bb6513934@epfl.ch>
 <87v7mfkaoi.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <87v7mfkaoi.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::17) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZRAP278MB0128:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a14027-09ea-480c-580d-08dde4ae0527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVZKOWgvUTV5MGpGVjlkeSt0WEhQUmV0Qi9rblc0anQ4YUtONk81b3J4eDhQ?=
 =?utf-8?B?bEhudy9tUUpWVmlBTFVDL0llWENRODhpclpSRzVzek9HNWxSeWJXS1lFNUpz?=
 =?utf-8?B?M0M3YWptTW8yVmJCTkRSQjdic2ZuQVdHd2ozTHk2aldXS3R2T1IvZ1JHMUQr?=
 =?utf-8?B?ekpNSjRRZXRQSEJqdmhOU1c4WTlFNHVCRitTQjk0clhCcjE4dlgyVVdzNFdl?=
 =?utf-8?B?WDBsMzhqVGtnSTFDNXBxaURQU3F0Wmlacm9Lb0hzK2lacGRpVU94aGtNakFq?=
 =?utf-8?B?Y3VRVzUvcmtMSFlqcVpQa0VIVEs2dUdyWmpsMnF3VTgyVDV3NnpZNlhUVHJI?=
 =?utf-8?B?U2pFYlBmSDdXaCtpbHVTUHg4bVF4U3JEeTBTRTA2MXhaRVVkUEdHTitwaGxy?=
 =?utf-8?B?ZzBVL0c3ajd2Q2lDb2VhN3hIdGRZbHhuamIzMUVESkZjQkZDNTBSd2tMSGxL?=
 =?utf-8?B?SkdrRWgwUTNLa2V2dEwxdTZ6STRQcVF2U1NwcGNjTGd3cHo0bzV5UTN5U04z?=
 =?utf-8?B?a2FvaGU2THNnQ0dRb3hRbWRZUjQ3aHpSU3JZN3dRZUVsS3RGVXY2aDVWY2Fj?=
 =?utf-8?B?WTdpN3FSSnd6eS96UFBFVUwxUWthM1lpQmtobkxaM0RobGZIcnNtcVU1TWpm?=
 =?utf-8?B?MVVZM1NiRTRvdzJRTjc5U3VkOVp3Mk9kc3F6MjcrV3RpSW9JVDdncVJFZmdW?=
 =?utf-8?B?RUFBWGhBamRJalpUd2JDUXRyaURWMkVUTEFPVm15dzQ1TnJGUVR1ZXlHQ01I?=
 =?utf-8?B?dDIzTWdDc2phY0ZsMjdXbDVCbFBnSDNoOUJGc1U5Mk4wdTB2Rkd1TzlvMWVS?=
 =?utf-8?B?MlJpbE93Q0ZxRDJYZzdwU2Z2U0ZiTDlmUTlSckdhZEFkTnlBbGwvc1lSa2sr?=
 =?utf-8?B?SXZUNTlLSmRxREtUVUZ1VG5VazVoZzVwYmJ2dEg5TUFMRFFtQ1FHSkoxU0Zo?=
 =?utf-8?B?NUtmUmxQdzNYTVc2cDVGT3ZYR2FYOTcwUEFBSFpnUHNLSkVIRGtnaEx5Tjcw?=
 =?utf-8?B?K1JrM09hWlZZN010R2Jjdmg2U2xPNGRWREFhbWhJTGQyMFh5NmVWYk5uZWpX?=
 =?utf-8?B?TUhZdGRHYy9xVUxYckptdzNJOCtvNzJJNnNyTmJ6eTczcndQNXNKV0FGVmJL?=
 =?utf-8?B?aVQxMzJ4MUNFbTNHSmw0NHZIbzlYNXQvSlFCcUVUTkhPTEdWdUczdmYyQ3hV?=
 =?utf-8?B?eWlReFlDdEZGSVJxVVVQQkdITUFFeXUwb1BTWFUrTTRveTBnb2lxZUhUWWs2?=
 =?utf-8?B?bnFNa3ZBN3ppeC81RHZseVovZ0MrZXFBU1hQM2VpbHhDQng2eCtOTWdES2VG?=
 =?utf-8?B?OUM4S2JwOVR4azEvWGJXcUljVER2OTRrYm85eVlJKzV0V0FjanZtMzY3ZVBS?=
 =?utf-8?B?REROT3o0K1V3bG55RTBzWnhDWVZpQXVIVi9Cam4yajU3Tm15OU12WmtuK2R1?=
 =?utf-8?B?OUFnSzUyOVFTak9uOFJaZ1BSTStwRFYyZFM4YTQzNDlKS29KS2tYYXJFcEE2?=
 =?utf-8?B?RlNpODg5U3lrUDJpdEFMR2xndWljV0Z0TVFzZE0zdERKRlJkeWwzUmZmRkxk?=
 =?utf-8?B?cmZFOWxMbzkzZDBjdTNCM3UxSGwrSUtPaXN5R3JiWmtDS1duMWZ1YVdVT3JC?=
 =?utf-8?B?cWNkb2dvZmNjMWVuZE4yVUVzaytORi81UWdNMTYvTHQzOExPUDRwTUdBK3pU?=
 =?utf-8?B?R2U4WE1taUtsUEZ0V2JLNEtmcXh1QUh2VlpQdEQ3NEJEYVVvenNVSEdCeldz?=
 =?utf-8?B?R21QWi8xUjZKWEhZK3Y5ZTdHOTNRSmRuMERhWkFTZnEvSmR4Y1F4MzlIcG5l?=
 =?utf-8?B?M01hZXNETDhzcnJYSVo2K09zR25nWFBpVWN3Q0xpSjZjUXBPMkhiK1RWSmpY?=
 =?utf-8?B?YVBLc3E2d0s2TmtxSlhsNGsybmRJNkQ1ZTh2RzR1bTlSNC9ORFNCSnhVSjNT?=
 =?utf-8?Q?hkqofxxXy4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnY5L0FrYUJ2NjdYSUx5aGp1NzhhalpJeDBFQ3R0aDZvbDJKVW0zWWFHdUVx?=
 =?utf-8?B?ZzRPei9LOTIvaHpGUzFiSEdRQ2V5Z1NyaDJRZmhQeFFEa0tybGVXOXg1VWY0?=
 =?utf-8?B?S0JTbXlrRHFLYzdUVjFXRi9uTGJOK2RmMnJYYW5RK0svWkVnWjdzczgzczVG?=
 =?utf-8?B?MHFjYjR0YnB0ajg2WkZDVGdyRUJnMXlHUndWblI3U1dpWk1lZXdSMWYwS1BN?=
 =?utf-8?B?ZkdzZDlSSkVuZFh0enNRRmlRTjkra1dBU3ROQzRMOWhPT1N3K21tcHRpOE14?=
 =?utf-8?B?MDAvbVg3aExmQkQ5dDlmdFZIbTVyQTRHZ2ZMc24wZU5iWjdtaW5JdExVT1N4?=
 =?utf-8?B?ZU4rREVUUzdBYWpvdG5XcDU5U1Y5dUJJOHVhcVMyS2NMZ2p3NjBBQXV1RnRP?=
 =?utf-8?B?dklDRVRiL3RJVXNFYlB4NVFzcktuR2xjaGZET1I2aFY0Z1hDUWNZU1JRd054?=
 =?utf-8?B?dTBlT2FtZDZWeUlFQnhscUFuUmZ4WU11V2lrbVFLYnp4SFo0UlMwc3BhQzFG?=
 =?utf-8?B?aEZWbzR0QzFYc085M25GNnJwbVdJL0JORzVzWmV0dzhKZFRSa0dMUzhnMEhn?=
 =?utf-8?B?SkNWT3ZOUGdydHRSK0t4YytsLy9YbGxmTVJUUE8xUnVxWUMwV2ZhRG1yNDg5?=
 =?utf-8?B?aGdjWnYrQXFtbWhzQ2gyQ2UreDNWY1ozdnI2SFd3QWM0aXVvL2oyVEwrN1dE?=
 =?utf-8?B?OG80MExHUUpkSWVNOWlzRHB0U0JRcnV2ZDcrQXFWUDMvUTIyQ0VlNDFmbG1v?=
 =?utf-8?B?TXdJelQ4d2RUeFY4WHIyODhXeTIxeS94NFhaNHZsNWI0U2RqekZXTWFyQjY2?=
 =?utf-8?B?REVIVFRqaDJnd1BGMXIwNzJQL1ppbTg0dEE5dGFLVTdpcm0zNjI1RmR6dFJ2?=
 =?utf-8?B?dHNWemRZdUJ4ZDZ0aFhhSDJpcHh6N1dWc1FTQ3REY2VZWW90NWVRczAwUGdL?=
 =?utf-8?B?NU9MeTV1ejk5QXNBN1ArVTNMVUJ3ejJBVFdIVTJyclQ2NzR1OE4rL2M2Z0dk?=
 =?utf-8?B?a2hsL2ZNQUhZT0IvZkhTQ3NLcUxxaUs5MzlSZ3pZQ2JQOFRwRWdvNE9tRkVt?=
 =?utf-8?B?ek0wazlxaFhGVHpZMlhKWHo2QVhZaDRQd1hmV21KbXhDZ0l0a3ltaEQ3NFBO?=
 =?utf-8?B?TERkQ1RzWHBTeHViSks4N3ptTU80czVVNmlhU2FKaXhiUkhCdEp5ZURNWnNz?=
 =?utf-8?B?c3RhcHUyV29haUoyc3dMZzF2dG9wM3JkMjMzRXpadHNIZUJweUNhanAvSzR3?=
 =?utf-8?B?YW8xd3pDUHNIQ3FhUXE5anlxSFNUc2NJL2F1bS84YkNLemJYdkNHcVpHVUNw?=
 =?utf-8?B?YjFXaldiQjNLdHdoUzdYUUlPajdrenV2WHNJckNpVlM5dTNPNzFseUdzazVG?=
 =?utf-8?B?VlpCR0VZVmlwdzRtU1NRaXhRVU9sNWU5dm5XN3FmbHRUVWpwSDU4bWNwWDB5?=
 =?utf-8?B?WlVaMUtXOExnTzlCZ1BuY0dNY3VtVGtpZ0diMHRvblFJTnBWMHd2WURVa3A5?=
 =?utf-8?B?YWJMaFplZ2N6b2hCU1JhZGxZc21WSDZwV1dNbkVZR1JZRjN3Q1k0dG4vL1NW?=
 =?utf-8?B?U3lZU0w0YmdqSFdLWVZvSHA5SUdsLzdIeUtjeHFwRnpWT3c0VER2TzVoSFRQ?=
 =?utf-8?B?c2VpRVdYZ3NrczJneGhRZFN0QUJuck9lMHV4SS9NR1N0c2cwckN3dDJ3ckdT?=
 =?utf-8?B?U3RtdjdNMzBDR28vZUtIcVlndGtzMCtCcEcrbHJmRjh2UEo5T05NbG1xTC9m?=
 =?utf-8?B?ZHdmRlBSbUcya1JVcHNnVitWbnJuc1hUcTVUZkE2MTl0ai85NGVpMkdSS2xs?=
 =?utf-8?B?N0Z5eHhMaHIvRVdrSVpWc1FJVEtCWXhXWjV4N1FaQ0lEdGJTdFBucEhqSi9n?=
 =?utf-8?B?cHFGV25oSHdwS2haeTVqdS9EaWVWeDJxRzJCeHNuK3drSDNobUtuNnFUQXg2?=
 =?utf-8?B?cmRIMklQOUR4SmxoNEF3T3UvOUVwYkpRcWdTV09lR1l1N3pHTHJiTmdvYWtm?=
 =?utf-8?B?c1dhVVMzNGJDNmptbVloeWUwWFdQb2FKc2loZmFqUUpUSzRnSWZWM3dhd0VN?=
 =?utf-8?B?cmgxMlc3WStUUFkrd0dRL0tVVUdJWkNYaU9DT2w0aVB5WUJBWHlEWGF0SUk1?=
 =?utf-8?B?UTF6Ulc2NkZoODVMRktOdUg4cTEvbjNQZ2dKcXdsbVAyV09saEFLbUxGUFJ4?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a14027-09ea-480c-580d-08dde4ae0527
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:37:02.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsaO7V25M21/+d31uatE7kayjVblXWEwznlSWjz9mgGyRF/PCLwNUOLXKtaP7SjVKEvf0TOWVzkebdDVF+xmu1HZuqaK4ez/QrN2oCzkmfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0128
Received-SPF: pass client-ip=40.107.167.82;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hi Alex,

> I think writing the patches would be a useful exercise anyway. The way
> the plugin code is structured should mean you can keep the changes
> fairly localised which would reduce the burden of maintaining an
> out-of-tree patch if it isn't accepted. This wasn't really possible
> pre-plugins as instrumentation was often deep in the frontends which is
> actively maintained code with constant changes making re-basing a
> nightmare.

I'll try to work on this and ask for feedback once I have some decent
patches ready. Thanks for the explanations and support so far!

Best regards,
Florian

