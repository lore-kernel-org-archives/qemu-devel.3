Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54286C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPrW-0006B2-9l; Mon, 11 Aug 2025 06:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPrT-0006An-DI
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:34:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPrM-0003Kf-L4
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:34:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso2888549f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754908468; x=1755513268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Lw9QNqUJGrzicgzTxw+TESKlo9H8Z/mCFgdXJUskwQ=;
 b=s4oKlxMNs/gi6Jvtyw9RkRaVhq0BI+UU8NcSgzzcnKw0n/Ls0PAeGrMC1Lq5j4uBfT
 qQMv+8LDyn3x38FFnHM0Rm+slwRZT9a148B/JdEBJh3K8HR1f5v0sqFikZe90NlDjK20
 U2lA3fiIssgAY5+EGx+evnX97em3oAjGngX1WmF82J6Ow95sbaA/CyFzz7yqu3MW4bBo
 UEH/K8lavA0Tav5JmyB6TsSnsQOZEO41G+odiZ2FBLD/qVvOQwMCO+yqyYV95t0Qd2x1
 CgL8uh3g/JX4DBANy2aFPNu+bXSUbf8qGNjX759JVtXBJGnSuhNU7wzGLBtYxXXLtm4B
 em9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754908468; x=1755513268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Lw9QNqUJGrzicgzTxw+TESKlo9H8Z/mCFgdXJUskwQ=;
 b=M9wasYMf7IDq3JBk1HFtgbR9IOYJkzgEoLLCeC8oOQJwDcvjILekqLbg57wApC1Yfo
 soZTsgy/yCF8FxjStAx9p9ncZTiwo1HRicZ37QwbHatPZe2kBzBGZzyWXjy8Fbhoci9c
 xR2BPbYIk4C5xZZpUuXbTDTYHWKrXAZVyciuMCzv3DkX2GFt1Zy0MZfdgc2Mrudr7e6U
 rnFB4x6v0cpYZ3X0kUDFL69ECIc6EUPjznsZNUU/pXcoKMeUMlxEUv0HSEBERg2i8jYI
 8eNtSzuFBLZnliogy8xoouu4pkC488FolDm5e9rGPIkUJry2mCpQN53+2qBCmjA2YooB
 3J/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/EbiGBwS6a0vm8GxIly47WuTGpqBvuwvOVO+NNcsp+jeE587eke8t+DurAGMNaLgSDFp/HQ7+9rNl@nongnu.org
X-Gm-Message-State: AOJu0YzQmR0Nl7C7BPNoqP6cAQqp+bxcYFOTGhk+R5fTfbrjlLGX51Tv
 1YPCCowGpPX2ZNTFfMpwWCQDOoTK8W3n60lrNGpytRtgSluQ9kloNehOHf424ragjkA=
X-Gm-Gg: ASbGnctLNy1lt8JM3227Ddc/YnKbMB9e1o0bogUAwpNyuRzlc24TL7sTOT1WAYJrJDv
 jgO1TgJNRhn6bUBkttGmmxnXtPyH2qfEN88VzVHsce+GVZUHaI2nPyDlXchWjSPoc34XHQg5jbl
 LJO5ugO1oT2J+ogwuop+qlYWOD0uL2FZOCPduSXCmEL4maRXz69BRI3eXkr0CGkarfRYSjlFGU7
 3GC7JlIEXUUGjsElO2Ui/H3tmQJhpOx80oa3bttq2m2B4x7qODBxx0Mpv42XR2fmU7fDTSCIMDH
 10sQkWO2h0hsAbSkJg0hBuHFmnAYq+0mJc48O9C3aLmvzMfPbgthetlFPR7D9C2UJILyVcwcn2M
 G8nvMyrVYJlJezmmeGC8jfa667GD0WttJAF4kf6afG6iUT9LNbCYgE06AXoIdI6no/w==
X-Google-Smtp-Source: AGHT+IHaCISQ30mfYnoTYeVABYZciJd1BrsIlOkyNm5PZh89+OY4R3FlWLKVxgVS4fK8XFOLvNE5Lw==
X-Received: by 2002:a05:6000:25c3:b0:3b7:7901:b38b with SMTP id
 ffacd0b85a97d-3b8f97c4875mr14022115f8f.8.1754908468389; 
 Mon, 11 Aug 2025 03:34:28 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c48de68sm40362941f8f.67.2025.08.11.03.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 03:34:27 -0700 (PDT)
Message-ID: <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
Date: Mon, 11 Aug 2025 12:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
 <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi,

On 10/8/25 18:59, Tao Tang wrote:
> On 2025/8/7 05:55, Pierrick Bouvier wrote:
>> On 8/6/25 8:11 AM, Tao Tang wrote:
>>> This patch enables the secure command queue, providing a dedicated
>>> interface for secure software to issue commands to the SMMU. Based on
>>> the SMMU_S_CMDQ_BASE configuration, the SMMU now fetches command
>>> entries directly from the Secure PA space so that we need to pass the
>>> memory transaction attributes when reading the command queue.
>>>
>>> This provides a parallel command mechanism to the non-secure world.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>   hw/arm/smmuv3-internal.h |  8 ++++--
>>>   hw/arm/smmuv3.c          | 55 +++++++++++++++++++++++++---------------
>>>   hw/arm/trace-events      |  2 +-
>>>   3 files changed, 41 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>> index 1a8b1cb204..5b2ca00832 100644
>>> --- a/hw/arm/smmuv3-internal.h
>>> +++ b/hw/arm/smmuv3-internal.h
>>> @@ -319,9 +319,13 @@ static inline void queue_cons_incr(SMMUQueue *q)
>>>       q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>>>   }
>>>   -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
>>> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool is_secure)
>>>   {
>>> -    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>> +    if (is_secure) {
>>> +        return FIELD_EX32(s->secure_cr[0], S_CR0, CMDQEN);
>>> +    } else {
>>> +        return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>>> +    }
>>>   }


>> This looks like a reasonable and readable approach to support secure 
>> and non secure accesses.
> 
> Hi Pierrick,
> 
> Thank you so much for taking the time to review and for the very 
> positive feedback.
> 
> I'm very relieved to hear you find the approach "reasonable and 
> readable". I was hoping that explicitly passing the parameter was the 
> right way to avoid issues with global state or code duplication, and 
> your confirmation is the best encouragement I could ask for.

An alternative (also suggested in patch #1) is to use index for banked
registers.

For example we use M_REG_NS with Cortex-M cores (target/arm/cpu-qom.h):

     /* For M profile, some registers are banked secure vs non-secure;
      * these are represented as a 2-element array where the first
      * element is the non-secure copy and the second is the secure copy.
      * When the CPU does not have implement the security extension then
      * only the first element is used.
      * This means that the copy for the current security state can be
      * accessed via env->registerfield[env->v7m.secure] (whether the
      * security extension is implemented or not).
      */
     enum {
         M_REG_NS = 0,
         M_REG_S = 1,
         M_REG_NUM_BANKS = 2,
     };

And generally for address spaces (target/arm/cpu.h):

     typedef enum ARMASIdx {
         ARMASIdx_NS = 0,
         ARMASIdx_S = 1,
         ARMASIdx_TagNS = 2,
         ARMASIdx_TagS = 3,
     } ARMASIdx;

(not sure this one is appropriate here).


