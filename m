Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80565C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twf6x-000522-IL; Mon, 24 Mar 2025 06:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twf6v-00050N-Nl
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:32:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twf6s-0008Ub-BI
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:32:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso27278455e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742812364; x=1743417164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EAiPkK8wh8qlx1pXPGYIeLNOM9exBObN/Aljt/N3k8=;
 b=hd/gdw7i7zU2RaRPTXdA7EPZuSZ6uWHnxl8dJGpuM6IElCuaAcs4ViQLbEIUvlBMSj
 AZHIxg6EejatC8P9PZ3e0IWZvlI5QFERwJmA0DQC7DAVLQ+JhEHQvAFVM/SEc43W0e4X
 y0pJStjdPKVGbUvXrnFc/41FcMumxgBIIV0odddike+eKvvZ1FmWngKQzkw37B1jWUIU
 1bxDVGe2WDFL1MOQecK6zD3uzlEyWRKv8FmBE+1nZYyTn44v367TugakwZL/WpYYzJwV
 N9MiyqcsfzqvVLVq/8Um2hmvlN97zkRyN6a7JlY11TR22y/pYskLVoaGfgu5vLJYI/Xh
 RPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742812364; x=1743417164;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1EAiPkK8wh8qlx1pXPGYIeLNOM9exBObN/Aljt/N3k8=;
 b=CUXh4D4SnUyaib7gm2QOtH6BWp+tO0R6idrd+errS8Xx7TbFtNeU2+AzoeSVdT09Ax
 YVk+xl6YlX/62mMiRxK4LFBf9zH1Hp14zJz+m1z4073q7apc/7h/NOq3zTCRUoVpSkYW
 UxQZ0FjsU5FAAkesyX02hQGWca/8PEIy+o2LFoH5xI74rHEfhTsNCkn0hKxNe6IswmG5
 SK9w+K/Ywt5h50pfdIe0rjsYWkPlkVX9l7XQ9+RHkiDiCZkbY0OOE13ITCZlZOUE2nDJ
 C5CWmiwha/gwKu6etqiSPqTLk+pbgbYVK394OWjWzozxnl9d8P32uz4rIvzAfF/WY/dL
 wMeQ==
X-Gm-Message-State: AOJu0YzxhdKs1lfTPNpYLp2Iju5KUltZcQ+OgQn0qTq3JCEGJWpolGsN
 kPnGyqSBuLrzdpT8Y8VunuEG3aJyrkPoeUEMRrq+3GO7nFQ7sGKqgjFbvyY8NMw=
X-Gm-Gg: ASbGncsDIRLsO9lKI8DCuHWxbFNU7S8vtGDzVjns5jdOdQnwMI148ab9fnAUL5qSMhd
 RFpWEKeSr9nvyBt8z7e77UFjwkGbrJVqvj2/W/2keI2fP5pJRhAuKqjprH/egn6caEVqJUrBXPN
 1q0OL7TX0SJ6wBT5b93kj6SJ6EJHN7uJqHGJLyzqU8607fZ0B32nknKCdtd37Lgi/+iCPFKAjnB
 cyoSKziDgEq9nb4xlJ0I2VyQgiH92sfbY1xb2fZpoZMwypYtmjXd0itFV1NY3RrvKwx02aapJTz
 1PgmZQUtW1sdREvKKggYrqN7Sigt9GAgdAcpAWE8dnQwLDk=
X-Google-Smtp-Source: AGHT+IHXR4jCO1ZjSxIxWb1th4SBMczucWbzqckeHOtRPeHZNop0RxaibJxHM0sj0vgZp/3S2tZP9Q==
X-Received: by 2002:a05:600c:3516:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-43d50a52671mr116351385e9.31.1742812364248; 
 Mon, 24 Mar 2025 03:32:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b3dd5sm10497915f8f.45.2025.03.24.03.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:32:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E824F5F8B9;
 Mon, 24 Mar 2025 10:32:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Markus Armbruster
 <armbru@redhat.com>,  Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  David Gibson
 <david@gibson.dropbear.id.au>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell
 <peter.maydell@linaro.org>,  qemu-s390x@nongnu.org,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 04/11] gdbstub: introduce target independent gdb
 register helper
