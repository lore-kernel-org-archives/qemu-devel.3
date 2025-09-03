Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F03CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttrb-0000Tg-79; Wed, 03 Sep 2025 16:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uttrX-0000T3-Dp
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:13:47 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uttrT-0002iw-RT
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 16:13:46 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32b60a9aa4cso150697a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756930421; x=1757535221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8oR7Ug/NBOYS0ZxmroGQfUtno2HikxnOcrwBNJDARM=;
 b=FWW4FJn8KXBKM+GrSYZ9no6yiNtK8bxahMoFypUUN6RF2RecqA09vxgdQBiKjrHVFg
 sY7FDfEyqGxv0dLDivRr4TQT4x9M9624/MYc2OjZYUihvBB1tRSXUtDONHtY9u84tvHM
 42sXCtCHD0Qg8hy2jcxjhb945T2cI0O6BugF8AX6tKvj7V1vKSCLvky85Oc6DvTKoI3b
 san7pPy9xZwXEGdexq19/iyIJNHbbyc3FL0K1uD9VFvbv573J+7hK/jhXEXlvHA0cOxC
 sZM5IMmlSQc/i98vfcwcKzttUOpYw26J51fKF2IjVlfB9hjqx6ASLqOlt4xKvGbsKn8V
 ZcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756930421; x=1757535221;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8oR7Ug/NBOYS0ZxmroGQfUtno2HikxnOcrwBNJDARM=;
 b=ntC7MBItUKbEnL1Aq0E6XunJdQegstBcICFc2ze//DWiz2smaf5MeYPlvpfLf/hVgk
 16URl+EvalY+fb8i9GpidKfhu2s/pZvNuTKOYTQE/C3OhyaTTOj96rjP00yB6KH/0BPJ
 9ZwzJ9WTU/UQVCW6IDlrrG0NhDo6jjaRas61azJOZQ0bBkxic06c5Zjd6DeAJ0XpvAzw
 sTMzJ/trfXvtGZ+kQZh+cnStDZ2npNLQ4fZal6yJJZLFDOpu1dx9sKVMhVMdBNGSVeYB
 JZx1ygKTYKyTHqj1i8uERRCAWJaQ2LEg+FMTdyVoarvfrwv4kO6OfOzc2qoBp3AmNOJr
 QiSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUttQiZEyC8B4z8kyhl0PBi5E3JQI1ym5OBgD+X4BNOeUOCnJRBvQjSLTFMtKSvWN9rEhXbiJUVg/K+@nongnu.org
X-Gm-Message-State: AOJu0YzvLi7kxsRCR4V8TuMwFzf/1y5ubbx2jXsqkSWfT85r3fYOPI2t
 C+6CjSut+KULCZYLU+anOHNpnzYa27VP57SLC58eOPKyI3SeEoLtkrhUVE5ZD7RULt4=
X-Gm-Gg: ASbGncv77ntzxwMblvnb2czjhxK0LyDMq5AWnzVBU3oDIWy2M30dadoTT/kzctZtoBl
 RG0uEIxmDb1AbpSc8NvYu40MjxZxP91ZjZZ2rxjQ9MJsTXtfix2VGpdm2g87+SnIgE2aDduAF/6
 XvC4K/P/JvUyPr4BN1i+PUZz4IEnmmqP24VRLJrCCo1lB3Las9wwX8NqzohMvzcWQmaoiY8MyZ2
 pws3h0ZS1MlynkeVHOOULuYfIvLD1vIkwLmktNM+xKPRKzGWQVrW8JPg6v6Tzey4AuW+MqQ1izD
 UXh9uh+eqpmZnovW+BathFkJpou3Sw143oXC88ereM8M/6Ra+RrMbglttutWxBJBISc8F4qrY9F
 kPF/vS8Ymu8JmfdHelxF0PZy47r2o7ODwCq/tnyV+uC/DcY0=
X-Google-Smtp-Source: AGHT+IH6lyJIqKNClqanASQizB/0VF5Kcvuuvw8f/faiT7LrhBlLXCWtptmMbwZJ3BXuvduUv3DIOg==
X-Received: by 2002:a17:90b:1642:b0:32b:6132:5f94 with SMTP id
 98e67ed59e1d1-32b61326258mr4103392a91.21.1756930421459; 
 Wed, 03 Sep 2025 13:13:41 -0700 (PDT)
Received: from [192.168.68.110] ([187.10.187.251])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd28adc00sm15228576a12.32.2025.09.03.13.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 13:13:41 -0700 (PDT)
Message-ID: <6bff4c9d-1da4-40b3-901a-789923d8ef7e@ventanamicro.com>
Date: Wed, 3 Sep 2025 17:13:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/risvc: Fix vector whole ldst vstart check
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
References: <20250903030114.274535-1-npiggin@gmail.com>
 <20250903030114.274535-3-npiggin@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250903030114.274535-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1031.google.com
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

