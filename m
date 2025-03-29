Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F2BC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 08:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyRMO-0007YX-O3; Sat, 29 Mar 2025 04:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tyRMI-0007Xv-JA
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 04:16:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tyRMF-00079Z-0M
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 04:16:01 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso25434535ad.2
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1743236157; x=1743840957;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCRkO8v+2k1YmAtHJ0D7+mQ9SXBzHZb8iVLfpQpK7Pc=;
 b=bR6y5RSNKqAhOnTT+W0xVkSjnRjoEnL+cOp21agOX396ybeju6xornhrtBG679Uw/7
 Fx6OqSwxeUKmX4SKRelLgvRtkwTR7fKjN2cIOW8cogGheHofMahrcqSHnSJDVhpjTnAE
 LVPWSAznJOeRPjLeBwM1l3O3L7vwOKz6QvpDtcxl/41/AEWuU4Qc+yGSlK2XFODiGhE7
 3zjtkU4hV4qVWl/mDdE7C0hoMSZr+ml5oJlyLG+5+Dpr8Zb3o2wBNCEx9L+4/TfrnOWe
 mky+886XgyamA6alvTXSPsDFN+0FtULM1UXiOTtf2qDNx1NSY0YxIxkc26Mh/YfpdANz
 k4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743236157; x=1743840957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sCRkO8v+2k1YmAtHJ0D7+mQ9SXBzHZb8iVLfpQpK7Pc=;
 b=BUQCu+oUHA63jNC0UJwTFrgfTfZJPVkpz4lzYJ/fyUHcPZyRYiyYk3/1buppKIMerC
 yy8LZ8jtaVdscXcRhFyH1syUgkoyFrn1K+a3/GQSzh2ddWfDhNXf1GINy41ayCghdS3l
 B4E5QaRTNbqv0bjhbYv5du6He2SRm0TP8aA5E5lSqnbPkJ1NwOVbNT1f/3mXkbi0AQaI
 gZ5rib2nBwtqkDONvQnewO48hKfy6FZNanFMxOiI5yq44FN6ygnkXuGhr7T9bCnY1C2Z
 R9EbttQB9WGEe8K9t6RKNoxUFC081sV1GfDKQhNJV4N16ilfPYFyZwlSWiWFLU9VowXr
 8S2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhW3JcgmhOTbAXOJWGx+xKi00+adHEPM7+Iwt2GZsY1QPSlpi68/gTLwOwV6MYIOaCmxVINCHWz3Pe@nongnu.org
X-Gm-Message-State: AOJu0YzWECRy5otOtAIDH3qwqyGHY8K+2ND+wHDDrGMo0JgunvSfkk2z
 eTQ//sNkNsQ7kSg4+O0xy9fsMuJrHJRg0Zguuv3R7ux7BR72URvXzd0FGdCb/O4=
X-Gm-Gg: ASbGnctOGEE2XBKcpjEWNB5AMxZ4cy4Pq5x+AupU/TPQiexSXIbNOhmQ2vLd1UNAwg3
 hwC7dqYMDlH8dyAm3bZM128LniRixlFsH1hngEGkBrinMaYDyzHo6j5LnX8bWznfUoSMMUikHTJ
 gW3NHhwe10I/S1R2l33c/fmD9APyUDy9rrCS0ZQ+oeqj4h1LQed+kJwyHJlLzJw8QxuGX35R6ym
 LY241fqmtVFZx5VZGXw5CGBHJ1tW1bK5fWmAG4XKq1nHLaUEESYoPMmNLJhUApOtR3yNVHM+z75
 zo2hjJzjDoYTlS5YNH1YlPwh6XPZ99HmeZmZpZPfvuZG5S1sxkKmBBzZKQbG5TtUAZM2
X-Google-Smtp-Source: AGHT+IFLzMno6jfCZHUYLawzpd4uXQgCbKGeJWvEi1sgCAWJP5dULhsaegUqnSB/R3YedHhlTEB2yA==
X-Received: by 2002:a05:6a00:991:b0:736:a77d:5412 with SMTP id
 d2e1a72fcca58-73980395977mr3360511b3a.12.1743236157069; 
 Sat, 29 Mar 2025 01:15:57 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710ccf1fsm3058896b3a.163.2025.03.29.01.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 01:15:56 -0700 (PDT)
Message-ID: <0ac28f60-49c9-4864-a5e0-412b2220d108@daynix.com>
Date: Sat, 29 Mar 2025 17:15:51 +0900
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
 <87ikny4t2t.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87ikny4t2t.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/24 19:32, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> The current helper.h functions rely on hard coded assumptions about
