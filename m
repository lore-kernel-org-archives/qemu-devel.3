Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3B61093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Dhi-0003TW-Gd; Tue, 24 Mar 2026 22:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5Dhb-0003S7-AH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:10:35 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5DhY-0005wL-BE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:10:34 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so3540879eec.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774404627; x=1775009427; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cFjoGvd2eLLoSU20LveTmOuw9QejmOSilFdrCZhFt/Q=;
 b=ZLyqhLmVyOlja+8LV5quRey3Svp4x7vv8Z3vKlXnmMGddMepfAeEMSc8CRuALhO+9x
 H+PiOSHcFOKOFvXjPmjZjo5d2WMM8QFZuLTfVs6XfZbqzQdXdKNmzypmTZLw1hFAajpS
 6g63Z85ofLdKhf/vlODSbJPH1QUNjuN65qja7lh46CoIg0v0GO6x1aKVGVJZygiWEE/Y
 QOn+DuVQDRn64rpnfc3RkJ19C5B5Vgd5Q0gw7AE76VWSD5jAN5xZkemzRWgNCpnppHI2
 uLT4nGaKKkrJU/IskSkv4FqlhwlsCixcaJTw7s259ZOpF5wpIGI/V2jGGx6uEAe8bPJE
 3LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774404627; x=1775009427;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cFjoGvd2eLLoSU20LveTmOuw9QejmOSilFdrCZhFt/Q=;
 b=Dpa0JpzRDovxRGrALBznWRrViPW8spgB4ILf/nwweR0sMv6GEASTyC+6iLN+uh48Gd
 tc5xpcnePnQsULRr3oBeMRHgVuKWpQkFj7isBy9CSB+/xaxgKNDaHKR3W10+mwi2rVec
 AZ+A4ovVK4BlEJBiHwdIHW1pF/JqxxSkXWVVBsOQ/jNWANft+AhMiIAkNOowYYMy4w2g
 KnTg/4f2IJVQJA4sVRMR9VMBhQy4cahIi5NLEtRWEKkRdgOJV26bzOirGu/aap6Lj1kX
 DIZBFBtxwHUwV1WBRAu4MZSQMtNe2pygNl1+E/Ep1jLhECuu+uRw77iFlLPh8MNjGwGT
 5+2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAM6zLDDiOzpm1Lf8OxA+l7b+05MCcxAp4XZLAA7Dr6bTE7PxpVcFBBa8dPotY7fUl5MxfDO1HksDD@nongnu.org
X-Gm-Message-State: AOJu0YyMCfurdfolq0Jf3QZLPCtovawom/F53LdU6RpCtnMEHYUC1VNU
 QKhKWerA7KyMtMzOt/3OPorfxzPOoHiSvNX1sjEyOMn49R7C+ZktjpT/
X-Gm-Gg: ATEYQzzDAXFF++MmBsYRghkQbfFx0QrjEAcf7SPFKH7BsGRryUr3HWJEl/Z/SpQJOtE
 QEFDFxRCp3TeC1qMPahg/LAfjymKcPaM4TMfyoEKev/Y8czW7vKoN/Xh+fFkK/Pmx0KasIZRfXn
 jaIqH07zRrS+jCZXS7mDk9Nm/BOyWfvzDuiZZ24Ty1aXWCj2INkSspnJsi6Bkoq9kYwyjGyWNq+
 QLwokTZrBx8pbAMVMjYCLMMJrJNF2uxN1kXwAVH10fE+Lv/bds806P8+uFi9F0eLCviw6uQ5ZTf
 rzjmUmAUP6sNSxiYRP4m1Vgv1AgVQ9DOP9z+brUz0GEeCax1YRSl0ELyxXX6ERSV7C2VfaNnb/Q
 AxiYgKwYeqLkwnokjFVEU2mRq427o7UMdftVeQNR1xAvDWdMcArFOhcbyys7er3k7mI7OS0zvfZ
 czrxESy/ZT5aIPvrrFEFPqNHv4f3iDoVkELPD8kFGJpFCP16mwDEvMR5MNL1NSSkqsnbUglAiZb
 mhG6mWnrE/P4CvvDZuH5ZA6gnNFl5BVf85k588t/Q==
X-Received: by 2002:a05:7301:9bc6:b0:2b8:711:ae5c with SMTP id
 5a478bee46e88-2c15d2ba7dbmr993322eec.7.1774404627421; 
 Tue, 24 Mar 2026 19:10:27 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b1a88e5sm21409282eec.13.2026.03.24.19.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:10:27 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:10:05 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, 
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: Re: [PATCH v3 2/3] target/riscv: Fix vector whole ldst vstart check
Message-ID: <acNDeIf7dpYFqX9T@ZEVORN-PC.localdomain>
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260321144554.606417-3-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Mar 22, 2026 at 12:45:53AM +1000, Nicholas Piggin wrote:
> The whole vector ldst instructions do not include a vstart check, so an
> overflowed vstart can result in an underflowed memory address offset and
> crash:
> 
>     accel/tcg/cputlb.c:1465:probe_access_flags:
>       assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)
> 
> Add the VSTART_CHECK_EARLY_EXIT() check for these helpers.
> 
> This was found with a verification test generator based on RiESCUE.
Good catch! I had previously fixed some vector helpers that were
missing vstart checks, but I didn’t realize there were still some
omissions.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> 
> Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/riscv/vector_helper.c             |  2 +
>  tests/tcg/riscv64/Makefile.target        |  5 ++
>  tests/tcg/riscv64/test-vstart-overflow.c | 78 ++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index caa8dd9c12..4126447d11 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -825,6 +825,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>      uint32_t esz = 1 << log2_esz;
>      int mmu_index = riscv_env_mmu_index(env, false);
>  
> +    VSTART_CHECK_EARLY_EXIT(env, evl);
> +
>      /* Calculate the page range of first page */
>      addr = base + (env->vstart << log2_esz);
>      page_split = -(addr | TARGET_PAGE_MASK);
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
> index 4da5b9a3b3..19a49b6467 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -18,3 +18,8 @@ TESTS += test-fcvtmod
>  test-fcvtmod: CFLAGS += -march=rv64imafdc
>  test-fcvtmod: LDFLAGS += -static
>  run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
> +
> +# Test for vstart >= vl
> +TESTS += test-vstart-overflow
> +test-vstart-overflow: CFLAGS += -march=rv64gcv
> +run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
> diff --git a/tests/tcg/riscv64/test-vstart-overflow.c b/tests/tcg/riscv64/test-vstart-overflow.c
> new file mode 100644
> index 0000000000..6c904ab309
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-vstart-overflow.c
> @@ -0,0 +1,78 @@
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
> +    if (VSTART_OVERFLOW_TEST("vloxei8.v    v24, %1, v20")) {
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
> -- 
> 2.51.0
> 
> 