Hi Nick,

^ typo in the patch subject: s/risvc/riscv

On 9/3/25 12:01 AM, Nicholas Piggin wrote:
> The whole vector ldst instructions do not include a vstart check,
> so an overflowed vstart can result in an underflowed memory address
> offset and crash:
> 
>      accel/tcg/cputlb.c:1465:probe_access_flags:
>        assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)
> 
> Add the VSTART_CHECK_EARLY_EXIT() check for these helpers.
> 
> This was found with a verification test generator based on RiESCUE.
> 
> Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/riscv/vector_helper.c             |  2 +
>   tests/tcg/riscv64/Makefile.target        |  5 ++
>   tests/tcg/riscv64/test-vstart-overflow.c | 75 ++++++++++++++++++++++++
>   3 files changed, 82 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index fc85a34a84..e0e8735000 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -825,6 +825,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>       uint32_t esz = 1 << log2_esz;
>       int mmu_index = riscv_env_mmu_index(env, false);
>   
> +    VSTART_CHECK_EARLY_EXIT(env, evl);
> +
>       /* Calculate the page range of first page */
>       addr = base + (env->vstart << log2_esz);
>       page_split = -(addr | TARGET_PAGE_MASK);
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
> index 4da5b9a3b3..19a49b6467 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -18,3 +18,8 @@ TESTS += test-fcvtmod
>   test-fcvtmod: CFLAGS += -march=rv64imafdc
>   test-fcvtmod: LDFLAGS += -static
>   run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
> +
> +# Test for vstart >= vl
> +TESTS += test-vstart-overflow
> +test-vstart-overflow: CFLAGS += -march=rv64gcv
> +run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
> diff --git a/tests/tcg/riscv64/test-vstart-overflow.c b/tests/tcg/riscv64/test-vstart-overflow.c
> new file mode 100644
> index 0000000000..72999f2c8a
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-vstart-overflow.c
> @@ -0,0 +1,75 @@
> +/*
> + * Test for VSTART set to overflow VL
> + *
> + * TCG vector instructions should call VSTART_CHECK_EARLY_EXIT() to check
> + * this case, otherwise memory addresses can underflow and misbehave or
> + * crash QEMU.
> + *
> + * TODO: Add stores and other instructions.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <stdint.h>
> +#include <riscv_vector.h>

The fix in vector_helper.c is fine but this patch (and patch 3) won't execute
'make check-tcg'. It complains about this header being missing in the docker
env.

To eliminate the possibility of my env being the problem I ran this series in
Gitlab. Same error:


https://gitlab.com/danielhb/qemu/-/jobs/11236091281

/builds/danielhb/qemu/tests/tcg/riscv64/test-vstart-overflow.c:13:10: fatal error: riscv_vector.h: No such file or directory
3899
    13 | #include <riscv_vector.h>
3900
       |          ^~~~~~~~~~~~~~~~
3901
compilation terminated.
3902
make[1]: *** [Makefile:122: test-vstart-overflow] Error 1


I believe you need to add the Docker changes you made in this patch. Same
thing for patch 3. And same thing for patch 4 of:

[PATCH 0/4] linux-user/riscv: add vector state to signal

Given that you're also using riscv_vector.h in there too. Thanks,


Daniel



> +
> +#define VSTART_OVERFLOW_TEST(insn)                \
> +({                                                \
> +    uint8_t vmem[64] = { 0 };                     \
> +    uint64_t vstart;                              \
> +    asm volatile("                           \r\n \
> +    # Set VL=52 and VSTART=56                \r\n \
> +    li          t0, 52                       \r\n \
> +    vsetvli     x0, t0, e8, m4, ta, ma       \r\n \
> +    li          t0, 56                       \r\n \
> +    csrrw       x0, vstart, t0               \r\n \
> +    li          t1, 64                       \r\n \
> +    " insn "                                 \r\n \
> +    csrr        %0, vstart                   \r\n \
> +    " : "=r"(vstart), "+A"(vmem) :: "t0", "t1", "v24", "memory"); \
> +    vstart;                                       \
> +})
> +
> +int run_vstart_overflow_tests()
> +{
> +    /*
> +     * An implementation is permitted to raise an illegal instruction
> +     * exception when executing a vector instruction if vstart is set to a
> +     * value that could not be produced by the execution of that instruction
> +     * with the same vtype. If TCG is changed to do this, then this test
> +     * could be updated to handle the SIGILL.
> +     */
> +    if (VSTART_OVERFLOW_TEST("vl1re16.v    v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vs1r.v       v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vle16.v      v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vse16.v      v24, %1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vluxei8.v    v24, %1, v20")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vlse16.v     v24, %1, t1")) {
> +        return 1;
> +    }
> +
> +    if (VSTART_OVERFLOW_TEST("vlseg2e8.v  v24, %1")) {
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +int main()
> +{
> +    return run_vstart_overflow_tests();
> +}


