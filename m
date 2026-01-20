Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D000CC9830C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDdk-0001QG-E9; Tue, 20 Jan 2026 10:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdc-0001Oy-H0
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:24 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1viDdY-0006ub-Tb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:27:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnAEZ7klIfCDi+8yK9vq6QZN8IESkfMIGg+yKX0BTg9aVsgUtNav3oJT9frU0C3C3+hE1q1FTG08Kvlrx2mPQzqVHjTvNIEl7VE/FhSpnmGY0pfparAR0jrmPAIK8KRHjfXFu9P+E1HRJXD9d5dWDNDYYGSIuGNKhP+35bEzrFHQG8zqg1m8wn/Xssu3nAocwv6zDXpzPkSJkSRxINC1kPxUMNyrh44PvRT7csWJCsUeoNd9ZHp1BY/+dNv4U9fnQa6hM2y9IiBpT0nOx7cHwesE0CeQs/3uB5x6zj2G+rZGj9XSJRCWiGeCbfalZEf56NxuQ4/V8ivKf/TwyvLgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4ozX9lomEwJkrcrctKRBybQa/Z1DQ3HqgPmTisaxps=;
 b=xcpHC0cZPaFfd2EzEJI0fm0S4QcyXRpb7BjIfWoimNKwhOQi7TUDJ3rH8RHwn8/Y2nF0Ojsy3/pGUAlBueFMcEbviTGHTrN8DwQek3njhbhc2Azi+8oNMRAcVEnDfrMfFetM+GnCaDg69aZ+TfAOOFzAjlVj1RoNh1e5TTcytGgDvEqHiXrjQQ54pdbKIXCvYi3nUu7xn5npzu0zTxuNM7JtRMC8UFL71UNDDP5dQFFoicZF/PSFsdu55tfkzYn6kuc1m4RbjOt9r6zQV2ltyl5sfcCpxTE0OyGWI7h7bxrqqkNVrPWHap48CNe0TWXVv5KmIO+kRIBPbB6gCXs7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4ozX9lomEwJkrcrctKRBybQa/Z1DQ3HqgPmTisaxps=;
 b=OyBaTuRer9XLHvQYySyDujNRhO3EbX5zpnBYrSArYGq8OdcHw3jOy7c3Iq8QiRhFx1X2v/gNUlK250WaLLjA4pcJockqIYz+Jg69ikAK1cja2/qJ6AsWn2brhbfGfYKEWHe7DIA3thCH4AseRelH6QXyAtJJ/uoDXvcwFemvKJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1PPFBC9E76CBE.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:27:12 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:27:12 +0000
