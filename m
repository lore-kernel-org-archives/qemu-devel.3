Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C90CC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpc98-0006Kz-Hf; Tue, 04 Mar 2025 18:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpc97-0006K1-3f
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:57:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpc95-0007GY-EA
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:57:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bc31227ecso17142995e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 15:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741132674; x=1741737474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPklO6fRinsBjtyrI3dnAKXb8Q6hMHmMD+yVEinlqX4=;
 b=jhALPdyf7h5vCE2zdfsYCJahe0845aLy+S08YTDVyjH3jg8T2vWPL59bn5ET8fxmwv
 pYJ8jxKxpkAtoUbZ0z+zaNYWsoP0A5ghY/7mAxHPh50cb33zgqRMYNeUG3MP9NOeAcTj
 7VD4EfroJ2/DiD7tpjbkX7hZNgyOIxp2J0mRizf0AOThSjIEpCJSViWyq9AupHM6X0rN
 hfBFo5TG1H4WqkgYkAov6wSfLUQuWkjHNlSX5zgaorguYSiWXJcX2doAUzZJDEqerXL6
 W/htUo2dqWF9/EK7MK+jwJtZd+23pemP1uZONsbtnmoydaMjOBRm11BAbGUvQkkIZuR1
 eekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741132674; x=1741737474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPklO6fRinsBjtyrI3dnAKXb8Q6hMHmMD+yVEinlqX4=;
 b=FArkayTuqaSQvuRWlYU+8Kijk/xBmbukqEbOyPdWTNy6Rmpr7OJCbSSF1qg6fTjgGA
 YW/SQDv2njJe8Z65wpiUCVtdaNcanvpYy6iAfzxopkKzkpHY+UZEkWpmXDTetxGiiPT1
 CozAa0sk9C8VYA8mBfb7EeFmAhzrQbERLmW8OUW3CSSK0IiIgPzmkWDtdGIHR/1LQvu/
 5MGAZ0+glfLTIDZxJVdmeG5p6K3oambl9Dgs0mP6ue1VJqeQus99ItdqTxaEA1onAtT3
 vg5EySOKW9rTIH5oleEUUwJY3aDLplL4/0opHE5p99GuTX4oOeJCuYhKR3e1TcxstNUN
 Czug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyfsNZ/jtsqzB2v5EQrXfG9fdyZKQRjubiBz3+g5yXpR4lrNo3dt9fsP/XE0mM51X+xdlCl7/w1UXj@nongnu.org
X-Gm-Message-State: AOJu0YyofCXFoO/bSSkPPRGYr9awPgdVZUwABHxBGJoSurV37HW1vj6V
 AapiafRPAD6Q+VmUPt3NGGBO/knhinZO1H0mNuE/EQH8kU2+hcFKfV3+BauYqAE=
X-Gm-Gg: ASbGncuTSf0D4Dm7ISWPINE3Y7bcRpujdnR4jqDJk1s0tgw+vjn8DBhxJu2tPS0yrd7
 M0m+hSxygRFkZy/Y+LIcYk8MzEB6gnjzNALGo3wiDF/QfPR1wofzoUWWZC+Z+X1tERiXndZB4NL
 3Uv3a97eTdRgfT2I5IqVlMf818cbJa/0b+RqYQ6GrreEbP2sHgj7FXS+b3LE+Mk7K0sVf5Iv9+r
 I5Dzjwz5XR4xFAtOCJX/UGY0UQlu6AM2AFAcR5h6EBuUpoAJRPUG3cnRWI5MkkjINEynuyLpXBF
 4bDlipcV9+hB3mJkj/H8Nm+auLZKBiEkXeTR2pZqjd0ktrcIRoFWD4KrLgAHs2+dVjaRfj1i2kM
 13Jc5EEyvhwBv
X-Google-Smtp-Source: AGHT+IF9sSqmQ86Bud020gb+a5SHS+jIYd5EWiPH+EfEvC5lqeG0SxkxDn/I/EfS+seug8PlPZN/uQ==
X-Received: by 2002:a05:600c:3ba8:b0:43a:ed4d:716c with SMTP id
 5b1f17b1804b1-43bd29b7dadmr3984875e9.22.1741132673683; 
 Tue, 04 Mar 2025 15:57:53 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4293250sm505885e9.16.2025.03.04.15.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 15:57:53 -0800 (PST)
Message-ID: <d18103eb-b07e-4017-8c27-6bc8f5585360@linaro.org>
Date: Wed, 5 Mar 2025 00:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
To: richard.henderson@linaro.org, ltaylorsimpson@gmail.com,
 'Brian Cain' <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sidneym@quicinc.com, 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
 <3329ec67-3bf3-425d-b15c-ba77cd8bcd30@oss.qualcomm.com>
 <014701db8d5a$8a1ad930$9e508b90$@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <014701db8d5a$8a1ad930$9e508b90$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Taylor,

On 5/3/25 00:09, ltaylorsimpson@gmail.com wrote:
> 
> 
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Monday, March 3, 2025 10:24 AM
>> To: qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@linaro.org;
>> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
>>
>>
>> On 2/28/2025 11:28 PM, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    target/hexagon/sys_macros.h |   8 +--
>>>    target/hexagon/op_helper.c  | 104
>> ++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 108 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
>>> index 3c4c3c7aa5..e5dc1ce0ab 100644
>>> --- a/target/hexagon/sys_macros.h
>>> +++ b/target/hexagon/sys_macros.h
>>> @@ -143,11 +143,11 @@
>>>    #define fDCINVIDX(REG)
>>>    #define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do in
>>> qemu */
>>>
>>> -#define fSET_TLB_LOCK()       g_assert_not_reached()
>>> -#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
>>> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
>>> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
>>>
>>> -#define fSET_K0_LOCK()        g_assert_not_reached()
>>> -#define fCLEAR_K0_LOCK()      g_assert_not_reached()
>>> +#define fSET_K0_LOCK()        hex_k0_lock(env);
>>> +#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
>>>
>>>    #define fTLB_IDXMASK(INDEX) \
>>>        ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)-
>>> num_tlbs)) -
>>> 1)) diff --git a/target/hexagon/op_helper.c
>>> b/target/hexagon/op_helper.c index 702c3dd3c6..f3b14fbf58 100644
>>> --- a/target/hexagon/op_helper.c
>>> +++ b/target/hexagon/op_helper.c
>>> @@ -1184,6 +1184,110 @@ void HELPER(modify_ssr)(CPUHexagonState
>> *env, uint32_t new, uint32_t old)
>>>        BQL_LOCK_GUARD();
>>>        hexagon_modify_ssr(env, new, old);
>>>    }
>>> +
>>> +static void hex_k0_lock(CPUHexagonState *env) {
>>> +    BQL_LOCK_GUARD();
>>> +    g_assert((env->k0_lock_count == 0) || (env->k0_lock_count == 1));
>>> +
>>> +    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
> 
> Minor nit - registers should be target_ulong type.

Since Hexagon is only implemented using 32-bit registers, is it worth
using target_ulong? (I'm trying to foresee heterogeneous emulation).

Richard, any thought on this (whether a target implementing only 32
*or* 64 bits should use target_[u]long).

