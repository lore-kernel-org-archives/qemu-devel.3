Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EB1CE8D76
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 10:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srES8-0007DK-2E; Thu, 19 Sep 2024 06:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1srES4-0007BR-07; Thu, 19 Sep 2024 06:31:56 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1srES1-0005eZ-5y; Thu, 19 Sep 2024 06:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV0pQH5QASYN+diK0g0TBBDOmPHVke0T85tiQ5dsmLS6QDADjwgKuFGaEsp3lZC9q5tPcPL3HQ8l6C+K/b82q51ugYnOpGFf+hcHy89KCuL8ylrcLZodUNnsNBHg7nw9uaJv4h1kGZYCDK6xneVURQSsvIYYRkJwokKy4Cf+206DDfbXKqMTbAoiak7ys3dDdj8F2gXQFpFvVEqc3GnhHt3HzKAilj0BuTjli/7p+Yt038bePnNxsrDbJa0zh51mFe1TfcuSAFsHvcyau+xAelggBWJrZVcUROj7wk4LACwsufgnnh9xlkWRG3q991CV+r7Cp7Kw+BDzUBJ13EtUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbaKrDg+CqT4sSVBW9y2Y8m+HtOykOYd/yhYDznEsw4=;
 b=EUCS6ePeUP/87DLA1fhYngNsD5yzbvyN7QByXFzXv0v4xVKNHjY8n/Z+i0Q/FhthCeiIl69a27eizbzdO4HsaltAcQETWY4hzMJ9KELRGBhKQqGzwdgAKzj2YuyB3Key2RppTQ2frkYdl4zc6pWP8Mu7DDdGnTH8t39shqH09Z0lTMl8VPUqX+D8YT7QQK9At7I0p39iGhoUwZQmgSKFFvViOAgxBfkbJe2VEwqTlUOWFQdctl0Q+1YjeWaSPA+j/AMqA52lwVq0Dj9nStaxO/Erlluo8Bminvlb1UODPGp5mIIsvpBLNOw3ExHDvdngfzGrnw9zlWNFcFm7sknfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbaKrDg+CqT4sSVBW9y2Y8m+HtOykOYd/yhYDznEsw4=;
 b=LuvhmqgtkiAPEY5XJ/+bVkv+WDnwcFfFgHrwVPxFUp+OIt4R7jezkDWFktWbZmBMwBy9ISb0ZJFvsA96Y+sV3fV8yzDaGSg/hE+7Hkbqi5fiK5K5fPeXDUEtf7YNrr9gW0NWECFfDIXKepLVn6Iyn0NYFyTyQRLrvg1lHbUOZxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ2PR01MB8620.prod.exchangelabs.com (2603:10b6:a03:543::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.21; Thu, 19 Sep 2024 10:31:47 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 10:31:47 +0000
Message-ID: <879f7e65-070a-4d9b-b70f-60576b7b5319@os.amperecomputing.com>
Date: Thu, 19 Sep 2024 16:01:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm/kvm: add support for MTE
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, darren@os.amperecomputing.com
References: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
 <0faf9a7c-0400-482c-974f-7b70e1d58202@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <0faf9a7c-0400-482c-974f-7b70e1d58202@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ2PR01MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: f76c46a8-e3f7-4596-9714-08dcd89643ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTdLWGQ1VEVWMUwzZjUxYkptcTVHS1ZYcWN2TjlXY2lDUEZGUVorZnR5WFE5?=
 =?utf-8?B?aWlSWHVMemR3M1ZSQVp4OEYxeU5pU3FxelRCTnhhMlhKTjJSODJrY0VrZVB6?=
 =?utf-8?B?NVpHMGV6azVSMmNSb0hiUDVnYkNIQm02eEFHQ1VMUm9rc0t3L3ptTlhGSzZw?=
 =?utf-8?B?SmxhVU5POFhQdWtjZzdQYnlFM2xVem1Ja0c2ekZ1dDg0OFdiaTVzSmZ3UjNZ?=
 =?utf-8?B?TEZ4NzJvSy96VGx4RDZRZzdZV1RCekRxOTl4dHFPK1dVQ0tkRVcrQ2tDbFB5?=
 =?utf-8?B?OGh6SG9Wd1RwaEszZkd1VDRIa1lpSWxWZ2VWenpaMU42NDl4Tzg1MDZLTFFL?=
 =?utf-8?B?WmZsbXE4SnBMRFp2czFoK0lMdUJkWVFkQ1BORi84S0tUN25oT05vSDdhYld4?=
 =?utf-8?B?VlQvK0toM2pkVTJhMG1yVmZvd2h5Y2Y4NGlVSlBwVEQxbkZROWRuVkNFWHhn?=
 =?utf-8?B?bmtTdm1DZ3FqeXVJbTdjSTlVdjF0KzduN2FUVElxYkhRQXdZVFkyaVF3Rkt1?=
 =?utf-8?B?UHBxSFlJNWhjM0I4R0dUTmZRNWZsWEh0Z0JQT3NLRTZQeFhiSERvM0YvTzlq?=
 =?utf-8?B?Tmx1citsOFBEcWdGTVpxaE53cDg0OVY5SnFkNUxOelBPWWF3SDFPSEY0OU1j?=
 =?utf-8?B?UEtDZW10SXBhT21CS3pQWTd2UTNYbHNSQzdFMVAweFVheHgxRVVlOTF1cFVG?=
 =?utf-8?B?cDNFN240aVlVSDNUa0J5ODd2SGpFbE9jaGhQcmw3azB0WnlNL25mOXY1azZT?=
 =?utf-8?B?cVlYenZmVjNSZHF6N2QwYm8ySXUzNUZ5bkpubEZRdUFMeE52NDE3azFSR2xk?=
 =?utf-8?B?QWkvVll5VStUVzFKWC85SVVrUVh6TXY2SHgvVWlPKy9ZOE4rNEFMQVZXajV2?=
 =?utf-8?B?dkl3NEVRZ1p0b0lpcitkTGREL3BqL1JVQ1Z3Zm1YamV5bWp5TWFPMGJBaFlr?=
 =?utf-8?B?QnpDaXhKUjlyeGp3bnBEamJyUmc3QUwydUhrdHFaTG43RldadTFTUmpFdmpZ?=
 =?utf-8?B?UnB1bHV1em5KMlFUYjBCQStWNi9CeVZvMmFMVGhpZzM5ZzZsUEpYS3lmQktR?=
 =?utf-8?B?MmtMS3Npa08yanlrbTZOalRNemtNNTBKd2VVZ3lLeFRxM1ZWRlZSU21aMktT?=
 =?utf-8?B?SXVSMU5mMkdLRDhsc1pUQWw4L2I2QXQzWEdFRGt2ZUZmbEk4bm5vUldBNjNw?=
 =?utf-8?B?eVY1RkxTOERyc0RPMFNxcWtOZVAzVHBLVnEyUFJYZ0srYlVhNUd5MWJsbnd1?=
 =?utf-8?B?d0hBYnlPRndhbDRiV2RvaHY4bUN1dUl1V01Hd0U4dm9uUWFPeGlHbXhpYmZK?=
 =?utf-8?B?bytRd3ZJdElYeEhPaFlGemZTK0tWeHlJaWxqSHh4WVFUTE9kYVlraDMyVm02?=
 =?utf-8?B?KzhvNEgxeXRKNE1udldXSHJLS1pWS1dxY1UxcXVwaXhQRHJrMFJLRlhWRnhQ?=
 =?utf-8?B?QS9SMDVtTElDL2RYWFNjbjdZSURXaS9BNUFGeTlLMmh6R2pkV04vaHZ1Mm5B?=
 =?utf-8?B?UGM0dXJCUXp0OTl4N1dLS243b1ZQZWNIRzNSeW5MVVREWVZ5VmdNaE5NNWpO?=
 =?utf-8?B?TXBYR1lCS09LRkhIeTFXd25DM1NGQlo1RTJMQjVtV2Z6cEJ0clRKMXJoOXdj?=
 =?utf-8?B?cXFlejd3NVpBOGdINW5UTElWczIxcFppQ0FDbHpIMnlHV09BWFc5bEF5b3BV?=
 =?utf-8?B?eGl4THMzZCtTLzMreFRBRWEwd1VCWXA5TU90TUluWmNiVlhnSGs5TmRSR3RJ?=
 =?utf-8?B?QzJTdFBKekNzMFRmOU9CakdPU3BGWDZ4SjFIcW1qZEFhSkVlbHlIOXFpNWhN?=
 =?utf-8?B?ek5HWmNBVjc3YWtuTWdRZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhreG91TUtHcWVQUkE4RURDVFdhUmVNQlhXaUhPd3JFMElMMzdWVTVjN0pJ?=
 =?utf-8?B?bFduOVFRMm9Oei9OYWt4dFZTZEt5NDNZRUxFNzZVQUJBT3N5Yks0S09la3lX?=
 =?utf-8?B?ckxZb2VXS1ZUcG91NVJqK1FTdnM1Qm85MEtZeHpjc0ZabXE2OHl4R0todjEw?=
 =?utf-8?B?UXJ5d3lvREpUWTBLYnZjVmNiUDlhT1RMaFZVdFNNNzJ3alhsOW8xODZvOVVj?=
 =?utf-8?B?dW80aGxYWGFMbGZPNnFRdjRtTUxpZUJFUTVYTVVqb2hFVWU0aFZwZmpRZmxF?=
 =?utf-8?B?TWF4cjh1elNMTTMyR2VhSHp1Tm5yOUIyMmZzczU3MWZhUlgvNGpWRW5jSjFB?=
 =?utf-8?B?UWY4R29UWEZYYmI3Tkh1Zmx6MEJCbTdUY2Y0TDZMcS9ybVNKNDR4T3NUbWhJ?=
 =?utf-8?B?SFpIdStQQUxySU9Xenk3RXc3RVdwRHUwdkVOTnBJZFhqSS9lS3JsVnZIOUNX?=
 =?utf-8?B?NVRGaXRwanFBZVEwZ0ltdlpEaGNOMXBlY0VVejhvZHhlemt1b3RTL0Y4cFV3?=
 =?utf-8?B?L3o2RHdxQnE4YUIvNFlobDE4Q25OTGU0NUIyVFZoZTZTYW14WFBkamEvK1hi?=
 =?utf-8?B?UngyRS9rSHhydDJ2SDVCUXdocWZUWmsxQWs4ZHNva0xENG1reXR6WFpvbkU0?=
 =?utf-8?B?U0duTlJLdk43MXlOUllCUHJsSmpxdnVheGR6RnZpNy95WjUrRzI4bjFjZFdU?=
 =?utf-8?B?L1dMNzVCbS8xbVd0VldZQ1RtK1h5eksxclJlT091aURPcnRRVjMrbVBtNWEy?=
 =?utf-8?B?M2VqVFl4VGpwZVZpdHhSSUhqSzdvWHdBNDJ6MHl0cXJuamgvRGdXd2hoRS9R?=
 =?utf-8?B?R2lVTHJSM2RZRC9Uby9PMmJuUmxxU0lqZ1FBVUxhT3lkQVZsWjlnaVBtcEht?=
 =?utf-8?B?YUNQdDJsTFhKcitPakFibnM1aGhYdnZiYmVvVktCNlVBNmlqc2s0N053UHE5?=
 =?utf-8?B?TDR3cjhzSHMwYzQ0OTgxTDlMTkx2STJpdXBRUUl3d01CaU9uRjZIQjBack8z?=
 =?utf-8?B?YU9IMzNDRys1eHo0UndDclR2aGJ6ci8zOElyYjlNZXJaSEVTVm11ZEZhMmNq?=
 =?utf-8?B?MWpPbXNONWxIQVRWaFBrRUc3c2ZsOExoZ290MXlSdnlPZCtiMDd5eHJDYzdn?=
 =?utf-8?B?UnFuQjJPQTNERHJBK1Y1ejluUUNqRnpSdmI2V0JMbnVpT0lWWnFqTnNEc2ZP?=
 =?utf-8?B?VjhXYU9CNC9aVVJnSWdVTlU3U1BPcjhqeWNqanJheGFHTVpUTjdjSDVQR1R6?=
 =?utf-8?B?VlRuZHl6UlNPV3ZSaFZuMVh6TzJpOGlLTmJPRjNiRzdZS1RTNDFSNTZmcHB0?=
 =?utf-8?B?eVYrcUZGWmo0ODk5YjRLTDRmYjlhZzRBU3NiaWIrRUw0cEQwdDRjR1NPeldj?=
 =?utf-8?B?UE9LWUh3UC9namtHWHlUNDdKVmpGNnZnL0RvNVdneTlRM0RNMWo2WWV0Rytp?=
 =?utf-8?B?NmMzM3haVmpxVG8zaEVTNkxPNjNPVTJVNE9wellEamVPbm5xVXVvQVE3cjNG?=
 =?utf-8?B?eldRUkRVWXpUbGttcFE3K01IKzI5YXJXZ0lXMWlsajE0NnZ6L1Fwekl1UHdS?=
 =?utf-8?B?R3RDclZCZTJ2Mjlmc1NFMzl4NmlSZDNjL0VKU3J4OW4vRWVRTHdjNnNOWms3?=
 =?utf-8?B?M3FwVmpOUk1sanNwSEhkekUyT01tYlZlSTc0cHdBZnA0UlZSSU5NMUZIU0N4?=
 =?utf-8?B?eG9zSS9SWldaNVRxNk5pWnFwQmtrN0JJY0pTaTVsWmVqbXQ0aEhXS0F4djZt?=
 =?utf-8?B?eVNxWE9ZRDFHSnRyZVc2ZTNjdS9rb2prdUlCcmlMd0p5YkhOSnNxdU1SbGFv?=
 =?utf-8?B?VTNtNlpRWmFDbWNaUEcwbis2Q2NKOXBtQWlTN3BMbUI2cWxqR3Q3bXJ1MlpP?=
 =?utf-8?B?azRjbU9kTyt3bXdkM0JDNW41YmNKK0gyY1k5bHNUNmYwKzJzTTRmRTFCTDZE?=
 =?utf-8?B?YXVyMGtBWHV6RkxvbnE4UzU4QXdQTmVNeW4wT1JybTEvcTg1bEhja25ZTEhj?=
 =?utf-8?B?WnZOSEZhcU5qWHpOYlk4NU8xbTBaMVBTYjM4T1owUWl6VGgxSmpkWUFiOXow?=
 =?utf-8?B?WVZ0YmZnU3ZlYnZWamcxaTdmQlFmOEx5OTF0STRMR3JBanpYdUZoUGR5NXNI?=
 =?utf-8?B?Y3k2b09NS2FBbTVIN3VhR1U5cUpiVzB5cWxkQ1NwSUhsYlRpaXRDQUhFREVw?=
 =?utf-8?Q?xWmQBruR8KEApdp8z+ODdk3D3dOefYJ9B0YdrzLu6bw3?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76c46a8-e3f7-4596-9714-08dcd89643ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 10:31:47.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lRmbTjgjtfMbWUDaoLo8FQvAGdtJol9JqsOmMxFAed7PZBDMaXUeInOV+nBu0xgnGGXKIteSTOa1mtd3YfyOk1eXrBlOtSLBV4O98Yd5nE0AHD+fVlumvvRLJVfuSUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8620
Received-SPF: pass client-ip=2a01:111:f403:c000::1;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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



On 19-09-2024 08:52 am, Gustavo Romero wrote:
> Hi Ganapatrao,
> 
> On 9/12/24 06:16, Ganapatrao Kulkarni wrote:
>> Extend the 'mte' property for the virt machine to cover KVM as
>> well. For KVM, we don't allocate tag memory, but instead enable
>> the capability.
>>
>> If MTE has been enabled, we need to disable migration, as we do not
>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>> off with KVM unless requested explicitly.
>>
>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>> which broke TCG since it made the TCG -cpu max
>> report the presence of MTE to the guest even if the board hadn't
>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>> then tried to use MTE QEMU would segfault accessing the
>> non-existent tag RAM.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>> Changes since V1:
>>     Added code to enable MTE before reading register
>> id_aa64pfr1 (unmasked MTE bits).
>>
>> This patch is boot tested on ARM64 with KVM and on X86 with TCG for 
>> mte=on
>> and default case(i.e, no mte).
>>
>>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>>   target/arm/cpu.c     |  7 +++--
>>   target/arm/cpu.h     |  2 ++
>>   target/arm/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++
>>   target/arm/kvm_arm.h | 19 ++++++++++++
>>   5 files changed, 126 insertions(+), 33 deletions(-)
> 
> Overall the patch looks good. I just have a couple of questions.
> 
> 
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 7934b23651..a33af7d996 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2211,7 +2211,7 @@ static void machvirt_init(MachineState *machine)
>>           exit(1);
>>       }
>> -    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
>> +    if (vms->mte && hvf_enabled()) {
>>           error_report("mach-virt: %s does not support providing "
>>                        "MTE to the guest CPU",
>>                        current_accel_name());
>> @@ -2281,39 +2281,51 @@ static void machvirt_init(MachineState *machine)
>>           }
>>           if (vms->mte) {
>> -            /* Create the memory region only once, but link to all 
>> cpus. */
>> -            if (!tag_sysmem) {
>> -                /*
>> -                 * The property exists only if MemTag is supported.
>> -                 * If it is, we must allocate the ram to back that up.
>> -                 */
>> -                if (!object_property_find(cpuobj, "tag-memory")) {
>> -                    error_report("MTE requested, but not supported "
>> -                                 "by the guest CPU");
>> -                    exit(1);
>> +            if (tcg_enabled()) {
>> +                /* Create the memory region only once, but link to 
>> all cpus. */
>> +                if (!tag_sysmem) {
>> +                    /*
>> +                     * The property exists only if MemTag is supported.
>> +                     * If it is, we must allocate the ram to back 
>> that up.
>> +                     */
>> +                    if (!object_property_find(cpuobj, "tag-memory")) {
>> +                        error_report("MTE requested, but not supported "
>> +                                     "by the guest CPU");
>> +                        exit(1);
>> +                    }
>> +
>> +                    tag_sysmem = g_new(MemoryRegion, 1);
>> +                    memory_region_init(tag_sysmem, OBJECT(machine),
>> +                                       "tag-memory", UINT64_MAX / 32);
>> +
>> +                    if (vms->secure) {
>> +                        secure_tag_sysmem = g_new(MemoryRegion, 1);
>> +                        memory_region_init(secure_tag_sysmem, 
>> OBJECT(machine),
>> +                                           "secure-tag-memory",
>> +                                           UINT64_MAX / 32);
>> +
>> +                        /* As with ram, secure-tag takes precedence 
>> over tag. */
>> +                        
>> memory_region_add_subregion_overlap(secure_tag_sysmem,
>> +                                                            0, 
>> tag_sysmem, -1);
>> +                    }
>>                   }
>> -                tag_sysmem = g_new(MemoryRegion, 1);
>> -                memory_region_init(tag_sysmem, OBJECT(machine),
>> -                                   "tag-memory", UINT64_MAX / 32);
>> -
>> +                object_property_set_link(cpuobj, "tag-memory",
>> +                                         OBJECT(tag_sysmem), 
>> &error_abort);
>>                   if (vms->secure) {
>> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
>> -                    memory_region_init(secure_tag_sysmem, 
>> OBJECT(machine),
>> -                                       "secure-tag-memory", 
>> UINT64_MAX / 32);
>> -
>> -                    /* As with ram, secure-tag takes precedence over 
>> tag.  */
>> -                    
>> memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
>> -                                                        tag_sysmem, -1);
>> +                    object_property_set_link(cpuobj, 
>> "secure-tag-memory",
>> +                                             OBJECT(secure_tag_sysmem),
>> +                                             &error_abort);
>>                   }
>> -            }
>> -
>> -            object_property_set_link(cpuobj, "tag-memory", 
>> OBJECT(tag_sysmem),
>> -                                     &error_abort);
>> -            if (vms->secure) {
>> -                object_property_set_link(cpuobj, "secure-tag-memory",
>> -                                         OBJECT(secure_tag_sysmem),
>> -                                         &error_abort);
>> +            } else if (kvm_enabled()) {
>> +                if (!kvm_arm_mte_supported()) {
>> +                    error_report("MTE requested, but not supported by 
>> KVM");
>> +                    exit(1);
>> +                }
>> +                kvm_arm_enable_mte(cpuobj, &error_abort);
>> +            } else {
>> +                    error_report("MTE requested, but not supported ");
>> +                    exit(1);
>>               }
>>           }
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 19191c2391..a59417aac8 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -2390,11 +2390,12 @@ static void arm_cpu_realizefn(DeviceState 
>> *dev, Error **errp)
>>   #ifndef CONFIG_USER_ONLY
>>           /*
>> -         * If we do not have tag-memory provided by the machine,
>> -         * reduce MTE support to instructions enabled at EL0.
>> +         * If we do not have tag-memory provided by the TCG
>> +         * nor MTE at KVM enabled, reduce MTE support to
>> +         * instructions enabled at EL0.
> 
> What controls if MTE insns. (stg, etc.) are enabled on EL0 and EL1
> 
> are the ATA and ATA0 bits in SCTRL register. Also, AA64PFR1 is a
> 
> register just to report the features available on the CPU, so I
> 
> wonder if that comment is indeed correct.
> 
> @rth: what do you think?
> 
> 
>>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>            */
>> -        if (cpu->tag_memory == NULL) {
>> +        if (cpu->tag_memory == NULL && !cpu->kvm_mte) {
>>               cpu->isar.id_aa64pfr1 =
>>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>>           }
> 
> If MTE is off on TGC and on KVM, then we're actually setting (deposit) MTE
> 
> field in AA64PFR1, meaning that MTE is implemented? or am I missing
> 
> something?

Thanks for the comment.

Looks like I did a mistake by mixing the TCG and KVM.

I have modified as below diff to keep TCG if loop as it is and adding if 
for KVM case to clear/mask the MTE bits if MTE in KVM mode is not 
enabled by user command(if no mte=on).

Is below diff makes sense?

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a59417aac8..523996576d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2390,15 +2390,20 @@ static void arm_cpu_realizefn(DeviceState *dev, 
Error **errp)

  #ifndef CONFIG_USER_ONLY
          /*
-         * If we do not have tag-memory provided by the TCG
-         * nor MTE at KVM enabled, reduce MTE support to
-         * instructions enabled at EL0.
+         * If we do not have tag-memory provided by the TCG,
+         * reduce MTE support to instructions enabled at EL0.
           * This matches Cortex-A710 BROADCASTMTE input being LOW.
           */
-        if (cpu->tag_memory == NULL && !cpu->kvm_mte) {
+        if (tcg_enabled() && cpu->tag_memory == NULL) {
              cpu->isar.id_aa64pfr1 =
                  FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
          }
+
+        /* Disable MTE, if it is not enabled by the user for KVM mode.
+         */
+        if (kvm_enabled() && !cpu->kvm_mte) {
+                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+        }
  #endif
      }


> 
> 
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index f065756c5c..8fc8b6398f 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -922,6 +922,8 @@ struct ArchCPU {
>>       /* CPU has memory protection unit */
>>       bool has_mpu;
>> +    /* CPU has MTE enabled in KVM mode */
>> +    bool kvm_mte;
>>       /* PMSAv7 MPU number of supported regions */
>>       uint32_t pmsav7_dregion;
>>       /* PMSAv8 MPU number of supported hyp regions */
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 849e2e21b3..29865609fb 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -39,6 +39,7 @@
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/ghes.h"
>>   #include "target/arm/gtimer.h"
>> +#include "migration/blocker.h"
>>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>       KVM_CAP_LAST_INFO
>> @@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const 
>> uint32_t *cpus_to_try,
>>       if (vmfd < 0) {
>>           goto err;
>>       }
>> +
>> +    /*
>> +     * MTE bits of register id_aa64pfr1 are masked if MTE is
>> +     * not enabled and required to enable before VCPU
>> +     * is created. Hence enable MTE(if supported) before VCPU
>> +     * is created to read unmasked MTE bits.
>> +     */
>> +    if (kvm_arm_mte_supported()) {
>> +        KVMState kvm_state;
>> +
>> +        kvm_state.fd = kvmfd;
>> +        kvm_state.vmfd = vmfd;
>> +        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
>> +    }
>> +
>>       cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>>       if (cpufd < 0) {
>>           goto err;
>> @@ -1793,6 +1809,11 @@ bool kvm_arm_sve_supported(void)
>>       return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
>>   }
>> +bool kvm_arm_mte_supported(void)
>> +{
>> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
>> +}
>> +
>>   QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
>>   uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
>> @@ -2417,3 +2438,41 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, 
>> struct kvm_sw_breakpoint *bp)
>>       }
>>       return 0;
>>   }
>> +
>> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
>> +{
>> +    static bool tried_to_enable;
>> +    static bool succeeded_to_enable;
>> +    Error *mte_migration_blocker = NULL;
>> +    ARMCPU *cpu = ARM_CPU(cpuobj);
>> +    int ret;
>> +
>> +    if (!tried_to_enable) {
>> +        /*
>> +         * MTE on KVM is enabled on a per-VM basis (and retrying 
>> doesn't make
>> +         * sense), and we only want a single migration blocker as well.
>> +         */
>> +        tried_to_enable = true;
>> +
>> +        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
>> +        if (ret) {
>> +            error_setg_errno(errp, -ret, "Failed to enable 
>> KVM_CAP_ARM_MTE");
>> +            return;
>> +        }
>> +
>> +        /* TODO: Add migration support with MTE enabled */
>> +        error_setg(&mte_migration_blocker,
>> +                   "Live migration disabled due to MTE enabled");
>> +        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
>> +            error_free(mte_migration_blocker);
>> +            return;
>> +        }
>> +
>> +        succeeded_to_enable = true;
>> +    }
>> +
>> +    if (succeeded_to_enable) {
>> +        cpu->kvm_mte = true;
>> +    }
>> +}
>> +
> 
> nit: remove ending blank line here.
> 

Sure, thanks.

-- 
Thanks,
Ganapat/GK