Message-ID: <5bcbd1dd-b9b4-4822-8b35-6edd21b72383@epfl.ch>
Date: Tue, 20 Jan 2026 16:24:45 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 4/5] tests/tcg: add test for qemu_plugin_set_pc API
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
X-MS-Office365-Filtering-Correlation-Id: 652d9ac1-c067-4519-1964-08de58386188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|786006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2YxUTV5NWNvUHNicGNuOXZDWTFYdjA3TGZHMnlmM21nWktIVXBXYVIzSk9X?=
 =?utf-8?B?UHNkSTRQZlBLUUpOR0NrRVVFUkpvK1lCSXBSeHNRVCtJeEFFNVlSS0FEL0ht?=
 =?utf-8?B?c0pUUStOQzAzWkRudEh2RGdUaC9CY2l2OGNoSjNyZFI0d2ZjSWY4V3dyOEhT?=
 =?utf-8?B?eTcwcGw3WDRUbzlsNHA0Z1puNlppRFhIVTlCN05SUXF6VjFmV0hUaFZzTkVz?=
 =?utf-8?B?Rmp0eTg4c1A4citsMVBxZlBhL0NubndmRFVKT1FmN0doTndkMzRBTVoxb09k?=
 =?utf-8?B?ZWNYNThSRTVtcmZpcVVLek5URnZHYkQrbHFqYUltZmM1T0JEM2FQeUdTQllU?=
 =?utf-8?B?ZUYrNTRRaUJsUDJGL2VOUWovL0RxSzE2eW0vSW1NRkc4V1RuM2w2a0tBR3ZG?=
 =?utf-8?B?bHNMajZwa3BQR1VLTE8vM2RRZXJ1TWNEMGEwTVg5TUdiRGo4UlZ4L0Eweklu?=
 =?utf-8?B?L2lwamNsdFJDcDh1ZGdlT2pwVjJwbHIyM0xGRExWUGhQaHg1RWpUUTI1NkNj?=
 =?utf-8?B?V0JNSkJWdlNJamxNTEdkUlhqR1N3N253SmxZYXVVSjlCQW5IS1oyb3ZRUFUr?=
 =?utf-8?B?UnRPdUVSNHhkcW9HZ0NMUWM5eUVSaklQQTJhTkVxbXlKM0FUcDU5NmFVeE5Z?=
 =?utf-8?B?M1BFQi9oMW5hd0dQS2lKekttazQwY2FNRkU2TG9zYlFkdUdQdGozSkEwa2V2?=
 =?utf-8?B?eXpMRm9mbGoya2xCclpzdWNJT1VaS0VhZ3FYenUzOG9PbUFZYXJyWWNET3lR?=
 =?utf-8?B?NzRHa00ycFRUT3ovQXQwT2x4WEk4V1JkQW9YNWdodGZ6aXo1QjJJd1E4WlBE?=
 =?utf-8?B?MGd5dUFvUWc5R0xTUFRRSkFzZGt4QWxCSStiSXhZUkp6MURmMDFPODE4OGNF?=
 =?utf-8?B?UDJkT3RuZXRzU2N3UVNGYUowaFV3cUlzbnV3ZHd2M2xGQk1iVkZCemlRbkhx?=
 =?utf-8?B?SEM0L2N1RnR4cElmV2h5VG1EcDNZU2ZCWFozNmcrSGR3NHlWaThCWlhlMVBI?=
 =?utf-8?B?a0N1TklqcjZwSm4zRmpYakgwMWdQU2lNY21pL2NNQ0VyN05RQ1ZoV1VnTUxJ?=
 =?utf-8?B?aDJmNnJMR1Ird2hLZDhRTHZhVmFWOGFYZnQvdDVJcUtXU0xKS3FmRU1MOU5j?=
 =?utf-8?B?OWJQSHo3UlM5M2I4cDc1WFdFdWlPRVhISzJIb0tQMGhHRTd0TnArUHZNUXV2?=
 =?utf-8?B?RUZ5bUxtSndGbFo2N1FuT2lKSk05U2NYbi9lMDR0eHdWMUtmVzFRTExtTVpV?=
 =?utf-8?B?RGcwb3BOVk44RFMwdFMwbXltckp4MEFvQ2ROSkhIOTlWeDZOcXcwOEJWRFM0?=
 =?utf-8?B?Y05BdXYvUU0rUjZyaVVFa1NRdHRhVHFGaEkzZytPVHZzU2UvQnB2L2kyZ1VZ?=
 =?utf-8?B?M1NGRmFGc3o3cEZ5OG96YzBCc1FRVG9IeEVtc3JES2k3Sm9KUkYzTXBRYzdm?=
 =?utf-8?B?TDNxMUtnWkpXUy9WMVFSdXZxRU5qRlliMVdxdDFGblp6SWRoMkYwUDhyZlpH?=
 =?utf-8?B?Uktpd2dzd1AzVXVmeWRUSGRKSUpOdzJTdjJTUmpoczI3ZHQ2dFpYOGVKV01m?=
 =?utf-8?B?TTExYTNuS3VPR2EwRmtQK3JlNHZBUXJsa0k3UGhsQUhyUDNGTVc4ckh3QjRZ?=
 =?utf-8?B?MmJYdDhPejlNTVJXMEY1cHFFMERsMFN4azVQR2dRM040ZENBbjFkd0RKWEts?=
 =?utf-8?B?Mi92VlZjN29RSElnSlpBK1hGSWZYTTVCZm1oU0M2TkR0eHBNSEZjbXBaL3Z5?=
 =?utf-8?B?U1BBRVJrNzc2dFNEbitqNUFZSTdHd1kvTTBGRjhwelZONExFR0RUbWlvV2Fs?=
 =?utf-8?B?TEgzZ3JrcndnaWJ6bnBGMkk3djZxOU5hZGdBMmRFaFNCcGNFRzVlMWdQUmlO?=
 =?utf-8?B?cGNqaVNMNkVBUzJiLyttVEJ3U3JTWWppVldrek92QTAvVnNsNVZJZk1pTm04?=
 =?utf-8?B?RmV4VkNQOG5vTUd0aXlFMTArdStValRoSGxJSkJuTjhMT1NtK2pxTkIwUW42?=
 =?utf-8?B?MnFybHBqTU5hcHZ1RzNMTG84NmpnakhCT09sU2pFalNkNks4a3M0VE9wM0xJ?=
 =?utf-8?B?N1ZlZ2ZMUjdIM04wR3lkMDdQV3hXaVRaeXJBcUJLU0FuMDVBL0R2QndXREF5?=
 =?utf-8?Q?4P10=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkJCL2pRdDhxRFBaSDhjSm1iWUpsM2RZZnh5VTBReW13WGtzbnptcytGcUVF?=
 =?utf-8?B?TzNCRi9kLzRETTJ2MitKSzJMVG5ZNExKZG1BcXhRM3dmODdUdDdIQjVqbWJk?=
 =?utf-8?B?N3hQdkRHQ2ZoVXVpMkdLcXhudFRpemkzWFpheGZBSk16emxCVlhnQ1NmZ0tT?=
 =?utf-8?B?YXNYYk9PNEhTbEVlNTJkUnFaYXY4WXRwb2YvRHYwdUdBeUoxUzkyMEkraUM2?=
 =?utf-8?B?RXByZ01yUWlKU1F3MmxUTjZQUVhNMWVJMGE5NFVIK0NUZlhJOVNSMFRSejcw?=
 =?utf-8?B?cHZ6Z09aSDhGdGJuS01MM0FxQkFwRXNpWWUyeVlDekhDYjNzK1RoMUQvbGFC?=
 =?utf-8?B?dVAvdm5LTzFqRGNoMjFIUVhaUmtJTUpyMWF3ZkpBbWtnS1BFZ3FQQnRsMW00?=
 =?utf-8?B?WXpyYU1oTWlTZEdVL3AwUk9RVG5yc0NwTExtM1d2bGxnOWFKbjQ1aXNCb2lT?=
 =?utf-8?B?UndUaTBQYXlKM3ZHNmErVUwrRU82RDlRZTE5VzFueVZITkxVRG9mamtGQmFQ?=
 =?utf-8?B?RHBBenZhdUxrRWVkWlVuY0Zsb0FCMDNlOEZBZ2FOTGZBczg4Q3VTOXM4ZWR6?=
 =?utf-8?B?Z0hyU2xmTmQ0ajdJTUZBdjJ6NDU2ajZOMGgyQ2dDRlc4bkNaTklQZUR6NjlQ?=
 =?utf-8?B?Z2xsWUQrM2E0dkx2NWFIZlNZcDRqNW0vVDRMVFNuQmE5OUlaeS9UVWkzYjJ0?=
 =?utf-8?B?RlZyZDlacnB1QU9vdG13RGlhOUMrZ3J3RnBwd0FRUHNuV2xpS0Z5YWRBMFFp?=
 =?utf-8?B?M2hWMkxmK0VwZ1FROEROaXc3SEZGUHFZTVl3d1VpRDJockZ0NjZzN0RYb0Ja?=
 =?utf-8?B?TUFMSTUwLy9KbVlEaWFkK1cwdHRrSkZNTTJHRExubkZuVmFCcUloN1ZNeWoy?=
 =?utf-8?B?TmhxU2RIMGpFRWZMSDA5S2NpQWlvS1dTNkRVd2VqVkIvejBYR3RXcUdDTE80?=
 =?utf-8?B?cDArOWM5Q3Y2VjJXNm1XY1ZIRVpEeHNQNjZGcUNkRE5KY0RxdyttRC8rdDg2?=
 =?utf-8?B?bWxSRXVaWGhFTWFFRkRIZTNONC8vNXFkSDZPc256OVlMeUFFZjdKeGRKTEdO?=
 =?utf-8?B?N0lodXBtNCtpTkRvRk9oVG9lVzl2TFNubTVDZVIxV0ZRNFNiYS91OE1VbHE3?=
 =?utf-8?B?S1J2NXpENFdJN29xTC9UWUtnZmt3Tml2MXNIZnVGYUJNZFRueGJwVEVPbHha?=
 =?utf-8?B?amlHeCtRTllDdENDbW1GT2FPNkpoZlhxMHpWSk5kY2dHYjFreTFIN3dmeXlJ?=
 =?utf-8?B?UEwrajRFVlovRmlkUlJFNEoyY0xDOU9CbCtXR3BNZW5GQzNDWGQ2ZUNJTk1L?=
 =?utf-8?B?MTNwSG82Z3NUZXNDWUhkcVlhVlpZSTJwS0dHSUJpUWRVWGRTQ0o1ZUNiS2lt?=
 =?utf-8?B?NlR6cThWNlJ5d2kzY0RwdEZYQnpCemsvalBCbnIwSExRZExqK0dJTUxjMjEx?=
 =?utf-8?B?Z2hOdG02aHd6cFVhUzJMSXVkR2xObXBSNVZQM1RlRDIyclpqbGFyRlVvRU9V?=
 =?utf-8?B?QWpkNDBHKzdSSHdqQUVONGlEZXVSZTA5WGxZOUc5NFpLYjJMMXIxQ1o0UlJi?=
 =?utf-8?B?MlppdjJSY1BRT2haWVR3UTUrUmFpTEptL3VZKzRPM1VQdnN4dURPdlMwNVNh?=
 =?utf-8?B?bDR2bXhZUFFOMGEwd3pjOWRWVVlnOWNvaTZIQXJEK2FZRjZDLzhsYktSZXFC?=
 =?utf-8?B?MlFqVmQ0OFhWYnNwTUxUTUhlc2dkRndZOFRTZnRFYXZ5Vm5pR3kwRzFlQVc2?=
 =?utf-8?B?b3FpaDdlZXRHS1U4azhxamRjMy9abkp3VVNKd0dLUXhvYTRZRGNHR0xtdzhK?=
 =?utf-8?B?WGtSdGQ4MDQyc0dJdVFUdW5JZit1TEQzcVRUaW1KMy9VNkEzS3ZwNjFoV0lj?=
 =?utf-8?B?QjFHbm5NWVdtQWdKQjZhQjUrTjltaUJIb0xYTDFFYVBaLzBGTGVFQW1IV0ho?=
 =?utf-8?B?SmRWUHdSbks1S3BIMlA5aEszNklLWm9WUjRXZHNOWVppazZvK3k3aWRzRGcw?=
 =?utf-8?B?RzdoTUR0VTdmVVVPS2lybHpjZXlNYzVuUm9ZLzNjUlBuUWRoL1ZkbWFHM3pS?=
 =?utf-8?B?ZXpPZmFVeHQ5SWJzbjM3OEFpSkc1TkxrWERWV2gydDdsczBtTTVicGpkZHJH?=
 =?utf-8?B?L0hHamlNNTgwaVlzYXdXeE5uSWw5aTBTVjJzVTU2TS9nSXB6aGVhOUFqRmo1?=
 =?utf-8?B?VmZRNVYvMVhWVWc4UEVVM2l0U3Juc2NRWDhLVXpNLzJPMWJMenlNalNQblBN?=
 =?utf-8?B?bW5NOVVXVmhoNWRGa2xoVEdUTUI5VktwNG4vT21RY2M1OTNTa1FmalF6YUJ1?=
 =?utf-8?B?ekNabHVaNldaNVZsb2JOYTZnYW1TMUNqandDOXhrTVA0Ry84Q014TFJ3dnhN?=
 =?utf-8?Q?EwRUqaOzWouj4nBg=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 652d9ac1-c067-4519-1964-08de58386188
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:27:11.1868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG0tr6lJ6gC3bsujMWCLMv9XK/NVv4PnHnMGllfHDPNBPLLBG5VTKTJgWF7sMnN1SGuRkHq0axGm22a8zwkwohfdbYUnKbs14yiIi6f1Q6c=
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

