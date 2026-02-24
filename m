Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC4FF3C9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuv4-0005g4-Dr; Tue, 24 Feb 2026 11:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuur-0005eo-Ni
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:05:42 -0500
Received: from
 mail-switzerlandnorthazon11022137.outbound.protection.outlook.com
 ([40.107.168.137] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuuo-0002J5-HL
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:05:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4NM8AVCDjCKCDfEmG0KjbOwkJgVJtwmNlvm+Hu5ugfiJ166/g+fuTDlgHDxTHYoYFenCScunm0JEhSretlFfQSH7q2BylP8P8wohn1mw16UiBsE0igg7+rhxLqq6QG6+4k1p28XO7gdHq8rCbRldF37pXsdh6XLFAMvEjc0MNKJiIzlyLIvXbRwuQhc2dtbFUHktHPPzqPGQEkxNLO4u7VCWozyfv166aCVXXV00SD1ZLFXzLoFW/0cMEqttFsT+rKcde8BA35KCNF8kpBib3RCQC4IdQFFGE0L23N4H3+OcEM8+Y7wL/p0/CcJ+26AN/C4u2pF02/HKVdNP2q+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDhDOuxRDrhI+KTCBzgwyNkgvzN0Rvun5n5L4wpcYgU=;
 b=sStRI+iIhLF0FXBTPgyA8wFGm3uIk/U5+JEyx2vjqJz0UcNOoqIptjBAsaIFrPB+yP6w9EpURyN82DTBUzbMl76HzP0IlxfNX8sjHmIC60HBfQXpe32Njyob4zkxVX4EhjBnd+Fx9zf8t6m7U5RkTNvSEPYjreA90tyohHrPsLyA2lbstLkBEfn37339MLo1pETNkzJCMVKoF8I/3Uuo0H/VGzUAnHFJuZHTlxIrpSJOl2Bt9p96y/3SebwYdkDG7+Np5s+8qpaYNhrK7t6lERJh5GesUXP8ov5ABR+BalLzU82e2EKoGbNKVM03obgdhbdU4D3A8Cztjbo+5qc2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDhDOuxRDrhI+KTCBzgwyNkgvzN0Rvun5n5L4wpcYgU=;
 b=dK6bVpjMMkUR6axTMgUeSy8uZp2o+ryag/nwQqhQU9OHkKaBZ5C0eo8mrhmLKI+Y6pJHrvdI1t4P8JEecQ1gr6EjsNayvUv7h4r+wfEKkedaW3LLVz+Yx1S/59ggXn5Js2bJDNHUJnc+gsdjGwZMoXcNjkQ+Fnpf4a1hvOuVvk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:30 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:29 +0000
Message-ID: <8dad9153-1e97-4087-a243-3e40cee83572@epfl.ch>
Date: Tue, 24 Feb 2026 16:48:24 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/7] plugins: add flag to specify whether PC is rw
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::26) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1cd1c3-ff15-4d7a-8287-08de73bdd4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym9jOFQ5U0FmK0ptQ2JmdmFPQnBLNWFIYVEvbXlTMHdqb2YzL0xuL1gycjNF?=
 =?utf-8?B?TjM5Mm4yUTdBdC80ZlJmZWo2OFN0Q2trblZzek8rMVdIQmt3VDZDWi9XTjY0?=
 =?utf-8?B?Ny9hTVVTMzdKUkpxU1QyZ211Yzk5QTFmbThHSXRnY1NhV3REUnZZVVFKei9k?=
 =?utf-8?B?N0l6UURzRzM2N0hxK0J6K09lR2pEVk15a2diR3lvcy8wYVBYK2Y2MlZXUFEx?=
 =?utf-8?B?aHJKc1NuanByWnpZNWZROG8vRzhJMEhGNWV0R3JlQXVIUlQ2RkttTnl6b3FW?=
 =?utf-8?B?SW5UUWhwKzJja0NwMDFtNnFDcGxkSEQyeEF4NWJCS29PV2JhMVVwNWo0ZTJZ?=
 =?utf-8?B?MlFoVlFzWGNJUmcxOW1MdGFlVDhZTi9QZEU4OTBBS1FkcDlvalJzQjdRaHdU?=
 =?utf-8?B?d1V6bDJOTHNrVHdNcStoeGJtMHJFeG1NdXhtY3g2V0ZkSE1TQndhdWZJM1Zu?=
 =?utf-8?B?WElqTHlsUnBXQjlzVkI1U0tJNDR1eHdic1V6MWJFVlVZSWFOeXhyZGlXUHZr?=
 =?utf-8?B?L0lHRnVIcFRWSnArYWtXUzN4RmxtaEF0NE8zOVNOOFMzeng2WXhjanlSMHlJ?=
 =?utf-8?B?RW1LSzluMUw3MXVmUnlCckdPZDJ4MGhSd0hzcEhpUHJibjllVXY1WE1zSmJB?=
 =?utf-8?B?dnV2WVc2SHdyallWN042TFg1bVpob2o1d1MwaUhYYmFHUHI1djhTWXJhbGRS?=
 =?utf-8?B?MkhnVWEyd3kwRmxKK2tocWpPOEFkU2RRSjYvVTBTR1UrTFl3VUluMWFTMVA5?=
 =?utf-8?B?TFNlQVJYQWJhQVYyV1gvSkc3VHVGc2p2WWdmRE5CaTNuQ3RFNmhKays3c3E2?=
 =?utf-8?B?TXV0bDVnUVhzL0JIejRYTi9CWFZ4anFyMXFDS3RrbmR4alByOVRBT3BnMzhY?=
 =?utf-8?B?eE9tajRJK1o4UW9PUXNvV0RPQ3RQb2Y1UjUzK2pERVhucFRSMUpWL2UxKzQ1?=
 =?utf-8?B?SmJLUldMZncwaVVEUVk0c0kwSW1WMzJmMXlGTmsvVGppUk9ZZHo5UHRJNWlR?=
 =?utf-8?B?SVJTUFZ0QUFhQktqYlN5RXFIYUdwa0hoUUVZaElvVHVQVzNUUVRMWjZ2Vmhs?=
 =?utf-8?B?MEJuc2dHZ1dJT05XVmM0dzNuRUp0S0hJcC9Rd25OZGhPdTJRL1FMN2cxY2Nx?=
 =?utf-8?B?N2VHT3R5am9uS050N1ZYV0Jwa1Fma2ZxZXY2TWNwVVZ1ZWtINm5sRTlFUE90?=
 =?utf-8?B?WmI3S3YxMVA3djR6TE9TTjdnR1g5ZWtHRVVrOWtxdEFHQVhzZUx4K2FNU05j?=
 =?utf-8?B?WWZuVzluakg4R09GV0w3dGwxUzZIY0x5Z0JLd3RjZ2ZBTGdPUW5jSC80ZFhT?=
 =?utf-8?B?RTJHam5wSndGWE14OTQ0NnlXWm1mMVR2VFhSV1JpeWNuRFVQcHJQZ0Z3U1JX?=
 =?utf-8?B?QVdub0JrMDRBUTlFaDBpSklZNzhzK2N4aFd6d0VGMzFYTkNScThCb3VNZ3Bk?=
 =?utf-8?B?RXRnelBBOEd2TE1wdUMya2VMZ1FxOWhxNC9CWXFIbEVKQXNBVUVUalVhRWg3?=
 =?utf-8?B?MCsxNFgxQUVNblRlZVBMam1xbU9tQWcrcmUyRnk2dC9ONXFkYVZPUFhpeVg4?=
 =?utf-8?B?OUpsWVpEVVlKNWpZcVk2VUpqUElrUFRuSEpzS1RGYWtLMXJOcjJkODZ0SGhG?=
 =?utf-8?B?eGk3U0xDaktsbUVVbG9ITG1HKyt4NjRsTDRTRG1wcURId1h2dnowNDNiWkZF?=
 =?utf-8?B?bnd4WUNwUmJ2bXlnZTRDRVBlYll4NGRhSDhZRHZJeGx0bHcvZ25PU3c1TzMy?=
 =?utf-8?B?N1JsNkIweElrUE0xamV2a1plYnVqZjZ5L3NOcnNuUFIyMFArbFRiRXJIdTYr?=
 =?utf-8?B?QXFFaitLeWp3dUs3blpZTXNnYmVNUThaVHMyUEVDTjd0QWpJa3V5aUs2WW5p?=
 =?utf-8?B?Zms0RWdLWFJFS1QzSEZGdnJrM0ZNOFlNczRROGkzaUVmdURMdnZSdGVXWFVv?=
 =?utf-8?B?OUpMN2kyYUdCRFRwSHYyRjFtNmU4VFFlOW10TEM5SUJjM0NKREUwZ3ZxUTNC?=
 =?utf-8?B?eXFrNHRoMFNPWkFQQ3dqSFZKOVk4UDBuSDBNblRUNUg2UVlVYy9pOXYvaFJY?=
 =?utf-8?B?a0VoL2UvOXp2Vk03dnJoU1ZwRVhxeXI5RGR1VTdkdmlaMnNpVldaNUJ1TUtI?=
 =?utf-8?Q?G8CI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxMdi9jWTNZUWYxU1hSbkp3ZlZMZmlRWW8wRzh2WWxweE5SeTVqbEN5MWtW?=
 =?utf-8?B?WXVEQTNMSFBtSTdWTTN4ai9NRW55OU5XVHlYZ2hZY1d2SVdLMFpnT0VRTk4y?=
 =?utf-8?B?MElGRlkyUlg5OXlVbi91M3R5OExuVXVKYkt2b2ZHdWpaSmtnYmY5ZXpTZmdm?=
 =?utf-8?B?VWlHSnRNNEREM09RQ2RKRXJNM2ZHc2kxZzE4Mk1hUWNhY2Vna0FQQmhLMDhm?=
 =?utf-8?B?TXljMGVvUzFYbUZXeFVnZDdzcnFXY3c3c3hJVHdvVEpTRXFwRFRsZGlJMHFH?=
 =?utf-8?B?M0QrL002dTl6bkpGSkdPbUtITVFoWmVEUi9icEprZG9UZXlRSmVhVEk0bllo?=
 =?utf-8?B?ZHJOT09hL09qNGM2dmF2WEJNaGxPcU5qK3ZFeXdsejNPSndFWXVFSkFYVDEy?=
 =?utf-8?B?UkVEWkZRZ09uTkFqNmxweElXUG03d04wS2xyOUVicmdSNExEaHhmM1c3YmRE?=
 =?utf-8?B?M3dNdE02KzlmUWJwd0JrOFBkOFNVZ25tVmVWZFdSKzBiYjR2TUk5WXlmOG9n?=
 =?utf-8?B?UFh3NHhBcDhFWU5sYkt1aFNVcllwVUk0Ymd3OWVRTHdNaWVPUVh0UlhSSU1o?=
 =?utf-8?B?Z1dabENDWjlBaFVQRjhnOFhhUmtnNlFLalU4NmpHRHplMkNQUHdPSWxPRjlE?=
 =?utf-8?B?NnU4RHdMU2V6dGljdUs0dDZWTUc4ZHJLeE03ZDZZV2ozVHV5cEZWZmI5RzR4?=
 =?utf-8?B?M3VJVU9vczNqSDl0SmdPcjZZeTk1b1U3dXlGM3NiRkpMbzUwc2ozYzJucjdH?=
 =?utf-8?B?M2VtcEsxaEI1R0kwL3V5OGtSSzBJb2Zqa1RJclNCWkFBQUN0S3hpdklDZTRQ?=
 =?utf-8?B?ZmNqcUZDWHd0VGhMalBRWkZyRUl1OThIQ3hubXF0S296aktVL21YWVVnVW9h?=
 =?utf-8?B?UHVvV0M2Z1M3VWx5SFNCMjhBZkZnL051Rm8zZXNoanRsNm5pdVh5YTRnZldG?=
 =?utf-8?B?OER6blZ2Rit6bVZZVnR3VEt0VGlDQkgrbGxDNWc0OTlkWWZLRUp6bEhmS2RZ?=
 =?utf-8?B?U0E1cmRPRXFnR3hBNTVMNzY4dUVVZ2pYaGtYL0xnZmNIdFVsNE9qRC9tb2FO?=
 =?utf-8?B?QlZSZ2QzajdtdUNwTkt5VTl4ZzlGMUNYcXJKdmlpbTdiVzJwOUVkYjJlMmxy?=
 =?utf-8?B?T0FHbVNyWTE4YTZFSlVqclo5V3NGc29zL1J3cjFQOWhYcElpT2YwcG1HVVVV?=
 =?utf-8?B?MzR0ZEdBRG5yMlUxYjJlUmZwb090c3hqMmNjRllWZFplbHhmczgxZTdOZXpv?=
 =?utf-8?B?T01HTDRoODRPWDVXOERkaEdkR3RmK3J3aWZRcHZjTG1tQjFPYnJZTVV3WUdh?=
 =?utf-8?B?SUhUMms4RFBkR3BaNC9lZnNad2NqSXhFYlhVTEN6R0hJZDlVYTRlM3p3RE1X?=
 =?utf-8?B?NC96T1RSeU1NTHVhTlZMR0EyUHAvT3hVbUlvYU9ZMGp0N0d0M3B0T280ODN5?=
 =?utf-8?B?dWdOK0FTeFRzK0lBR2pWK0tNT0RDYlNPTzROd3pBS1N0TUFvMjFsdzluTllD?=
 =?utf-8?B?M1V5Z3Q0ODJxOG15VzdnMjBtN0Y3RVhPVnhzQm0wM1hXSjJkWkp4dFFlNkth?=
 =?utf-8?B?ekovSDM5RHRLTm1ZY3BzVEcyOGpocmRPTlJMWC9pbHRLNXAxMUtvTjEwMFFT?=
 =?utf-8?B?TlVQMm9wWUdPa1RCQ2xLMFdUb2luSGxteVZFaGwvQ1hjSis3T2lLWHNqTzFN?=
 =?utf-8?B?SGhvNk5wVmdsSUE3eUtzQ2JOU3N1Wkp6T09rb2lPbzFLbk5ieUplVEdGSXJG?=
 =?utf-8?B?OVVPNzN6dTQwQmh4Z0RnZllMMFhqd2o3NXN6NUNaZkxKZmlrZjlOWHlCYzFV?=
 =?utf-8?B?M0RZTS9UTi9hK3hpdUp1V3JFaUxxN2d1ZkZjbHFIL3dmU1RneE1LZllkdmhr?=
 =?utf-8?B?ZVFneVNnaXNZWUtJWTN5MzB2MjlQam1rM0ZyYWszK0Zwc2t0SVFWbmx4Q3dM?=
 =?utf-8?B?WVF0eXQxMnh1RUFWbHhsdG5rVjJ6WTRjYUUxQ3J0NERMZ1ZTY1l2a0huSW51?=
 =?utf-8?B?a3QzSERWRUl2V2M4MFRHVi83NXhrbHVGQ0pQalB1NnlkZTZVMk9pcnIwOVV3?=
 =?utf-8?B?UkV1azN4b25USG9ub0tYZEVYSlByYmJaV05oKzhDMkgwY0F1MDRrNE5uMzQr?=
 =?utf-8?B?aElaSjhrMk16aUhQUHVlN0E4aVgvR1B4ZDM4akllMVZGcHFpU1M1L0NOZEg4?=
 =?utf-8?B?SWQ1d0l1YjZyRlRLcndjT0hOYk9SQTFrRnFHZ3g0ajYybTZKcWFUWTVUZStu?=
 =?utf-8?B?b0NnV2ROdGQxT252S0ZsdExudW5rZDlWQU9nVW1hb1lubDBNMnl4TVkrZk4r?=
 =?utf-8?B?ZHpOTjg3b09qcUlUMXZxelR3YStuR0RkYU5FMVkyV0N5dVhjK25kZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1cd1c3-ff15-4d7a-8287-08de73bdd4e8
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:29.3598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/9BW3xvvqC31HOgR09P5gEb+ePTRx2lYei65pyCfvTmU9e0O1dD9qnbxmeUSMz+JakLs+fI2V1UiT2sU5WrGymRQGFKS4DTEiYolCKesXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=40.107.168.137;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In addition to the flags specifying whether general-purpose registers
are read-write (rw) during a plugin callback, we add an additional flag
explicitly stating whether the PC is writable. This is in preparation of
a patch that allows to explicitly set the PC to divert control flow from
within a plugin callback, which is currently not possible.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 |  3 ++-
 plugins/core.c                | 29 ++++++++++++++++-------------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 17a834dca9..a6ec8e275d 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -325,11 +325,14 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
+ * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
+ *                             regs and updates the PC
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
     QEMU_PLUGIN_CB_R_REGS,
     QEMU_PLUGIN_CB_RW_REGS,
+    QEMU_PLUGIN_CB_RW_REGS_PC,
 };
=20
 enum qemu_plugin_mem_rw {
diff --git a/plugins/api.c b/plugins/api.c
index 04ca7da7f1..e754b7c69c 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -458,7 +458,8 @@ bool qemu_plugin_write_register(struct qemu_plugin_regi=
ster *reg,
 {
     g_assert(current_cpu);
=20
-    if (buf->len =3D=3D 0 || qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_C=
B_RW_REGS) {
+    if (buf->len =3D=3D 0 || (qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_=
CB_RW_REGS &&
+                          qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_R=
W_REGS_PC)) {
         return false;
     }
=20
diff --git a/plugins/core.c b/plugins/core.c
index 42fd986593..7220b9dbb4 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,7 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to =3D cpu->cc->get_pc(cpu);
=20
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time =
*/
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -395,15 +395,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] =3D {
+    static TCGHelperInfo info[4] =3D {
         [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
+        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -425,15 +426,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] =3D {
+    static TCGHelperInfo info[4] =3D {
         [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
+        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -464,15 +466,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
=20
-    static TCGHelperInfo info[3] =3D {
+    static TCGHelperInfo info[4] =3D {
         [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =3D
+        [0 ... 3].typemask =3D
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t=
)
@@ -534,7 +537,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, ui=
nt64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func =3D cb->f.vcpu_syscall;
=20
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7,=
 a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -558,7 +561,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_=
t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func =3D cb->f.vcpu_syscall_ret;
=20
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -584,7 +587,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t =
num, uint64_t a1,
         return false;
     }
=20
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
=20
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_filter_cb_t func =3D cb->f.vcpu_syscall_f=
ilter;
@@ -605,7 +608,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case *=
/
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -614,7 +617,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -885,6 +888,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_fl=
ags(int flags)
     } else if (flags & TCG_CALL_NO_WG) {
         return QEMU_PLUGIN_CB_R_REGS;
     } else {
-        return QEMU_PLUGIN_CB_RW_REGS;
+        return QEMU_PLUGIN_CB_RW_REGS_PC;
     }
 }
--=20
2.53.0

