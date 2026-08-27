Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D543C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzTmH-0007cE-H1; Thu, 27 Aug 2026 02:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzTmG-0007bv-8G; Thu, 27 Aug 2026 02:39:56 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzTmE-000750-Fz; Thu, 27 Aug 2026 02:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soANzjJBL5e6nI/UOaAwmMo8nqdR2JdXDAwVBkuomy6mRHzVFvwrseAdqLQFPB4OttgUPRJ90yuoEmLJsFC2u8v9CbNfnBIIwQ9OKJxLK3xuCHM2Ao2hZ1a6d4G6Xp1ZDTsARWx+3Vo1v+8Vd79wjpln1S1wdJnM+Ne+TXjujUdHqsiTjTxXlcsM8d6x1YczKzFlfpnUj6OlaJrR64Zsc0+ONRi3JyxhzTYm66s1q3wr9niFZj65U+iJKwDvNQoi+2vncZWlgR6nslBEsN7X39txFNJGaVVOP37xwr01jJLS0qdKUdLjsCJGolFnqUHdXCNUuT/wehq4yoriALr2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyhVMzMwxBwGbzZ+foeQxLjB3MZdIWqYtLvYr1C134w=;
 b=jgZt34GgmJAFoQUboz/hEw+hXi3XFWay1lL45l5J01AxKxuPFW/PsNks060s860/c7hB2cO8A0DKsSNYyI1U4mXaZ1+EWDDgJrgWX/9VkpEG7Viq8iZrUrn8gmUl3ttw6C+a6qibh5Faif6GAkML6yP0XeCgEUL/1P53FEo/tampYCZut+70cwfB+rZg1IdstvK+sqfVDrDFVFSgrVyq2EduUbhYfQTighy9k745YYNWXmiFKRNsXJpmtxWpn1ZyBnnwngWZmq/lk8vz5GqPPmiNGBoN31Yz3/XZYAXr0EBxV3yRM2CnTYdpwH7ZBhXonaTNA3Yn7XUSL9hDL1s6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyhVMzMwxBwGbzZ+foeQxLjB3MZdIWqYtLvYr1C134w=;
 b=oTq99hYtpNQ80ml5Z/v82HI8zgzX7aDIcamnatmukxF9qZgJZUMzn/eNfE5E+TMdWwfA7kyEE+q9KbPozGq+14oiNAw7SoAG1e490I+kRmj8vzX4x/jhizeTGOpXHSKNMNsaJjM98EfIu3Tjf+O70L022s0rKww6FT1szS8mYuQCZkXm5cis7mSknH2jUE/rYqSnZKDvPqqqnKrnpw4TYt+pmIFZA99SOlEGTB0NIip9IAlxlKD0vu3YD6YobHdK/p6y5FC5jWP1EXWKKJ45aO0FmEPwIk2QKWFaLTP1KdK1e+32ro6/xS2i2pRYtIRC1BtkkQQEelh+ujWLj59YVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by SJ0PR18MB4060.namprd18.prod.outlook.com (2603:10b6:a03:2e4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 06:39:48 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 06:39:48 +0000
Message-ID: <c15422ab-6a58-45b8-8df6-b2f54e0620cf@axiado.com>
Date: Thu, 27 Aug 2026 14:39:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Add Axiado SoC AX3005 and EVB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <a665849f-3b20-4ad3-a35b-02259e882628@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <a665849f-3b20-4ad3-a35b-02259e882628@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0033.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::17) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|SJ0PR18MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: d87b1fe0-8264-4994-7a71-08df0405fd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: mcJSJ/0a0mQT3lN001VHjoRZaC87/0RzUE7hDNSfFEQuq97reJegKZlsEOf6XJ7JBW2kXIBzXeM5MVaeMtQPbzV0+MGS501PUCfuryce9yLaJHwxC6Pgyw7nDkhqfdRRhmmT6LjXCfTl8rojUvQlcCxIOXsAkWfrvRLqVopOxDmYcEpTbjbLXGkm6FyaGIVf8gRpp7K9QmNa01TFEXsfjotqyU3onK1zEBWuDdMJEpqmsmA2fA47yivZ146m4j5vP4/jTO5yWRYwwsGi3rfQW7G0xG7IXL7K6N52+WoZwN76r5YDWDvIukjPd9rB52hs90tcSq3LeOhMhhv6q9LZBDGk6soR2NtGpM3ehdZhqnwoD85K2UesPinINup7E1h+BdjtUZvVPjRfdM71IcC0ync93UG9IsR2uznGDR+Yy5NKpPJ16Gg0QyUwkYDLsTCH/kc/pVzf53RtG3cbrZ8om1gH7hzaPAGWvbjO7VPtaeWn3xGMN9x9LLPf6GOdKF+PL1+vr7HAAvXQ7+tZBpJhviI18ZD1SsX6+3Zhza8v/2qMGCQQT3S1U0gLOrmls2aNJf6HcuO6Xhs4QJCDgUYXc/4xdYT24igCc5PjyKkQUoadL8a4Efz+Nwi94BVyI82J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2xxVWU0MmQxR3RFaUhzT2ZEQVRWWmxxOGJQWFBLc2Zqbk95MjBBc3R2N1Ru?=
 =?utf-8?B?L2FvREJhUlZyTUpiNDJiUnFBY2RpTUh3amYxMllOTERQb2JkY1RVZ0pyRy9U?=
 =?utf-8?B?K3NRZkVOU2NpNzJ2VVdqb1piY0xHTWViM2tYK01OMVk2OFJHYTZiT2Fybnc3?=
 =?utf-8?B?UVlaZnV3UXBmeVFZZWIxbjNBbkdnNUhHcURWZ2Z5Ty9kYWQ0ejFOQkt6UGNB?=
 =?utf-8?B?dEtFUXhiajA0MHVJMmRjSHMvbW40VU9ieGFXQnRWcHJtanFGQ1d4cnAzbnBK?=
 =?utf-8?B?MWYrSkQwcEg1d1hVdTBUV0F1SE5CeXVRSEtEelhiUnZTOWZrMXdubmNZUVpB?=
 =?utf-8?B?YmdpSENoZEZ5Q0tVVlg1dDRxZFFrZmxCekpBck8xUm1hNnpsSTVsYU5PWDNI?=
 =?utf-8?B?ZFVWUnFjRWZWeFdzajMrR0RzY0Nwdk1yeHRBblFiNW9OVVpZOEd5SVpXR3Y2?=
 =?utf-8?B?VER2S3JjdVFOakxINUh3UmpRb1RhT2N2Wk8yRlFpLzlzOElmUXUxQmlIZXlu?=
 =?utf-8?B?WGg1OTZsNjV3SllOUndFY0ZLZ2w0K29TWmczR1FUd09uQmFHN2Rka09CaXM0?=
 =?utf-8?B?ajRoZnJpbUp3bVNWMWJDNFdmYVVQL1VXeHFGWTJGQW9qTHlTenIrMllBbDRU?=
 =?utf-8?B?WktNUFVRR09pRUltNFhzaWtDK0NIbjU4NUpIRldFcmdyalZuMUpCZ0l4SWd6?=
 =?utf-8?B?SWs2NEF1VE5EWmlJcWE1WFVTa2dQZkxlMjBBWHpSYUZNUnhaMnZlQ2dZdDZv?=
 =?utf-8?B?UjJ4UmJVcUFtdk1pNFNwMVgxVUtwbDkvRzRoOHRlY2xDMkluWm4rczA2Tko4?=
 =?utf-8?B?YVhSUmlrN2IvTGxmWkNQNHFzNlc2YmpmQjdQU3VpUDdUQjNOMWwvbVJibUpx?=
 =?utf-8?B?c25aUzhDWDVDcXF4NTMzVVhzcXJIVjUrbkdhSUwxYk1ETlF4MGlTV2Y2ZVNM?=
 =?utf-8?B?OGl5V2RTQlhzc0lhczVXYndEdDFuN1hMRXlOdnEvQ2VuYm5IZHIyTjBwSGtL?=
 =?utf-8?B?NGY3STFrZ3hFMElPOEg0MjJLbkRDOU9BSFVQUDduMXB0SDluM24zcjhMemUz?=
 =?utf-8?B?RG1laGgwelhtank2Uks1MjJ2V1puTUF6WUN4amR6RDBreVRUaWpvNlBnWDgz?=
 =?utf-8?B?b3ZPMDkxVFFvM1UzWHFyRDhhektxM1VCMm11blFOV3Y3U3UxNmJ5QmpUenFE?=
 =?utf-8?B?RnUxazdUR1R6UjJDWnVOaytreFRVUjBDcjJYaWZ2TlZOWXBCb3lHRHlqYmpr?=
 =?utf-8?B?YlpxZ0UzekNMQTRaTytndXpPR3ZNN3B2bUVSU0RlTkUzWDEyYlVTYnY3dzQ4?=
 =?utf-8?B?dFczUDhkNlBKM0NaNUk0MmZRTHUvcHNDREFHZmhHQXFnT0lEdk4ya2FQT3NB?=
 =?utf-8?B?QkF0eWI1MHNTRzZwMG1ya0lzcldrbkpTaFQ2bG5jdi9GQXErWTlIMFF0Tjc1?=
 =?utf-8?B?QkdLWGhnNkpsRGNESnJzcHYxSTVOcnFSSktKQVl4MHhzamdEN042dGRQZjBs?=
 =?utf-8?B?QnNsalJPeDdwU0syYjFibWJNUE5ydkxpdDVCeHF3ZzJpWUFSN01pMjh3dmUy?=
 =?utf-8?B?SjBlNGp0RjdTdTRZRlR3V1NCR05mbllocVlUMVl3UlNFN0xNTUY4Uno3akVR?=
 =?utf-8?B?c3QwL2MycGo5b2tkU3Z6SzF6RGlRd3c4eFVlbUlPK3FhQ0ZHRjNOU0UxcCs1?=
 =?utf-8?B?Y05HWGpIc25LSkJwb2Y2VGFBeWJYYnhYd0pQdmVqNEF4V3V5WnNtbVkrNkhQ?=
 =?utf-8?B?b3h4Y1FGSG80VDdSaldGdmxza1hxQityaXoycFBWVTR3OXB0UEpvT3FISVFP?=
 =?utf-8?B?Q0wzVkFmNmU5b1JTeTFhWnQxOVdmdDZVVXVYcDVtNGtiUTM0cjBxQVVGYjds?=
 =?utf-8?B?eE1NN0UxZ0lLY0kva3F2anhEdTFxTTJHSFIramhKWUFLdXFnVDBaZ1hla0Nx?=
 =?utf-8?B?MWxKZFoxM3JuWEdiRnlWUGVZZmtlWHp2MDVhL3lmYkFSVHAwTm5nZmFUcS9L?=
 =?utf-8?B?c3JqV2tTeFhXMlhzUHpsbGlJWlZ1eVE5a0Z1UThZMUhLQ2JwaG1Jb3RCWGRE?=
 =?utf-8?B?QktQQzZQNnp0cmFwd1k3TmxMZWpRa0NYZ3hZUGxEdTlzUUxLSFZqZk5sNEdG?=
 =?utf-8?B?eWlWUFlFQThGN1kzOVFkQ3FUNFNjL0ozaWxNeUp5SFBEMERra0JwQ2lsQUtn?=
 =?utf-8?B?SVNGOE9qeWI3b05DaDhJZ0l5WUFDOENFQUtjYjJ1MUtjRU1WT2U0RHFndDJN?=
 =?utf-8?B?MUtjTFFDVHNxRjRFQStMbGhQaG93L2ZjazRrWDBYb25UaFhhRTlDV2duVFpR?=
 =?utf-8?B?cjJHRDN6Z1JCUlA0TW8zTmxwMGRpMGdpZ1NTYVFXUnB2UlRjekZ3UT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87b1fe0-8264-4994-7a71-08df0405fd0d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:39:48.0732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwwGM1naUekuw4bwWyftyDrbDF+I1ZZ8o1Duvti9aJeVzVsJVKdB4aGy80Qyqsw+UPqSQfEuBd/yjbhHyWSxaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4060
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi

