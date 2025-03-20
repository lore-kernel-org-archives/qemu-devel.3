Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EE5C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvAH6-0003Bu-Mr; Thu, 20 Mar 2025 03:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAGz-00037Y-4d
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:25:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAGw-0002SR-15
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:25:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso3791865e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742455495; x=1743060295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OfAuJYtA3gt8CE28/QLl0zbRSj4IcfSgyPCV7JDaP3o=;
 b=T+j91h5OZcTvqN7oBgMDVyzmrOeeenu/28z8XNENrMPa0YvMc+EoCHBSE3qKDAg6wU
 sw/N+RvRi1VRutu+Gzeu/p+38NJElKELohnlOa4XKcjK3XBDghf12flMO5s0eoRspnLR
 dyTlJOgqDkkasRck5bN9Jl9RVjCUNPwiH+ACG+weTUJCVJkv1T5glgcUPydvYwdJy8or
 sp4Hzb7QMYCuJvICmJjyotm1y7H25+WIC5j5mOK2MbC3V4DRYntmR7uIyk7y0lN5zOiM
 a7q9DnV+pb/ynwM3Cim8KEtyV6ZktSInHQ7jKRLCSMGVxjDTADEaFBjilQrXPAXirlTH
 N9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742455495; x=1743060295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OfAuJYtA3gt8CE28/QLl0zbRSj4IcfSgyPCV7JDaP3o=;
 b=CVjhw66YYeQJD2P+W+ajkg7F7EaWZMle1XDuGcPgi7NUI3caNZy5arMzTE1x5Sqna/
 DQUAP93IXRNstLdZw6pmI4XK8+NhDUTyxnzVr7iAlahiTGtemBCFwbEDnPGPOcQS0SFF
 u+hwwDS0umuD0YJKix9doGemX5UJr4TEUNNj+nhGVTNt+0PacHNbO/tyjxetOhB4tI6t
 Sj25V2Mh1pFqtzFsF75qyYw5srD9Ibl42zfjqXDVI9z6LMHsXGRThUXaKirHBfsEHl7i
 t0jGbGBZe7u4/oLW+jC1Y8ak7vsarc9gJCmZy0WcXdOlfTJ8HzttPFX3bA7HAO/PDy0s
 rY/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWLXspnrdf6LrHJgmq3rLwboy0fICdDStQSBrACIbjDKXRJuZbYvkty0Bmncqxk/1gYKFaqyiHZoFS@nongnu.org
X-Gm-Message-State: AOJu0Yw/q9OozQapV583DA/A49uOQEp1GQlrUf5dN5G02qbbkDKYbzV/
 W5TprBRyP0VU2pyWKfUJj1pdAKhoxIoFkLUvlltn2Pk63KXBMnyzCsyrD2shc18=
X-Gm-Gg: ASbGnct/FPZGFIfeVqXruRKUrKUNLeYlCfl/kkDcY+gRgggTV6AKMzAnHwE9cp2IUxa
 JTd6FlQgx9UAGDVckGNK3v3blCeRlawVDNFMm30qGrQ3w4Nwa7auMcJQ80FMqMuKKr5TV8o/Wrg
 FCAICDIRn1BPV2EDHpVQMzQPYbvDuDgGmTe3oAf/7Gi0UR+vtV2BL+mq8POZoyoDTnQyNMJGyZ3
 GtgquZ14YYt7RIA3RZPi76kj+meNEXOEb3sKkohVgBI+3TI/oVJ5JK486zQSDO6Wx52+AFtesnA
 eGZyJA1CBdkQ7vnGEmIfxQoF+HlSqm4mEKiKy1ch4gzbH1CsW0kF8/en/jVOX/QpC33tzS4kQzv
 sZYHzNxx3ZPwt
