Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58967C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twlf8-000460-44; Mon, 24 Mar 2025 13:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlf3-00043I-L8
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:32:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlf1-0007rh-P1
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:32:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223fd89d036so92054985ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742837546; x=1743442346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BCypPtu2b1jTGaBPJHeak+aewkv2hDUC1OErX8ebgNo=;
 b=Oktu0yb1g1Hql4bT94vUKlGZJYRGiV5ZuwHuCGMyvS3us2DpiVBgTOJoHAiwqZaLKr
 2ZRV0fqRJQGhHXqxkATyUQdwEYgoXX0++HcpJzw6FrOCdKrLqMqv0XkiYwyD+aVFopkV
 kuGTzWmu5tbdR7mYqB7VjgxknvmSKFV/nquEBh+I2KZyqkov/jyal9IQZfJKrQvQGAjQ
 NTX4iYkAooNYVf+JG5YkuXc06nqF0mOQwwfaz1o7CbLU6wck2vhEQYLE3krL0oHOpZLO
 Bmrc/5hEyrJi14hY1AcG372W3UV+f7OkFk2YBst0SEMuqkZdZ/05qwUk5+AK/Cek5KNq
 irZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742837546; x=1743442346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BCypPtu2b1jTGaBPJHeak+aewkv2hDUC1OErX8ebgNo=;
 b=Tqhxarem8ii7Yr9Mqu8LfrfRRKglwRzquhofd1cPyBwJa6UZUH/CrD5M5KQ9EuWmnQ
 hQTDOfoSxo8pV5jIKxF1LiHPCUTwpjmoqw2Ml4t+roMzRE2U80PdySYmqpzfWXnbVBtg
 HjTB8mEtwp6GbrORn7EPRiWlX0U7L3Y4CZsjTpd7dfuvtGaNWvCVjge6ZufHg23i3MIf
 y+cX3o3fGZVrAet8dER7/vYuShfeFF2Oyjr9hGhrS5GnzqPQunWdZj/kYaBIU23IHcnu
 ogtrlebyDSWXurd33ra3Xaw+yuh7CbCGGQzidXqeFghs5p7OG/SW59UtduHWlIS580iL
 GceA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZPLdhk6rAmZXURXvEu+knLtEm5g4V6O43un3nBAKGRW1y7HuGXqhfUG5bqsL+o65rr4MGtXaFr6Hi@nongnu.org
X-Gm-Message-State: AOJu0Ywo6NjE7Y0kmu/4a5EeVlhOuOopaqVcRElDWhhLc7bnglOc+xvj
 uXraNQtuUQuX+eGfNMnw8BZcz2SM/mMZGnOgzqbIcs+b66YcdoswCI4ZwnASUk4=
X-Gm-Gg: ASbGncvi3/sLuwSIlv1GNDWCMzkCmOJRtN0ZDAnqIKNd93FiVxFQ0H7rcg+A+UH9Te/
 38dfBDRzEwmlQu0NnUgX/PmOqg/GVm3RFJAQhvPC2xmWA/9c7ienSsgAN9J4jU+jXfWieHb6pef
 h/wsCNKkGClRBA8Ec6CyjmRTHPyi2cef0SUqqpAPuIOVeBkD8ajz34i0EC/bLpzPsBEIoVGVnVY
 W8JGPoj4jGuSGkhrcH137VjqXM1KFZBns6+5jBEMvpSxocAT778GyNsA3wbn560KCsgpWIxjj4w
 p0d1WEm6bBMBXY5BnMep/b613v33DwmH7e4CnmM6LohZw1TVstpmMyFys+qJnhIHvfnmit8Pp3m
 4wnOL86Yq
X-Google-Smtp-Source: AGHT+IEZNr4rsvdjR/7bHY7A0T2GFLXaISWVT/81Uc5d0JkyTEh8hn5QjGdrXZrHt44D7sVlULbrwQ==
X-Received: by 2002:a05:6a20:d81b:b0:1f5:93cd:59b5 with SMTP id
 adf61e73a8af0-1fe43327edbmr24562094637.28.1742837545984; 
 Mon, 24 Mar 2025 10:32:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a27db2ebsm7500466a12.5.2025.03.24.10.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 10:32:25 -0700 (PDT)
