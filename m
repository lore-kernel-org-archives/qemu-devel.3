Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF956C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticou-0000MM-Iw; Thu, 13 Feb 2025 12:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticoj-0000L5-Ii
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:16:06 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticof-0000NI-FM
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:16:00 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so27638215ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739466953; x=1740071753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WTBB/vDcJh45xA1W/jxGX2kDziq1ZpAFCHIvpkCApvo=;
 b=TGoLguuaMjJcHxE8f2BUw08ZXAUt3CRCtNkwRYBvFLs44NACTh+dWmJnFLwUD/zYZT
 ErohILnrJyCuWJAU3yJAnGSFSz8R7HsyQgoF369Ho8Rfy9APP6PFdgCjjTFu4aUzJPxW
 dcmGBHddeUYrdAB6P58OdtRuC2T067GMBswFLm+3s2qd9KqycD257p9Jp3LkC0+56xC0
 6Hg9ess07KXywVbKDEkgfCA4kHzLqWyLtl2FXUJ9mS/d118aMJXA+Hv8bGoiri+UMlJa
 j/wcdP6SAALndKXDssbOtelP8e52+ZkxYg5qdLEBl+c6ftnKxf2u4cbUAkfbKckz+QTp
 vEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466953; x=1740071753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTBB/vDcJh45xA1W/jxGX2kDziq1ZpAFCHIvpkCApvo=;
 b=hHjpQ3vVrb2XI3+eNntiakS3JadmLEre6I++QevNQrzbjVuG/1ezM9CYqM2xo1FBDi
 +VQx6ViKGXiOWCxOFdZxIIHNIHuiV+CIUoE8aZ9XvEvOzeNhmGRdVa+cQDFAcWFEFGP0
 mzbYLlgfVv5361CqxVXGAzDEcxQJcSk5iLM0aLzRfBTgleu4JF/KB6YekR19u3VDQgAk
 mMMbjSVVVZv/928HFwn52NtPxVQX5hTmv1hDPIWtOcXJq3/jNbnz5robFKdYTOs0dFHZ
 bgbur/3C1VmAwCMsVYtoY+3dCZrH4llRQB5IcAWELBjwJ+fovJJpeNSebBMv3rNdimJT
 XiaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4c329syNLr9e5mjmBqiLugVekpKVVFTPN48T1YfBWv6cLLxtLAX+RbdZsnLcHjYcU/xzDYgtaH4AE@nongnu.org
X-Gm-Message-State: AOJu0Yxv4UF60V8pIEzqPVRl5oAc6KkmCt58rrZoSctXs4G6strIb18S
 QPde0K3Uo8535WwSLiDWHxAx/HNer3sgi7g287DYCCQp29GlwOmv3oxo5yRGngjEUNbiJZdzHJ8
 N
X-Gm-Gg: ASbGnctTTP5FqvmHlsbdL31hV0zqn1Dp95+5vS0aieW3BkhmEMjgNf6+ABw2cVFC672
 wbmhChfV1DhFmBHpX9jZVtNCz4eL80M7E8f+MURfb6V7R+h/BH69CztsDEA8xOtDADmFJ6eEEy8
 Vz1PKphCw8HTkl9oYngY6Rx7zGu53UTSVppM/mGoJPsJWguJUVzFTG26CGEy0g0/4mYsKxkj/GG
 GXjikJcCeENc7bjmRJy3cCWTjsCq2N360jUvMqxC6C2VF2N+Ohj4Sw2EpYSPYEoadxRFKUUuHe1
 2O6DH9muJTUEAI24xqahLPgaXmC81L9/Ishu8DqMw2dSCkgHxaTqHi0=
X-Google-Smtp-Source: AGHT+IE4pq2fkIEnK+/uMTDOWUKBwE9MnldKJAiBOoNG7TN3rbfSUJ/nayx2yl3fcOHkt/gOpZxv6A==
X-Received: by 2002:a05:6a00:6c8f:b0:72d:9b11:1ebb with SMTP id
 d2e1a72fcca58-7322c385000mr15955885b3a.8.1739466953050; 
 Thu, 13 Feb 2025 09:15:53 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324273eac4sm1514322b3a.113.2025.02.13.09.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:15:52 -0800 (PST)
Message-ID: <4863b4e6-8ce3-4f37-b339-837faf759efb@linaro.org>
Date: Thu, 13 Feb 2025 09:15:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tcg: Introduce the 'z' constraint for a hardware zero
 register
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-2-richard.henderson@linaro.org>
 <59d1bd38-2b0f-413a-a6ff-28f8a055dad0@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <59d1bd38-2b0f-413a-a6ff-28f8a055dad0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/13/25 07:45, Philippe Mathieu-Daudé wrote:
> On 12/2/25 04:46, Richard Henderson wrote:
>> For loongarch, mips, riscv and sparc, a zero register is
>> available all the time.  For aarch64, register index 31
>> depends on context: sometimes it is the stack pointer,
>> and sometimes it is the zero register.
>>
>> Introduce a new general-purpose constraint which maps 0
>> to TCG_REG_ZERO, if defined.  This differs from existing
>> constant constraints in that const_arg[*] is recorded as
>> false, indicating that the value is in a register.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg.h            |  3 ++-
>>   tcg/aarch64/tcg-target.h     |  2 ++
>>   tcg/loongarch64/tcg-target.h |  2 ++
>>   tcg/mips/tcg-target.h        |  2 ++
>>   tcg/riscv/tcg-target.h       |  2 ++
>>   tcg/sparc64/tcg-target.h     |  3 ++-
>>   tcg/tcg.c                    | 29 ++++++++++++++++++++++-------
>>   docs/devel/tcg-ops.rst       |  4 +++-
>>   8 files changed, 37 insertions(+), 10 deletions(-)
> 
> 
>> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
>> index 6608a29376..75acb4bd32 100644
>> --- a/docs/devel/tcg-ops.rst
>> +++ b/docs/devel/tcg-ops.rst
>> @@ -927,7 +927,9 @@ operation uses a constant input constraint which does not allow all
>>   constants, it must also accept registers in order to have a fallback.
>>   The constraint '``i``' is defined generically to accept any constant.
>>   The constraint '``r``' is not defined generically, but is consistently
>> -used by each backend to indicate all registers.
>> +used by each backend to indicate all registers.  If ``TCG_REG_ZERO``
>> +is defined by the backend, the constraint '``z``' is defined generically
> 
> and/to?
> 
>> +map 0 to the hardware zero register.

Indeed, this was not grammatical.  Fixed as

... the constraint '``z``' is defined generically
to map constant 0 to the hardware zero register.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks.

r~