X-Google-Smtp-Source: AGHT+IGllMEfpF+aiZg+sVrY/WHZ+kuxHj2Mg5kkRDq2lm97gIt7Jbowg3G27DoK9OUMMT0oIuc1xA==
X-Received: by 2002:a5d:47c9:0:b0:391:3f4f:a17f with SMTP id
 ffacd0b85a97d-399795d8a4cmr1817785f8f.42.1742455494923; 
 Thu, 20 Mar 2025 00:24:54 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cdafsm23136118f8f.62.2025.03.20.00.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:24:54 -0700 (PDT)
Message-ID: <e54c91c2-6035-4259-9557-16d99c844ff7@linaro.org>
Date: Thu, 20 Mar 2025 08:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] gdbstub: introduce target independent gdb register
 helper
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
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
 <20250319182255.3096731-3-alex.bennee@linaro.org>
 <d3ea5401-866c-40a0-9ccc-6c681b760535@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d3ea5401-866c-40a0-9ccc-6c681b760535@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 20/3/25 07:19, Akihiko Odaki wrote:
> On 2025/03/20 3:22, Alex Bennée wrote:
>> The current helper.h functions rely on hard coded assumptions about
>> target endianess to use the tswap macros. We also end up double
>> swapping a bunch of values if the target can run in multiple endianess
>> modes. Avoid this by getting the target to pass the endianess and size
>> via a MemOp and fixing up appropriately.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> The overall idea looks good to me. I have a few nitpicks:
> 
>> ---
>>   include/gdbstub/registers.h | 30 ++++++++++++++++++++++++++++++
>>   gdbstub/gdbstub.c           | 22 ++++++++++++++++++++++
>>   2 files changed, 52 insertions(+)
>>   create mode 100644 include/gdbstub/registers.h
>>
>> diff --git a/include/gdbstub/registers.h b/include/gdbstub/registers.h
>> new file mode 100644
>> index 0000000000..4abc7a6ae7
>> --- /dev/null
>> +++ b/include/gdbstub/registers.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * GDB Common Register Helpers
>> + *
>> + * Copyright (c) 2025 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef GDB_REGISTERS_H
>> +#define GDB_REGISTERS_H
>> +
>> +#include "exec/memop.h"
>> +
>> +/**
>> + * gdb_get_register_value() - get register value for gdb
>> + * mo: size and endian MemOp
>> + * buf: GByteArray to store in target order
>> + * val: pointer to value in host order
>> + *
>> + * This replaces the previous legacy read functions with a single
>> + * function to handle all sizes. Passing @mo allows the target mode to
>> + * be taken into account and avoids using hard coded tswap() macros.
>> + *
>> + * Returns the number of bytes written to the array.
>> + */
>> +int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val);
>> +
>> +#endif /* GDB_REGISTERS_H */
>> +
>> +
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 282e13e163..3d7b1028e4 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -32,6 +32,7 @@
>>   #include "exec/gdbstub.h"
>>   #include "gdbstub/commands.h"
>>   #include "gdbstub/syscalls.h"
>> +#include "gdbstub/registers.h"
>>   #ifdef CONFIG_USER_ONLY
>>   #include "accel/tcg/vcpu-state.h"
>>   #include "gdbstub/user.h"
>> @@ -45,6 +46,7 @@
>>   #include "system/runstate.h"
>>   #include "exec/replay-core.h"
>>   #include "exec/hwaddr.h"
>> +#include "exec/memop.h"
>>   #include "internals.h"
>> @@ -551,6 +553,26 @@ static int gdb_write_register(CPUState *cpu, 
>> uint8_t *mem_buf, int reg)
>>       return 0;
>>   }
>> +/*
>> + * Target helper function to read value into GByteArray, target
>> + * supplies the size and target endianess via the MemOp.
>> + */
>> +int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val)
>> +{
>> +    size_t bytes = memop_size(op);
>> +
>> +    if (op & MO_BSWAP) {
>> +        for ( int i = bytes ; i > 0; i--) {
> 
> memop_size() returns unsigned, but bytes is size_t and i is int, and 
> this function returns int. Let's keep them consistent.

I wasn't sure why this method returns any information at all, but
apparently the next patch shows some uses. Indeed as Akihiko pointed,
if we return something, let it be unsigned (possibly size_t).