Philippe Mathieu-Daudé 於 2026/8/26 下午 04:18 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 26/8/26 09:46, Kuan-Jui Chiu wrote:
>> This patchset introduces Axiado SoC AX3005 and evaluation board for 
>> emulation
>> The model for Axiado SoC AX3005 supports
>>    4 Cortex-A53 CPUs
>>    Arm Generic Interrupt Controller v3
>>    9 Cadence UARTs
>>    1 SDHCI controller with PHY
>>    8 Cadence GPIOs
>>
>> Refer Axiado website for more product information
>> https://axiado.com/products/
>>
>> and minor changes for the compatibility with existing AX3000 SoC model
>>
>> Test plan:
>> 1. Verified the machine "ax3005-evb" with following command
>>
>> qemu-system-aarch64 \
>>      -m 2G \
>>      -machine ax3005-evb \
>>      -device loader,file=bl31.bin,addr=0x88300000 \
>>      -device loader,file=tee-raw.bin,addr=0x88400000 \
>>      -device loader,file=u-boot.bin,addr=0x80000000 \
>>      -device loader,file=fitImage,addr=0x80100000 \
>>      -device 
>> loader,file=obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz,addr=0x80B00000 
>> \
>>      -device loader,cpu-num=0,addr=0x88300000 \
>>      -device loader,cpu-num=1,addr=0x88300000 \
>>      -device loader,cpu-num=2,addr=0x88300000 \
>>      -device loader,cpu-num=3,addr=0x88300000 \
>>      -nographic \
>>      -serial null \
>>      -serial null \
>>      -serial null \
>>      -serial mon:stdio \
>>      -drive 
>> if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic,format=raw
>
> Could you add a functional test? See:
>
> $ git grep -l obmc tests
> tests/functional/arm/test_aspeed_anacapa.py
> tests/functional/arm/test_aspeed_ast2500_sdk.py
> tests/functional/arm/test_aspeed_ast2500_sdk_515.py
> tests/functional/arm/test_aspeed_bletchley.py
> tests/functional/arm/test_aspeed_catalina.py
> tests/functional/arm/test_aspeed_gb200nvl_bmc.py
> tests/functional/arm/test_aspeed_palmetto.py
> tests/functional/arm/test_aspeed_romulus.py
> tests/functional/arm/test_aspeed_witherspoon.py
> tests/functional/arm/test_quanta_gsj.py
>
Please allow me to add functional test cases in another patch set 
because we did not release firmware package on our Github for 
downloading yet