The test executes a non-existent syscall, which the syscall plugin
intercepts and redirects to a clean exit.
Due to architecture-specific quirks, the architecture-specific Makefiles
require setting specific compiler and linker flags in some cases.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/arm/Makefile.target                 |  6 +++++
 tests/tcg/hexagon/Makefile.target             |  7 +++++
 tests/tcg/mips/Makefile.target                |  6 ++++-
 tests/tcg/mips64/Makefile.target              | 15 +++++++++++
 tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
 tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
 tests/tcg/multiarch/Makefile.target           | 20 +++++++++++++-
 .../{ => plugin}/check-plugin-output.sh       |  0
 .../{ => plugin}/test-plugin-mem-access.c     |  0
 .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   |  6 +++++
 tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
 12 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mipsel/Makefile.target
 rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
 rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
 create mode 100644 tests/tcg/sparc64/Makefile.target

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 6189d7a0e2..0d8be9cd80 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -78,4 +78,10 @@ sha512-vector: sha512.c
 
 ARM_TESTS += sha512-vector
 
+ifeq ($(CONFIG_PLUGIN),y)
+# Require emitting arm32 instructions, otherwise the vCPU might accidentally
+# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
+test-plugin-skip-syscalls: CFLAGS+=-marm
+endif
+
 TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index e5182c01d8..428b0112e0 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -130,3 +130,10 @@ v73_scalar: CFLAGS += -Wno-unused-function
 
 hvx_histogram: hvx_histogram.c hvx_histogram_row.S
 	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# hexagon uses clang/lld which does not support -Ttext-segment but GNU ld does