>> target endianess to use the tswap macros. We also end up double
>> swapping a bunch of values if the target can run in multiple endianess
>> modes. Avoid this by getting the target to pass the endianess and size
>> via a MemOp and fixing up appropriately.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>    - use unsigned consistently
>>    - fix some rouge whitespace
>>    - add typed reg32/64 wrappers
>>    - pass void * to underlying helper to avoid casting
>> ---
>>   include/gdbstub/registers.h | 55 +++++++++++++++++++++++++++++++++++++
>>   gdbstub/gdbstub.c           | 23 ++++++++++++++++
>>   2 files changed, 78 insertions(+)
>>   create mode 100644 include/gdbstub/registers.h
>>
>> diff --git a/include/gdbstub/registers.h b/include/gdbstub/registers.h
>> new file mode 100644
>> index 0000000000..2220f58efe
>> --- /dev/null
>> +++ b/include/gdbstub/registers.h
>> @@ -0,0 +1,55 @@
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
>> + * There are wrapper functions for the common sizes you can use to
>> + * keep type checking.
>> + *
>> + * Returns the number of bytes written to the array.
>> + */
>> +int gdb_get_register_value(MemOp op, GByteArray *buf, void *val);
>> +
>> +/**
>> + * gdb_get_reg32_value() - type checked wrapper for gdb_get_register_value()
>> + * mo: size and endian MemOp
>> + * buf: GByteArray to store in target order
>> + * val: pointer to uint32_t value in host order
>> + */
>> +static inline int gdb_get_reg32_value(MemOp op, GByteArray *buf, uint32_t *val) {
>> +    g_assert((op & MO_SIZE) == MO_32);
>> +    return gdb_get_register_value(op, buf, val);
>> +}
>> +
>> +/**
>> + * gdb_get_reg64_value() - type checked wrapper for gdb_get_register_value()
>> + * mo: size and endian MemOp
>> + * buf: GByteArray to store in target order
>> + * val: pointer to uint32_t value in host order
>> + */
>> +static inline int gdb_get_reg64_value(MemOp op, GByteArray *buf, uint64_t *val) {
>> +    g_assert((op & MO_SIZE) == MO_64);
>> +    return gdb_get_register_value(op, buf, val);
>> +}
>> +
>> +#endif /* GDB_REGISTERS_H */
>> +
>> +
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index b6d5e11e03..e799fdc019 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -32,6 +32,7 @@
>>   #include "exec/gdbstub.h"
>>   #include "gdbstub/commands.h"
>>   #include "gdbstub/syscalls.h"
>> +#include "gdbstub/registers.h"
>>   #ifdef CONFIG_USER_ONLY
>>   #include "accel/tcg/vcpu-state.h"
>>   #include "gdbstub/user.h"
>> @@ -45,6 +46,7 @@
>>   #include "system/runstate.h"
>>   #include "exec/replay-core.h"
>>   #include "exec/hwaddr.h"
>> +#include "exec/memop.h"
>>   
>>   #include "internals.h"
>>   
>> @@ -551,6 +553,27 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>>       return 0;
>>   }
>>   
>> +/*
>> + * Target helper function to read value into GByteArray, target
>> + * supplies the size and target endianess via the MemOp.
>> + */
>> +int gdb_get_register_value(MemOp op, GByteArray *buf, void *val)
>> +{
>> +    unsigned bytes = memop_size(op);
>> +
>> +    if (op & MO_BSWAP) {
>> +        uint8_t *ptr = &((uint8_t *) val)[bytes - 1];
>> +        for (unsigned i = bytes; i > 0; i--) {
>> +            g_byte_array_append(buf, ptr--, 1);
>> +        };
> 
> I forgot to fix this up. Hopefully the following seems a little less
> like pointer abuse:
> 
> /*
>   * Target helper function to read value into GByteArray, target
>   * supplies the size and target endianess via the MemOp.
>   */
> int gdb_get_register_value(MemOp op, GByteArray *buf, void *val)
> {
>      unsigned bytes = memop_size(op);

Nitpick: I would name it "size" instead of "bytes" for consistency.

>      uint8_t *data = val;

It's unclear what "data" means. This can be named "bytes", "val8", 
"octets", etc to differentiate from "val".

> 
>      if (op & MO_BSWAP) {
>          uint8_t *ptr = &data[bytes - 1];
>          do {
>              g_byte_array_append(buf, ptr--, 1);
>          } while (ptr >= data);

It may be better to initialize ptr to point the position after the last 
element:

uint8_t *ptr = &data[bytes];

while (ptr > data) {
   g_byte_array_append(buf, --ptr, 1);
}

Strictly speaking, this is well-defined when bytes == 0, which is not in 
the original version, and you don't need to write decrements at two 
places (initialization and update).

>      } else {
>          g_byte_array_append(buf, val, bytes);
>      }
> 
>      return bytes;
> }
> 
> 
>> +    } else {
>> +        g_byte_array_append(buf, val, bytes);
>> +    }
>> +
>> +    return bytes;
>> +}
>> +
>> +
>>   static void gdb_register_feature(CPUState *cpu, int base_reg,
>>                                    gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
>>                                    const GDBFeature *feature)
> 


