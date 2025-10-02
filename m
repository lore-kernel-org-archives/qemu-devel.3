Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1467CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 18:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4O8S-0003WX-2I; Thu, 02 Oct 2025 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4O8P-0003W3-8o
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:34:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4O8G-0007PS-Gt
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:34:31 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2698e4795ebso12746835ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759430055; x=1760034855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R2OrWvVwSyAx9ZR0t0UtAlR/gYZrPLCJteIN7EHuO2o=;
 b=wJymw6RAZEdHnzWZ8v/I4IK33jBD23OQKaXg/85IRwlOVp6hMkZMZjRCnkoYK46FRq
 kIrvISdVS+uXJVEP/yV9zoJJKQTOu1HFbzgA8EushqfICtZPrrd+C3Lk89rHCVYWguwC
 9h1Dvid6T3p3tZLyTu3zbPC4eXmZEtjcAec/bIKZbZri5iDqxJ/4gG4MFAoOAmGq/86I
 Ba0/lzq8yO6yM1xk1y4NQNNCb1rwkQY02cIitBoNfMWToYkFQApwgXEsewWc5IPhnDm9
 FxsKhQYQt11Y3kw77NviMeICg+1D7N48v2iBQMBy5fYGqwiRJWoXlmRJ1FB705QDMFVY
 nsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759430055; x=1760034855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R2OrWvVwSyAx9ZR0t0UtAlR/gYZrPLCJteIN7EHuO2o=;
 b=oU5Fd5Zxbc1WEX3oUZsfMWILs+5O5wfUnThorMe0EbqmulNzGJpoBHLgk+14iTHBXv
 bt/WGcKOtQ4LPqLnXMt41BluCyeTXUau8QHpAovBDq0lu2Dn/9YHlG67HVfL/WQTfuMS
 9+NBNTQXnUwSPRcDd02lIjT2FqbbCUHv1QB3Uvl5xzuOf3tZYcsr8x4M7SFbeNfu/2yk
 ytO+0yoBly0+dP8iHC+mMPVVRHvsPvgNWestfaYv9MxOHNDhUH1igduT+dY2UtKS2/gG
 56JmO5o2n3GHDaGhvfpjU5bu+Eq/zX8u/MCe4PUvX+3GA5X2G5B861Qdo5Qz6zrZxrkm
 f8Pw==
X-Gm-Message-State: AOJu0Ywr923zMmcNJyyQmwcijDMXm8fZkwJ8P4dldkk2lVddkAppb5+P
 TqHmlCFj7vssAbWF+wW9mW+O6zHBuUuwda7nXQzqQrZgvn0KytoWSwF0aUJ97sPTVr4=
X-Gm-Gg: ASbGncunbx/rfmXvRxyMG2FOVMTHUvSdshKyN+mvFeMiOzN0Syk70+gVRLL4QodbHoB
 ZKXd1UFjlut9ERKdqyL44EiCLrWs4H/4ojj7+LJzCtFF2q6gjvLOetDzv3qlNWxZjcpi4UmbtTO
 rtnvDt74YdwgJSzFgtAp37S9WrljWYo1B2i1r9G5qvDoqD4JxNMcVcKqzYVm62MEEY0clVKeff0
 QRTz7qJkmK0EDG30guI3uGWKBwbzs26cDBu7MV2HyiZN6Azo3eStjcnNBx4Om3PL7ZOMC4E6f1H
 jNRZg/4hN6ZhY1ornqdYNCyIV1VUfqnpVQWdVBEyVUF2uE9Bato8K9AzyFpWyHnQMr1m/4WnOJ8
 8ra+ThhlQVhaHB4YScyo3WPMK3GoOEioLVoHUvCUeZzL4+gQTmnQSspHB6ogKFxc=
X-Google-Smtp-Source: AGHT+IFr47xBb8G+aTfuKXATE9ZeJH96GMlrVwxfxAEwclIykjKr8fpE0hNXZjX7Y/ZmQ7jGWP0skQ==
X-Received: by 2002:a17:902:e78e:b0:278:bfae:3244 with SMTP id
 d9443c01a7336-28e9a6e4967mr2828085ad.54.1759430054943; 
 Thu, 02 Oct 2025 11:34:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d24aesm27627575ad.118.2025.10.02.11.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 11:34:14 -0700 (PDT)
Message-ID: <6d0f87e5-a46a-4596-9b04-97b88203358b@linaro.org>
Date: Thu, 2 Oct 2025 11:34:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/33] target/riscv: Fix size of mhartid
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-4-anjo@rev.ng>
 <ed12dc41-afcb-410b-91dd-73ce4c958b02@linaro.org>
 <o4orrvxjkhwz3r2q4dotnkpffwm2deamlgvffnxk26z622yfgo@fksfmpmm35ef>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <o4orrvxjkhwz3r2q4dotnkpffwm2deamlgvffnxk26z622yfgo@fksfmpmm35ef>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 1:28 AM, Anton Johansson wrote:
> On 01/10/25, Philippe Mathieu-Daudé wrote:
>> On 1/10/25 09:32, Anton Johansson wrote:
>>> and update formatting in log.
>>>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>    target/riscv/cpu.h         | 2 +-
>>>    target/riscv/cpu_helper.c  | 2 +-
>>>    target/riscv/machine.c     | 2 +-
>>>    target/riscv/tcg/tcg-cpu.c | 2 +-
>>>    4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index 736e4f6daa..3235108112 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -279,7 +279,7 @@ struct CPUArchState {
>>>        target_ulong geilen;
>>>        uint64_t resetvec;
>>> -    target_ulong mhartid;
>>> +    uint64_t mhartid;
>>>        /*
>>>         * For RV32 this is 32-bit mstatus and 32-bit mstatush.
>>>         * For RV64 this is a 64-bit mstatus.
>>
>>
>>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>>> index 99e46c3136..328fb674e1 100644
>>> --- a/target/riscv/machine.c
>>> +++ b/target/riscv/machine.c
>>> @@ -425,7 +425,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>>            VMSTATE_UINTTL(env.priv, RISCVCPU),
>>>            VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
>>>            VMSTATE_UINT64(env.resetvec, RISCVCPU),
>>> -        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
>>> +        VMSTATE_UINT64(env.mhartid, RISCVCPU),
>>
>> The problem is you break the migration stream again. Maybe simpler to
>> just squash with previous patch?
>>
>> Thay said, IIUC mhartid is only set once in riscv_hart_realize().
>> I suspect it is pointless to migrate it.
> 
> Right, wrt the other vmstate changes I only bumped the version on first
> modification.  Maybe it makes more sense to group changes based on what
> vmstate they touch?  If excessive version bumping is a problem that is.

As long as it's bumped once in the series, I think it's acceptable.
No one will try to bisect that for migration.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


