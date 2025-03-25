Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1E2C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 09:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx0UD-0001YW-57; Tue, 25 Mar 2025 05:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx0UB-0001Xm-FG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:22:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx0U7-0005V5-H9
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:22:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so4333903f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742894528; x=1743499328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=71RvBOAOQfE9OhpYm5SKcAiC6VgyqIl/XhKPHqIjpjM=;
 b=UthEJtMsBJR7blmuopcXKM6aWqYJlN3KsQqlMOL1EuGnb0xnwi1zHqZFevIO1bTdyA
 2EjCw7wo40AQEtZXptrHkBRM8TOTGf257Hzklf3GLh8ztiu9JZZiSfh+UPrXPSSTFFAX
 KUZKCt3jTu+8fqtOv3EN7J+X2mV+mafBINzupTflNRefKBtJOR0J/2lBVUuVhu+0qI/J
 hjtdwtHXqh/9L7HGMYpE0oYy7XgDSxyqWhkJF5dZp3SAkj3gPpVtxsQ4z2F+Tb5pvhak
 iIIvtfiYr2h1lRKPCZEGAXI9D7ovrEFQpfnXv6dwMFZNggJZkUv7v4qzHHRGj7jcJV+4
 LqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742894528; x=1743499328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=71RvBOAOQfE9OhpYm5SKcAiC6VgyqIl/XhKPHqIjpjM=;
 b=E0pqcZ7LipoDNys6pTmhlRpML0pmpt1nfEge7WnuhZTfuZvG1DEeSyH0wXGfw6hk0n
 r/0IbAZzXyyaPsjfTP38gjLhcdxChI8I+CeUc9cmQPk5dyDSHA+WXLSPZYwiMUOyqfDO
 Cf9L5GsxUdr5I4kArFcklJ2Jp6nfGpzFV34qmYXkv1qzRUCLGs4fISf9ZYKOZwHnEGsZ
 lQf2jLVQJDlWbiLM814TvfjdNA64flXBwEKxryB6iG1fAaNzDmYqu7267mt0dYB9nMQS
 y448KiR5GALgh/c0lpOPC2h0r3fuWrlXGnPvfjwCk6alktag959APawqR3tlzgbWtZKv
 2GQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi1Aa+7oSXFd06tGUFa4ukKz1prK4b0VCtKuDgfPC3fUfG8M/DDvoKC6opYJup45LhOikM1ne+QddW@nongnu.org
X-Gm-Message-State: AOJu0YwOqeqcItrMp8cl3lnpKmzC5nPfe03j8zPXudF8Sldc9iHafVLx
 U+8RbofrweazlUaupyFEERsx8H1A/1qUj59DKpcG+Jc1PHtklBkutMTUN22bDBo=
X-Gm-Gg: ASbGncs8B04vkzP0U3oTS2UkNOGF49FDwhAqkWsjBRKuPlzUvVLSU+bqiW6cXEYUDME
 Q4PyTzNtVbq1EcCGLfIoNz2fbD6os/Uuq8xfZwNK9znWO4YlM+Q61SjfQYhaJ3JEYf3XSITN32V
 NnfvPWMG6GHUlvORUKX5psmGW0y2FpFUjS9Uhp00h2TOq6qJGkZ3/Soq5Oobe/cN1W28KjA6aEJ
 TMc85EJGka7trFOXuwAHQRr1pxMFJWOsW+H5ycp/zpn9PXRl+Y2Tdys06CDsFJrqOHOZgTEPwhs
 UlCl5/zHOaBr2WStvRk+36q+zBuW+KCCxrOd/QZg9wSdr7yw+46K/wig7Lgawd8+cPOjyrkzCJh
 vxEYkFppVHgir
X-Google-Smtp-Source: AGHT+IFO3zTzJIztdYqhK2y/r4LlVYawe+R2NThRj0xrIgZq3OIzebqoKnh9hrcx8WNvgyuyYo8YwQ==
X-Received: by 2002:a5d:6c64:0:b0:390:f9f9:3e9c with SMTP id
 ffacd0b85a97d-3997f910184mr14486976f8f.25.1742894528576; 
 Tue, 25 Mar 2025 02:22:08 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a345fsm13042133f8f.24.2025.03.25.02.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 02:22:07 -0700 (PDT)
Message-ID: <6fd61c99-c753-40bc-b6a0-8b40e0c3956b@linaro.org>
Date: Tue, 25 Mar 2025 10:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] target/ppc: convert gdbstub to new helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-10-alex.bennee@linaro.org>
 <c99b4b18-2222-4868-9e2d-78305e530663@linaro.org>
 <7a60e516-e224-4766-830d-20e14bba3c8e@linaro.org>
 <f2fc4de2-7235-4c86-8574-2b8d630e5cd6@linaro.org>
 <4ff5ca15-6784-4660-b6f5-9c219d215378@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4ff5ca15-6784-4660-b6f5-9c219d215378@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/3/25 21:49, Pierrick Bouvier wrote:
> On 3/24/25 13:04, Richard Henderson wrote:
>> On 3/24/25 12:29, Pierrick Bouvier wrote:
>>> On 3/24/25 10:39, Richard Henderson wrote:
>>>> On 3/24/25 03:21, Alex Bennée wrote:
>>>>> +    #ifdef TARGET_BIG_ENDIAN
>>>>> +    MemOp end = MO_BE;
>>>>> +    #else
>>>>> +    MemOp end = MO_LE;
>>>>> +    #endif
>>>>> +#endif
>>>>
>>>> That's what MO_TE is for.
>>>>
>>>>> +/*
>>>>> + * Helpers copied from helpers.h just for handling target_ulong 
>>>>> values
>>>>> + * from gdbstub's GByteArray based on what the build config is. This
>>>>> + * will need fixing for single-binary.
>>>>> + */
>>>>> +
>>>>> +#if TARGET_LONG_BITS == 64
>>>>> +#define ldtul_p(addr) ldq_p(addr)
>>>>> +#define gdb_get_regl_value(m, b, v) gdb_get_reg64_value(m, b, v)
>>>>> +#else
>>>>> +#define ldtul_p(addr) ldl_p(addr)
>>>>> +#define gdb_get_regl_value(m, b, v) gdb_get_reg32_value(m, b, v)
>>>>> +#endif
>>>>
>>>> Surely you're not intending to replicate this in any target that can 
>>>> have multiple sizes?
>>>> This is not an improvement.
>>>>
>>>
>>> If I'm correct (and from v1), ppc is the only architecture having 
>>> registers defined with
>>> target_long types.
>>
>> With a quick check, mips, riscv, sparc do as well.
>>
> 
> Right, I should have run the simple grep :)
> So it's better to keep those macros defined in a separate header (out of 
> helpers.h, like helpers-target.h), so we can already start to cleanup 
> some targets, and do the rest of the work for the ones using 
> target_ulong type for later.

See also
https://lore.kernel.org/qemu-devel/f9131f6e-e843-48be-b85f-c341ec198154@linaro.org/
considering s/TARGET_LONG_SIZE/target_info_long_size()/


