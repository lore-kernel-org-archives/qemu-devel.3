Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708A7109C057
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Tnm-0003kT-Dv; Wed, 25 Mar 2026 15:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Tnk-0003k6-V3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:22:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Tnj-0006S1-Bm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:22:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so1017471f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774466517; x=1775071317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mdTGeOJaWToaB6nQawk95rD0ZUGOiNLRMuhdtwJFghw=;
 b=qlk+9mrsBPoHtYVg/puq+Y3/M35q2YNCvtLJ4mwpKL6ZKy1hhp2EVnAuC36iVIWqTU
 3UulYkjo4BUG+vlcwZiE27h3HxGeN1YRPkYfJ5WtzwRrdkUHw5TG4Z4GChsK5nhVdmUl
 rNhs3Ogpirbc7UkuPIhbgGArwcCLNkGq/BF0M4Zcvox0FHKKkFIMRxKGYT6X5xxobsFS
 5Uw+JuVKX7f6JvtNjNTqEH0wtOgBqRZWk2hCrnA91RvgZI0k3jnTBI627geZPqvUaLCp
 G9yqI6XLhlnSoZuEhIwwElsosCxTZxn/kaihrAhZjCtSr32HBtvHrWjlN2v+VkjRCWYd
 +xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774466517; x=1775071317;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdTGeOJaWToaB6nQawk95rD0ZUGOiNLRMuhdtwJFghw=;
 b=IJad1rFIWDzazAYmEFNmC95+qUQxdoFi/Hiem4+DW5/bPRnySGBkIbraLyfod/xzod
 8vUV6V4ASn8pKhZouFmbjGQGOUzA3zIAwftsTPxMsrdtlDU1bwa37VmSKSlf0SYPlRZY
 oW8PbQ1povaw3WsehaE/F3HPU5TQT99OXJnufJvuWzfwSYCjXq7QhWW0IKEFc5/IoG7s
 7ysiHF1hDm/edWZqWRjwqqJXkR/Vl2Z0xX1x3zxlmjld3mYuZHSbNd1hYt0H51c+zyv8
 uIAxlqEbH14Z555F9h52Xaelkcqvq3hnwuRi9n5ix0UG5JZTE/m6jMAsEbzv9UMZwbP6
 L1/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ1TTCrtzlJL4FU367j2ZQvoMHiZrKreuP47MimlmWQEmpqMqDummdBjfWpieTp21mPXbauuPlVshS@nongnu.org
X-Gm-Message-State: AOJu0YyJhJ5GX6yEJssN++EJOtjgVdMf2L5AIZk3NyST0djZqmjXDLor
 tVgMajyposaInbOlfZbPdVz1ZpjaXOoCTtr2LvywaVQ/qQXm5gDwkk/YAEmLMGgXW/0=
X-Gm-Gg: ATEYQzycUXGsGvF+bUP/eQDIT/3oJQ5wxpJsIdwMWR6+VFXbgVcB7h/8aYvtQ1p+AUn
 BK78kbBuW5CIEKGpP5c9gKbwNojkEol4keVzyB4b4RDEQcySKdyMz9ceHpoFR++EEa0xuNpCKlW
 o90T3yOLXRTp0+HpNZufQ/KofQWoycpc0khXxB+08hxSI9OLqwNKCb7zuUAoWEftDzLPINKrCve
 TOzwzAvKbRYgD6k25KlZMh6LzWqvvrSil/zhmTDSL9CmEpzXzgWhuN/uLz2uIp+S5+UrJJDSndF
 AScI/YkyzR5h3S+Ul+1Z8YF7UR9dtJsiCSdden7T9x5Nw974aExvZgwqBeFHUBR/cI7rfu8Fb53
 U8LIrRiF26iYFEJUknk6FUCtzSyX5kFXuhibZ+o+hThi7w9BatSZfBugzOPz7UQ4RsElkJBmkNa
 Qq960ioVO0mrSbqiDCQzleSjdxOk6Bagc2x+FiA42iQ+3JqcJwasI7bGDBMSNdVto4Wg==
X-Received: by 2002:a05:6000:4381:b0:439:ddc0:4bef with SMTP id
 ffacd0b85a97d-43b883786damr7686331f8f.8.1774466517363; 
 Wed, 25 Mar 2026 12:21:57 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e722dsm1710853f8f.35.2026.03.25.12.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 12:21:55 -0700 (PDT)
Message-ID: <d0f113a6-0e9a-4e23-becd-9233f1abba72@linaro.org>
Date: Wed, 25 Mar 2026 20:21:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/35] target/hexagon: Add vmstate representation
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
 <20260311034923.1044737-20-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260311034923.1044737-20-brian.cain@oss.qualcomm.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/3/26 04:49, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/internal.h |  4 ++++
>   target/hexagon/cpu.c      |  3 +++
>   target/hexagon/machine.c  | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 39 insertions(+)
>   create mode 100644 target/hexagon/machine.c
> 
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 5fc837ae229..cd06ff41d4f 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -31,4 +31,8 @@ void hexagon_debug(CPUHexagonState *env);
>   
>   extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
>   
> +#ifndef CONFIG_USER_ONLY
> +extern const VMStateDescription vmstate_hexagon_cpu;
> +#endif
> +
>   #endif
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 6fabfaad6d2..38d605b06ba 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -387,6 +387,9 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
>       cc->gdb_stop_before_watchpoint = true;
>       cc->gdb_core_xml_file = "hexagon-core.xml";
>       cc->disas_set_info = hexagon_cpu_disas_set_info;
> +#ifndef CONFIG_USER_ONLY
> +    dc->vmsd = &vmstate_hexagon_cpu;
> +#endif
>       cc->tcg_ops = &hexagon_tcg_ops;
>   }
>   
> diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
> new file mode 100644
> index 00000000000..d6dcd07dd4a
> --- /dev/null
> +++ b/target/hexagon/machine.c
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "migration/cpu.h"

We don't need to include the target-specific "migration/cpu.h" header,
the target-agnostic "migration/vmstate.h" should be sufficient. With
that change:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +#include "cpu.h"
> +
> +const VMStateDescription vmstate_hexagon_cpu = {
> +    .name = "cpu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(env.gpr, HexagonCPU, TOTAL_PER_THREAD_REGS),
> +        VMSTATE_UINT32_ARRAY(env.pred, HexagonCPU, NUM_PREGS),
> +        VMSTATE_UINT32_ARRAY(env.t_sreg, HexagonCPU, NUM_SREGS),
> +        VMSTATE_UINT32_ARRAY(env.greg, HexagonCPU, NUM_GREGS),
> +        VMSTATE_UINT32(env.next_PC, HexagonCPU),
> +        VMSTATE_UINT32(env.tlb_lock_state, HexagonCPU),
> +        VMSTATE_UINT32(env.k0_lock_state, HexagonCPU),
> +        VMSTATE_UINT32(env.tlb_lock_count, HexagonCPU),
> +        VMSTATE_UINT32(env.k0_lock_count, HexagonCPU),
> +        VMSTATE_UINT32(env.threadId, HexagonCPU),
> +        VMSTATE_UINT32(env.cause_code, HexagonCPU),
> +        VMSTATE_UINT32(env.wait_next_pc, HexagonCPU),
> +        VMSTATE_UINT64(env.t_cycle_count, HexagonCPU),
> +
> +        VMSTATE_END_OF_LIST()
> +    },
> +};


