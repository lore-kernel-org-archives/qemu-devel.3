Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD51C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 08:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyR5z-0005NH-6V; Sat, 29 Mar 2025 03:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tyR5x-0005M0-H1
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 03:59:09 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tyR5u-0004xb-2Z
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 03:59:09 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso6048853a91.1
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1743235144; x=1743839944;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d2n7uv7yCb+ECReJ1/h/zEJGUm8CAaDvIV3TsPVl3VU=;
 b=EWuMFoHkTUXRsNSJV2n1bYJ/I9vcPTJKyhuH9A8JbFcjwXNcg98FEjxqkR4Adjb0gY
 pPxTsvIofP5qhuvfo+CjNVv/lHd99TPhUfBldbTJrD+ok/lup1WSAHhAzo+o2tCPrSZ3
 IjcP4yFBGTNuN+n8NAMYmgTj02moDYxcAfWTlsicjqPqMlyDWy/uV/LZo95Fbms+FNa2
 ZG3o+CVD1BAzZFxbOwpCN9L7/6rHOisBqAWsbruyvhxQnglreeEV+M9XCGAAdU69bFhV
 GLS5pWlcXFDSElN0zh8bNbHolrTKoWmqVpdMJoo+pOruukVfXrjulIW2q37+UKfsqu9q
 zlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743235144; x=1743839944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d2n7uv7yCb+ECReJ1/h/zEJGUm8CAaDvIV3TsPVl3VU=;
 b=fHHETLH/2PpibUdN8WXcB37RLkT42iz3MIf1aOq3QxxyQaMmM10DjYpMOrS99hCFXa
 IM+Mlh3kCIl6CtzXN+eJGhz366Gpx5E6PQ4t/xpQJNm/lUCgzlLXLbNiWw02x1ufwnPc
 YUrsxN7MfX660J+l8sw82zVNjQ3FSc0KG9fvc85NRHku4Q0kWLTu/dK/xAe3HqVJgbQC
 7XLrDRqaWZJYenvETUJqsEu5jyG+bAvPUtuKlV23D/7YUo34HNvhan08dYqcPbbdLiy3
 x1bF1ih27OAeCDB3gqp3pRTA/e9oC/c17ACqpFqlauHY92aOYvdsziR9hzeVlHj0iA6H
 FmEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkz1VMxWoyJPnfZQzp5DjecYVeUOMXO73ejiRSRu1+T0UxE2dhCjd+ZuqMhJwPavZgN/M412qXf8VW@nongnu.org
X-Gm-Message-State: AOJu0YwQtoYvIGgc7iBBmKwabnqCDm6T8IkCLFbMuzsx7XyMiX8DyJk7
 XxrYKPL6gRFw9mWSV3GurLioZ2PPrZijj349bXcNfFcvBrS45N6tgexzkk+DpEc=
X-Gm-Gg: ASbGncvanPHuUEAPDYi/eDErlonhR8qrMOJrE29qZz4vQSJA8XbgVzpKDusvILyuhl9
 5Fccpkclb9+kUpIP1SLXs6JGFwFj93Z7atAaFB886I6w+s8+xwOtnG7a8iyS6f/Z6iCVP53rEgc
 6+Ot1cUWt2/jD412oeFZTiY6v01uSpHEzSWlTKxAuSTNxIdrd8kW4+PmiFLzfJU09MLCawJ/MDR
 3yEWEiB17Z9+5CbLgnNa+wFomBfGOhucnlQJkgS7ZjKYvuHpg9erQ02iiFu8qKzTxcpRwvT+lkW
 N/6RikdOua572nj8JV6Evv+zVXqg8LTp4qh+LY+0CK6wbKjpWuCRe7P6ZQ==
X-Google-Smtp-Source: AGHT+IEo7PUyuPRrW5112fsY5w5F4IjUJXxPRcD8NmFeSyQ2DEuoLS7aBQoXtmRHhREROhukBx5l8A==
X-Received: by 2002:a17:90b:4ecf:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-3051c8c0fd6mr8877504a91.10.1743235144185; 
 Sat, 29 Mar 2025 00:59:04 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30516d55fe7sm3115922a91.16.2025.03.29.00.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 00:59:03 -0700 (PDT)
Message-ID: <87a2f892-4075-4249-8691-612a5472ba51@daynix.com>
Date: Sat, 29 Mar 2025 16:58:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] gdbstub: introduce target independent gdb
 register helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250324102142.67022-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/24 19:21, Alex Bennée wrote:
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
> +
> +/**
> + * gdb_get_reg64_value() - type checked wrapper for gdb_get_register_value()
> + * mo: size and endian MemOp
> + * buf: GByteArray to store in target order
> + * val: pointer to uint32_t value in host order
> + */
> +static inline int gdb_get_reg64_value(MemOp op, GByteArray *buf, uint64_t *val) {
> +    g_assert((op & MO_SIZE) == MO_64);
> +    return gdb_get_register_value(op, buf, val);
> +}
> +
> +#endif /* GDB_REGISTERS_H */
> +
> +

Nitpick: extra newlines here.

> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b6d5e11e03..e799fdc019 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -32,6 +32,7 @@
>   #include "exec/gdbstub.h"
>   #include "gdbstub/commands.h"
>   #include "gdbstub/syscalls.h"
> +#include "gdbstub/registers.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "accel/tcg/vcpu-state.h"
>   #include "gdbstub/user.h"
> @@ -45,6 +46,7 @@
>   #include "system/runstate.h"
>   #include "exec/replay-core.h"
>   #include "exec/hwaddr.h"
> +#include "exec/memop.h"
>   
>   #include "internals.h"
>   
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
> +    } else {
> +        g_byte_array_append(buf, val, bytes);
> +    }
> +
> +    return bytes;
> +}
> +
> +

An extra blank line here too; each of the other functions in this file 
has only one blank line following.

>   static void gdb_register_feature(CPUState *cpu, int base_reg,
>                                    gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
>                                    const GDBFeature *feature)