In-Reply-To: <20250324102142.67022-5-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 24 Mar 2025 10:21:35 +0000")
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-5-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 24 Mar 2025 10:32:42 +0000
Message-ID: <87ikny4t2t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The current helper.h functions rely on hard coded assumptions about
> target endianess to use the tswap macros. We also end up double
> swapping a bunch of values if the target can run in multiple endianess
> modes. Avoid this by getting the target to pass the endianess and size
> via a MemOp and fixing up appropriately.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - use unsigned consistently
>   - fix some rouge whitespace
>   - add typed reg32/64 wrappers
>   - pass void * to underlying helper to avoid casting
> ---
>  include/gdbstub/registers.h | 55 +++++++++++++++++++++++++++++++++++++
>  gdbstub/gdbstub.c           | 23 ++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 include/gdbstub/registers.h
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
> + * gdb_get_reg32_value() - type checked wrapper for gdb_get_register_val=
ue()
> + * mo: size and endian MemOp
> + * buf: GByteArray to store in target order
> + * val: pointer to uint32_t value in host order
> + */
> +static inline int gdb_get_reg32_value(MemOp op, GByteArray *buf, uint32_=
t *val) {
> +    g_assert((op & MO_SIZE) =3D=3D MO_32);
> +    return gdb_get_register_value(op, buf, val);
> +}
> +
> +/**
> + * gdb_get_reg64_value() - type checked wrapper for gdb_get_register_val=
ue()
> + * mo: size and endian MemOp
> + * buf: GByteArray to store in target order
> + * val: pointer to uint32_t value in host order
> + */
> +static inline int gdb_get_reg64_value(MemOp op, GByteArray *buf, uint64_=
t *val) {
> +    g_assert((op & MO_SIZE) =3D=3D MO_64);
> +    return gdb_get_register_value(op, buf, val);
> +}
> +
> +#endif /* GDB_REGISTERS_H */
> +
> +
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b6d5e11e03..e799fdc019 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -32,6 +32,7 @@
>  #include "exec/gdbstub.h"
>  #include "gdbstub/commands.h"
>  #include "gdbstub/syscalls.h"
> +#include "gdbstub/registers.h"
>  #ifdef CONFIG_USER_ONLY
>  #include "accel/tcg/vcpu-state.h"
>  #include "gdbstub/user.h"
> @@ -45,6 +46,7 @@
>  #include "system/runstate.h"
>  #include "exec/replay-core.h"
>  #include "exec/hwaddr.h"
> +#include "exec/memop.h"
>=20=20
>  #include "internals.h"
>=20=20
> @@ -551,6 +553,27 @@ static int gdb_write_register(CPUState *cpu, uint8_t=
 *mem_buf, int reg)
>      return 0;
>  }
>=20=20
> +/*
> + * Target helper function to read value into GByteArray, target
> + * supplies the size and target endianess via the MemOp.
> + */
> +int gdb_get_register_value(MemOp op, GByteArray *buf, void *val)
> +{
> +    unsigned bytes =3D memop_size(op);
> +
> +    if (op & MO_BSWAP) {
> +        uint8_t *ptr =3D &((uint8_t *) val)[bytes - 1];
> +        for (unsigned i =3D bytes; i > 0; i--) {
> +            g_byte_array_append(buf, ptr--, 1);
> +        };

I forgot to fix this up. Hopefully the following seems a little less
like pointer abuse:

/*
 * Target helper function to read value into GByteArray, target
 * supplies the size and target endianess via the MemOp.
 */
int gdb_get_register_value(MemOp op, GByteArray *buf, void *val)
{
    unsigned bytes =3D memop_size(op);
    uint8_t *data =3D val;

    if (op & MO_BSWAP) {
        uint8_t *ptr =3D &data[bytes - 1];
        do {
            g_byte_array_append(buf, ptr--, 1);
        } while (ptr >=3D data);
    } else {
        g_byte_array_append(buf, val, bytes);
    }

    return bytes;
}


> +    } else {
> +        g_byte_array_append(buf, val, bytes);
> +    }
> +
> +    return bytes;
> +}
> +
> +
>  static void gdb_register_feature(CPUState *cpu, int base_reg,
>                                   gdb_get_reg_cb get_reg, gdb_set_reg_cb =
set_reg,
>                                   const GDBFeature *feature)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

