Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DC6C35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9Fk-0002mr-N8; Thu, 20 Mar 2025 02:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9Fi-0002lt-UO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:19:38 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9Fg-0006zV-F0
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:19:38 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso731707a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742451574; x=1743056374;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x858j5g0cieSBvQvbkhIiqqjyN9UN7MFhpuUm3aytII=;
 b=gZUEsD7sF2NL8ggEYY3i+l29lUIjUmGgfR2QKAJeoLKKdEHmWW8FAS8fWDG6KVK+4P
 O8wsoqfX8Kbyxnjpfazme/YzOerNkF/USX4Pk5fxNdLZEkg/nBNudsNMpsYaJkok7Hk7
 db5w6QNVI9++qL+o5UgiInRB99q1ER0zydwK3RIra+vr4sel5kGz/PkH66AX+GP/6ayQ
 psgg8Drjg757ICKBlcH8YD8cORoCf6AA0VUos2Ki32HJ8v/+CWB8PmwfKmjFDeplgYMk
 lPNEm9HbnaSSD9ExLe7J5YmL7dOPLO5OtZeLYCmsEcQSpKr3mRQgFvYoZ8cc34GqjuDN
 +umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742451574; x=1743056374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x858j5g0cieSBvQvbkhIiqqjyN9UN7MFhpuUm3aytII=;
 b=ZDGJdZhs+HVy7a4hav93FkOd1JPI+srrT6qLDX/3Pz1POaimSVCnAY13HTw0PvQXrd
 CrnBj+0MbjxGZ2o1X8dPj/usymG7YBeRCrpfyfxFGLcg8cBhf8syhf7E6fim2QSZbYVo
 7HjGlBAMOJtpiVMjjq/emzuJNK/Is2jEYP0Dj/XOM4hr9VlvgyHLfHb3cbASwqVfgkpy
 wq7OkvDiZ8gRpkO2rPkir03cYv1aM/6Vi+bpAuXrUJhKuWDIHYM8xCOX12bIOSYLZcP6
 zekBLKNfjL3b0q91VaWHUyVzfEtDt+Ga2t7sL6H39nGTF8iwgvjtPBcazZeSixBksoUn
 5AxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRF2LejtTYJCmUjMpVNSWEdUWU794UTtoXq3+4isFUv4AxP4/qbNiT2kAv2pCPgzTqA3ilIPIopaj6@nongnu.org
X-Gm-Message-State: AOJu0Yz/wDl5FuNGSPwuZQY/c7npDSYxjINh/+vkjL9BLH8HzY0oDGME
 H3IJMdmwdV3grfR1DhElvGi3LR4nVD2aNNgXsaQEoBPWvT8wMXpmsjg2b8S8V1o=
X-Gm-Gg: ASbGnctzzYWlqPdRflc+zwfQImRYKiu65pv4216uEUH/ilYZpgS5LOP/84xXJOam00L
 MVhgdn7l0dGoLuq6lUZsAPq4XSH3KJmBE7A6NXdOUHK6XhRg+tEaFyePY4Ep/BCVSbysVRGeORU
 c66oeVYS0QA89TuDMDnk5+Yb25jwv0aJ80mijKte3+ry14kKkCSIYLUodw918YK4Lg092g940Eg
 8iJsTpLOMlZWo5lYm3mwbX596+zhba/kfF/dHLpD5JFWcR0iZWEdBvOaA/Zq1kI47+on9BVh6rH
 Chmye9lGj2tBGD18rzoQcwbfSjaAqheMcT/fOU6Z5vq1ZloG1Ey5JtTWEQ==
X-Google-Smtp-Source: AGHT+IEQk63NuG5hPsiG5+penBOpcu/CbuFqNid+xN6gz30e5dmIoSyXSA4JSASxJGx+/dnb6jOZKw==
X-Received: by 2002:a17:90b:1a89:b0:2ff:5c4e:5acd with SMTP id
 98e67ed59e1d1-301d534bdcdmr2802128a91.35.1742451574445; 
 Wed, 19 Mar 2025 23:19:34 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf589b07sm2913296a91.11.2025.03.19.23.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 23:19:33 -0700 (PDT)
Message-ID: <d3ea5401-866c-40a0-9ccc-6c681b760535@daynix.com>
Date: Thu, 20 Mar 2025 15:19:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] gdbstub: introduce target independent gdb register
 helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
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
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250319182255.3096731-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
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

On 2025/03/20 3:22, Alex Bennée wrote:
> The current helper.h functions rely on hard coded assumptions about
> target endianess to use the tswap macros. We also end up double
> swapping a bunch of values if the target can run in multiple endianess
> modes. Avoid this by getting the target to pass the endianess and size
> via a MemOp and fixing up appropriately.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

The overall idea looks good to me. I have a few nitpicks:

> ---
>   include/gdbstub/registers.h | 30 ++++++++++++++++++++++++++++++
>   gdbstub/gdbstub.c           | 22 ++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
>   create mode 100644 include/gdbstub/registers.h
> 
> diff --git a/include/gdbstub/registers.h b/include/gdbstub/registers.h
> new file mode 100644
> index 0000000000..4abc7a6ae7
> --- /dev/null
> +++ b/include/gdbstub/registers.h
> @@ -0,0 +1,30 @@
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
> + * Returns the number of bytes written to the array.
> + */
> +int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val);
> +
> +#endif /* GDB_REGISTERS_H */
> +
> +
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 282e13e163..3d7b1028e4 100644
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
> @@ -551,6 +553,26 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>       return 0;
>   }
>   
> +/*
> + * Target helper function to read value into GByteArray, target
> + * supplies the size and target endianess via the MemOp.
> + */
> +int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val)
> +{
> +    size_t bytes = memop_size(op);
> +
> +    if (op & MO_BSWAP) {
> +        for ( int i = bytes ; i > 0; i--) {

memop_size() returns unsigned, but bytes is size_t and i is int, and 
this function returns int. Let's keep them consistent.

There is an extra whitespace between "(" and "int".

Regards,
Akihiko Odaki

> +            g_byte_array_append(buf, &val[i - 1], 1);
> +        };
> +    } else {
> +        g_byte_array_append(buf, val, bytes);
> +    }
> +
> +    return bytes;
> +}
> +
> +
>   static void gdb_register_feature(CPUState *cpu, int base_reg,
>                                    gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
>                                    const GDBFeature *feature)


