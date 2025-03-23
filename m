Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA83C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twNSO-00041m-HN; Sun, 23 Mar 2025 11:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twNSG-0003zF-Oi
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 11:41:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twNSD-0007Mo-7g
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 11:41:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39127512371so2267140f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742744493; x=1743349293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j//WT3tUMHrDI7HP9P/g3xp/xK5prE+gy76j+wGNdVM=;
 b=geuhMt55GQqVAHXEY4LrNNlZD3ZusWf1w4I7PfhE4ew0BCbCBw2BA51aly5T7z9eDR
 9kfWwzzLmIL3iTBCwOVjXoXLVFS9+QVsDDQvPvBfMLMR9HtNupgm1E8fGz1zJKr/y/xs
 c0sNfgDE1Cl6wrTZUcFFNxTKVaX2a3InqWmx0kL8K0NDECzQAQ9snNvgm+/FJzIWLuK5
 J5aVC0jXbfKrtbGz/NtC4BIiWb2UmHLOtj4+fkQw1v1NNOdFkG7H6FDhDMkjCpP6/G3r
 pIkk2ujguW8WW2kbtS7n0c+S8htji9/aKWH5wl0BZX4Wxkdc2/puYi+aCIW1ROKFDp/H
 lI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742744493; x=1743349293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j//WT3tUMHrDI7HP9P/g3xp/xK5prE+gy76j+wGNdVM=;
 b=DwF/TLbQsOGwQqWwmTDQQHqL/QMeufocvdW/0TJv9/Ih+gSpDYNwbmmOwHSCHwYr45
 F86CMw6jiXxM6pPjbZ3uOXNv1E06swRelgy90560zB2Xt0rJZYWG0wKkUZul79ZxENZB
 /ut0IgqyzOA13I1SRT9CgQuu966dT2lwZgREmwn32mfkT47xT1kUyW2HtDUdSZNzsoTr
 XiKghv4CfSwbrvKbTNgd7Fk8zSuCB1HtMFLTjBtM+sTvEXuTjmkDP5+HplMcWtSfF8mb
 Nv8vsjrsbkQuTLzDS+lYwN5yogKHu8DeB92Rt9fwMkvfRlhdGFODkN7DmNd8DO9qGK7J
 1gAA==
X-Gm-Message-State: AOJu0Ywd54D96LxCvWLtxK8rWlEhD181wE8oCdRk4YfYgpUxpI8LQ/8G
 fQRtNeFHLbElP0CO7AJ+lbwW2ZiDmnGE9u1Pg80Jfky1iafc8j3HpEkfJfrm7m8=
X-Gm-Gg: ASbGncuVXTcdxALINiRrKrn9Q7UJoK0E3fbfU8vxOQLietoBQ1YK2QVqRIPoY5V5Vv3
 V2B0qqEv1w61pBOC7fh6y9XlS6f3FVZWejpk1TPlY8G/pXrvc4mZhI+wibwIMd/qFEnA13Hrzv2
 1pGSRT+m88/Wvk0W1+bF9RPhLWSGswVnVhCWehwoW4xi4q7sq5ri3PKQovEg+4zC1aPrRFTyF+C
 6cF5kGQ50qr2RVdxLwWN/NhnuGk3Gw5fglQ+e31zAU7EN63E7DKcJEp3SMTeupALP7tqnZF9BMn
 ScOYey+8yy8UC9xLNHUPfhAIM4d4BTJahXLfWVBU9jBKH4e9PMPj9KSxtVOCMpTj16lCc2tTvoo
 NBJTg7TioI4b7
X-Google-Smtp-Source: AGHT+IF/BqylgXOBvcV+VTVnzR5rNNdoUBGNOXgHZpFmstBC0iMO4fcevnjQX9yPi/sfFxH9eRtYCg==
X-Received: by 2002:a5d:64a5:0:b0:391:22a9:4408 with SMTP id
 ffacd0b85a97d-3997f8fecf8mr11296713f8f.16.1742744493125; 
 Sun, 23 Mar 2025 08:41:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b4ce9sm8179246f8f.53.2025.03.23.08.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 08:41:32 -0700 (PDT)
Message-ID: <8b8bf1e1-ebcb-4779-ab09-c208da910630@linaro.org>
Date: Sun, 23 Mar 2025 16:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
 <87a59eli7m.fsf@draig.linaro.org>
 <3e1c7b60-18cf-4ca6-b853-02203954fc3a@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3e1c7b60-18cf-4ca6-b853-02203954fc3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 21/3/25 18:31, Pierrick Bouvier wrote:
> On 3/21/25 04:46, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>
>>> On 3/19/25 11:22, Alex Bennée wrote:
>>>> The aim of this work is to get rid of the endian aware helpers in
>>>> gdbstub/helpers.h which due to their use of tswap() mean target
>>>> gdbstubs need to be built multiple times. While this series doesn't
>>>> actually build each stub once it introduces a new helper -
>>>> gdb_get_register_value() which takes a MemOp which can describe the
>>>> current endian state of the system. This will be a lot easier to
>>>> dynamically feed from a helper function.
>>>> The most complex example is PPC which has a helper called
>>>> ppc_maybe_bswap_register() which was doing this.
>>>> This is still an RFC so I'm interested in feedback:
>>>>     - is the API sane
>>>>     - can we avoid lots of (uint8_t *) casting?
>>>
>>> Even though the series has a good intent, the fact we make everything
>>> "generic" makes that we lose all guarantees we could get by relying on
>>> static typing, and that we had possibility of mistakes when passing
>>> size (which happened in patch 4 if I'm correct). And explicit casting
>>> comes as a *strong* warning about that.
>>>
>>> By patch 7, I was really feeling it's not a win vs explicit functions
>>> per size.
>>>
>>> If the goal of the series is to get rid of endian aware helpers, well,
>>> this can be fixed in the helpers themselves, without needing to
>>> introduce a "generic" size helper. Maybe we are trying to solve two
>>> different problems here?
>>
>> It did seem natural that if you were defining a MemOp you would use all
>> of it rather than only its endian definition. But you are right we could
>> introduce the same helpers with a bool flag for endianess.
>>
> 
> Defining MemOp and passing is ok, but loosing static typing guarantees 
> is wrong in my opinion. C is already on the weak side regarding typing, 
> we don't need to "void*"ize things more instead of replacing the calls 
> with correct variants.
> 
>> Maybe we should have fully formed mops and just assert in the helper:
>>
>>    gdb_get_reg32(MemOp op, GByteArray *buf, uint32_t val) {
>>        g_assert(op & MO_SIZE == MO_32);
>>        gdb_get_register_value(op, buf, &val);
>>    }
>>
>> I was also trying to avoid over boilerplating the code.
>>
> 
> Adding proper functions definition instead of macros, and eliminating 
> ifdefs is not really boilerplate.

In another thread Richard said for these cases we should use _Generic()
more.

> Adding casts to loosen type system is not a win versus that.

Agreed.

