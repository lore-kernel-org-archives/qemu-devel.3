Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633B5C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpcU4-0005Xb-Co; Tue, 04 Mar 2025 19:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpcU0-0005XK-V7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:19:33 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpcTy-0006I3-Du
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:19:32 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390ec7c2d40so4474387f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741133968; x=1741738768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9I2FSK9ReDIWYUmgOCFNccdFCcRUkK2YNp8tSRG7F7g=;
 b=jPU8y2bZlHaHGk3fqOmajqb5IV+9Vl5oAqEFlqTWRpKGQ8vt5ncaEtnVznHx0BG9Nm
 NVsV5UoFeSIWDFzQcE8U06B6mjs48IckJnjT1OxaULIoavoE8HOs6+U3O5YoY0v5t7O5
 M56lVREKXBCrsa40QHTaUUjgy34oN7r36uW1kaELpbxecK7rIf8vD98FfgLR2gjlcG+4
 /yvXvXO2O8f6EG9UFUTEhwy10PVUalIs6d4w9zpNztKbNWC40fL1vt6ajP8ES1CT0/1r
 Dezb3IbtLihIoGRqs/K1FjU0TeLoco1PQK8ubdrELcaqmZaiFsKIzfZN3Qjb5U/6soN3
 eCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741133968; x=1741738768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9I2FSK9ReDIWYUmgOCFNccdFCcRUkK2YNp8tSRG7F7g=;
 b=RI+GHNEvi6zoJftskn0sYfZpMv2C1O92Va5wH1zsiAX7l12q0RdYCiO3+9HKJuCbRC
 HNT43gUaSe3LJdTPnTBBmAJsafhYa4ZOyhXctrVves7w3MfSehTrT96/ybDn28MfaqBU
 4AXzpAj6vZh0MioMI/CEBesvGqmw+RnsB/cGNJkY+HsayrhLVk1h2fxtK/jZAosW7frp
 3AlTTe9r3pL6G5xNRe+/ktx/c8MjGlD3KtbprbbP8uRaIvMPBr4ZI3Rr9L2C9Zwg7PKB
 0nsoLhq+OVFpo3rywS2CkMJvfsyeBDFGuZj0nzl+oOxs6DNJYQ8Y91nbbzWJl/bvFdTC
 sv1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvC1AEh55af+NEsUnt4Mu1C1HiBNp5kr66J18opcKKTOuLVwe3swmYQedttUBUtPG9Jv7ZpGAq83w8@nongnu.org
X-Gm-Message-State: AOJu0Yw4py9uCxN1v4l4nvLlT03OfSKP9xQ1Ec/j9Wzx49w2kTvhOWKz
 UkyDVqThaPev+Vkd2n7wdNMoB/K3TnCyUdHJgnEOmp82Tcjxn7A36UmQvZMM8Mw=
X-Gm-Gg: ASbGncu3aRs6hBnPZNcOTkaPVSnBaye9ZYwYQxrlebeZGBmCfKOc8h2uUacAOvFPtsu
 UPSZJs6XujrUv++CNFwEWyeIgpvFH2DzjEff0sDB9ZK1RNrRPhjZfnbJJq1WJ+g+dYDnTSR8QKy
 wuyzhLs+ZIqA1cv3SXoy3lN5/O5dBLgmEL6dlf+LHofey0k/cpyUxkZFHcVO/7Hzlz7eUVruEOS
 HeD3kAa+GalfJ89Wx6r71sIw7CAV/4oH+paf+o2vjh1F658rXa816zkJ/kex2hV+QDkNV3uNH0H
 JANb73gQ6Y4xI6GWaGM+Fyw2k+S8zBHbZ1TBQjGtWT0r3FmGWKe6Ud5abusIvdMicStxt3JsmfD
 4bDFfElnDU9od
X-Google-Smtp-Source: AGHT+IEnLHknCh+sVnKle+XXaGUDw1/ygstWvupHA0gVRTWIMupbO9FlIjVALLz1Jr0OmikNGqTXrw==
X-Received: by 2002:a05:6000:2b0a:b0:391:5f:fa0e with SMTP id
 ffacd0b85a97d-3911f7523d9mr348490f8f.30.1741133967233; 
 Tue, 04 Mar 2025 16:19:27 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795962sm19712741f8f.13.2025.03.04.16.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 16:19:26 -0800 (PST)