+# not generally support --image-base. Therefore, the multiarch Makefile uses
+# the GNU ld flag and we special-case here for hexagon.
+override LDFLAG_TEXT_BASE = -Wl,--image-base=0x40000
+endif
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 5d17c1706e..d08138f17b 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -9,11 +9,15 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
 VPATH 		+= $(MIPS_SRC)
 
 # hello-mips is 32 bit only
-ifeq ($(findstring 64,$(TARGET_NAME)),)
 MIPS_TESTS=hello-mips
 
 TESTS += $(MIPS_TESTS)
 
 hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
 hello-mips: LDFLAGS+=-nostdlib
+
+ifeq ($(CONFIG_PLUGIN),y)
+# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbacks
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-mips does not execute invalid syscalls")
 endif
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 0000000000..5386855efc
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,15 @@
+# -*- Mode: makefile -*-
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+
+# Set search path for all sources
+VPATH += $(MIPS64_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# Require no ABI calls to avoid $t9-relative .got address calculation on MIPS64
+test-plugin-skip-syscalls: CFLAGS+=-mno-abicalls -fno-pie
+test-plugin-skip-syscalls: LDFLAGS+=-no-pie
+endif
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 0000000000..77ac8815fe
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,15 @@
+# -*- Mode: makefile -*-
+#
+# MIPS64EL - included from tests/tcg/Makefile.target
+#
+
+MIPS64EL_SRC=$(SRC_PATH)/tests/tcg/mips64el
+
+# Set search path for all sources
+VPATH += $(MIPS64EL_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# Require no ABI calls to avoid $t9-relative .got address calculation on MIPS64
+test-plugin-skip-syscalls: CFLAGS+=-mno-abicalls -fno-pie
+test-plugin-skip-syscalls: LDFLAGS+=-no-pie
+endif
diff --git a/tests/tcg/mipsel/Makefile.target b/tests/tcg/mipsel/Makefile.target
new file mode 100644
index 0000000000..bf1bdb56b3
--- /dev/null
+++ b/tests/tcg/mipsel/Makefile.target
@@ -0,0 +1,15 @@
+# -*- Mode: makefile -*-
+#
+# MIPSEL - included from tests/tcg/Makefile.target
+#
+
+MIPSEL_SRC=$(SRC_PATH)/tests/tcg/mipsel
+
+# Set search path for all sources
+VPATH += $(MIPSEL_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbacks
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-mipsel does not execute invalid syscalls")
+endif
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f5b4d2b813..25df6e7211 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 VPATH 	       += $(MULTIARCH_SRC)/linux
 MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
 endif
+ifeq ($(CONFIG_PLUGIN),y)
+VPATH 	       += $(MULTIARCH_SRC)/plugin
+MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
+endif
 MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
 
 #
@@ -200,10 +204,24 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
 	$(QEMU) $<
 
 EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
+
+# Test plugin control flow redirection by skipping system calls
+LDFLAG_TEXT_BASE = -Wl,-Ttext-segment=0x40000
+test-plugin-skip-syscalls: LDFLAGS += $(LDFLAG_TEXT_BASE)
+test-plugin-skip-syscalls: LDFLAGS += -Wl,--section-start,.redirect=0x20000
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-skip-syscalls-with-libsyscall.so
+
+else # CONFIG_PLUGIN=n
+# Do not build the syscall skipping test if it's not tested with a plugin
+# because it will simply return an error and fail the test.
+MULTIARCH_TESTS := $(filter-out test-plugin-skip-syscalls, $(MULTIARCH_TESTS))
+
 endif
 
 # Update TESTS
diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
similarity index 100%
rename from tests/tcg/multiarch/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/plugin/test-plugin-mem-access.c
similarity index 100%
rename from tests/tcg/multiarch/test-plugin-mem-access.c
rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
diff --git a/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
new file mode 100644
index 0000000000..1f5cbc3851
--- /dev/null
+++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test attempts to execute an invalid syscall. The syscall test plugin
+ * should intercept this.
+ */
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+void exit_success(void) __attribute__((section(".redirect"), noinline,
+                                       noreturn, used));
+
+void exit_success(void) {
+    _exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char *argv[]) {
+    long ret = syscall(0xc0deUL);
+    if (ret != 0L) {
+        perror("");
+    }
+    /* We should never get here */
+    return EXIT_FAILURE;
+}
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 42801f5c86..c5bac2d928 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
             fprintf(stderr, "Error reading memory from vaddr %"PRIu64"\n", a2);
         }
     }
+
+    if (num == 0xc0deUL) {
+        /* Special syscall to test the control flow redirection functionality. */
+        qemu_plugin_outs("Marker syscall detected, jump to clean exit\n");
+        qemu_plugin_set_pc(0x20000);
+    }
 }
 
 static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
new file mode 100644
index 0000000000..516927a3fc
--- /dev/null
+++ b/tests/tcg/sparc64/Makefile.target
@@ -0,0 +1,16 @@
+# -*- Mode: makefile -*-
+#
+# Sparc64 - included from tests/tcg/Makefile.target
+#
+
+SPARC64_SRC=$(SRC_PATH)/tests/tcg/sparc64
+
+# Set search path for all sources
+VPATH += $(SPARC64_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# The defined addresses for the binary are not aligned correctly for sparc64
+# but adjusting them breaks other architectures, so just skip it on sparc64.
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-sparc64 does not allow mapping at our given fixed address")
+endif
-- 
2.52.0