Message-ID: <08ab6ffc-068f-477d-8cea-ab0f8eae877f@linaro.org>
Date: Mon, 24 Mar 2025 10:32:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] gdbstub: introduce target independent gdb
 register helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324102142.67022-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/24/25 03:21, Alex Bennée wrote:
> The current helper.h functions rely on hard coded assumptions about
> target endianess to use the tswap macros. We also end up double
> swapping a bunch of values if the target can run in multiple endianess
> modes. Avoid this by getting the target to pass the endianess and size
> via a MemOp and fixing up appropriately.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - use unsigned consistently
>    - fix some rouge whitespace
>    - add typed reg32/64 wrappers
>    - pass void * to underlying helper to avoid casting
> ---
>   include/gdbstub/registers.h | 55 +++++++++++++++++++++++++++++++++++++
>   gdbstub/gdbstub.c           | 23 ++++++++++++++++
>   2 files changed, 78 insertions(+)
>   create mode 100644 include/gdbstub/registers.h
> 
> diff --git a/include/gdbstub/registers.h b/include/gdbstub/registers.h
> new file mode 100644
> index 0000000000..2220f58efe
> --- /dev/null
> +++ b/include/gdbstub/registers.h
> @@ -0,0 +1,55 @@
> +/*
> + * GDB Common Register Helpers
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef GDB_REGISTERS_H
> +#define GDB_REGISTERS_H
> +
> +#include "exec/memop.h"
> +
> +/**
> + * gdb_get_register_value() - get register value for gdb
> + * mo: size and endian MemOp
> + * buf: GByteArray to store in target order
> + * val: pointer to value in host order
> + *
> + * This replaces the previous legacy read functions with a single
> + * function to handle all sizes. Passing @mo allows the target mode to
> + * be taken into account and avoids using hard coded tswap() macros.
> + *
> + * There are wrapper functions for the common sizes you can use to
> + * keep type checking.
> + *
> + * Returns the number of bytes written to the array.
> + */
> +int gdb_get_register_value(MemOp op, GByteArray *buf, void *val);
> +
> +/**
> + * gdb_get_reg32_value() - type checked wrapper for gdb_get_register_value()
> + * mo: size and endian MemOp
> + * buf: GByteArray to store in target order
> + * val: pointer to uint32_t value in host order
> + */
> +static inline int gdb_get_reg32_value(MemOp op, GByteArray *buf, uint32_t *val) {
> +    g_assert((op & MO_SIZE) == MO_32);
> +    return gdb_get_register_value(op, buf, val);
> +}

Passing the value by address is crazy.

> @@ -551,6 +553,27 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>       return 0;
>   }
>   
> +/*
> + * Target helper function to read value into GByteArray, target
> + * supplies the size and target endianess via the MemOp.
> + */
> +int gdb_get_register_value(MemOp op, GByteArray *buf, void *val)
> +{
> +    unsigned bytes = memop_size(op);
> +
> +    if (op & MO_BSWAP) {
> +        uint8_t *ptr = &((uint8_t *) val)[bytes - 1];
> +        for (unsigned i = bytes; i > 0; i--) {
> +            g_byte_array_append(buf, ptr--, 1);
> +        };

I think you're still wed to this supposedly generic way to handle values, and this method 
of bswap is really silly.

Better, I think is

int gdb_get_reg32_value(MemOp endian, GByteArray *buf, uint32_t val)
{
     /* We only expect MO_BE or MO_LE, one of which is 0 depending on host. */
     if (endian) {
         assert(endian == MO_BSWAP);
         val = bswap32(val);
     }

     g_byte_array_append(buf, &val, sizeof(val));
     return sizeof(val);
}


I'll also mention that the return value is now mostly useless: I think you should just 
rely on buf->len.  This is something that we could have cleaned up when converting from 
uint8_t *buf to GByteArray in the first place.  But changing the interface of all of the 
gdb_read_register hooks is a larger job.


r~