Message-ID: <a9a4ca6e-8908-4360-a44d-c688bb51b134@linaro.org>
Date: Wed, 5 Mar 2025 01:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
To: ltaylorsimpson@gmail.com, richard.henderson@linaro.org,
 'Brian Cain' <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sidneym@quicinc.com, 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
 <3329ec67-3bf3-425d-b15c-ba77cd8bcd30@oss.qualcomm.com>
 <014701db8d5a$8a1ad930$9e508b90$@gmail.com>
 <d18103eb-b07e-4017-8c27-6bc8f5585360@linaro.org>
 <016101db8d62$5644ea30$02cebe90$@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <016101db8d62$5644ea30$02cebe90$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 5/3/25 01:05, ltaylorsimpson@gmail.com wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Tuesday, March 4, 2025 5:58 PM
>> To: richard.henderson@linaro.org; ltaylorsimpson@gmail.com; 'Brian Cain'
>> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
>> Cc: quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
>> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
>> <bcain@quicinc.com>
>> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
>>
>> Hi Taylor,
>>
>> On 5/3/25 00:09, ltaylorsimpson@gmail.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> Sent: Monday, March 3, 2025 10:24 AM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: richard.henderson@linaro.org; philmd@linaro.org;
>>>> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>>>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>>>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>>>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>>>> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
>>>>
>>>>
>>>> On 2/28/2025 11:28 PM, Brian Cain wrote:
>>>>> From: Brian Cain <bcain@quicinc.com>
>>>>>
>>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>>> ---
>>>>>     target/hexagon/sys_macros.h |   8 +--
>>>>>     target/hexagon/op_helper.c  | 104
>>>> ++++++++++++++++++++++++++++++++++++
>>>>>     2 files changed, 108 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/target/hexagon/sys_macros.h
>>>>> b/target/hexagon/sys_macros.h index 3c4c3c7aa5..e5dc1ce0ab 100644
>>>>> --- a/target/hexagon/sys_macros.h
>>>>> +++ b/target/hexagon/sys_macros.h
>>>>> @@ -143,11 +143,11 @@
>>>>>     #define fDCINVIDX(REG)
>>>>>     #define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do
>>>>> in qemu */
>>>>>
>>>>> -#define fSET_TLB_LOCK()       g_assert_not_reached()
>>>>> -#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
>>>>> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
>>>>> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
>>>>>
>>>>> -#define fSET_K0_LOCK()        g_assert_not_reached()
>>>>> -#define fCLEAR_K0_LOCK()      g_assert_not_reached()
>>>>> +#define fSET_K0_LOCK()        hex_k0_lock(env);
>>>>> +#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
>>>>>
>>>>>     #define fTLB_IDXMASK(INDEX) \
>>>>>         ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)-
>>>>> num_tlbs)) -
>>>>> 1)) diff --git a/target/hexagon/op_helper.c
>>>>> b/target/hexagon/op_helper.c index 702c3dd3c6..f3b14fbf58 100644
>>>>> --- a/target/hexagon/op_helper.c
>>>>> +++ b/target/hexagon/op_helper.c
>>>>> @@ -1184,6 +1184,110 @@ void HELPER(modify_ssr)(CPUHexagonState
>>>> *env, uint32_t new, uint32_t old)
>>>>>         BQL_LOCK_GUARD();
>>>>>         hexagon_modify_ssr(env, new, old);
>>>>>     }
>>>>> +
>>>>> +static void hex_k0_lock(CPUHexagonState *env) {
>>>>> +    BQL_LOCK_GUARD();
>>>>> +    g_assert((env->k0_lock_count == 0) || (env->k0_lock_count ==
>>>>> +1));
>>>>> +
>>>>> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
>>>
>>> Minor nit - registers should be target_ulong type.
>>
>> Since Hexagon is only implemented using 32-bit registers, is it worth using
>> target_ulong? (I'm trying to foresee heterogeneous emulation).
>>
>> Richard, any thought on this (whether a target implementing only 32
>> *or* 64 bits should use target_[u]long).
> 
> It's just a hedge against the future in case Qualcomm ever builds a 64-bit Hexagon.

If there are plan for such future, then this is fine.
We are worried by maintenance burden, see for microblaze:
https://lore.kernel.org/qemu-devel/ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org/


