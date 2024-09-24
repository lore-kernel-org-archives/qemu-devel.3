Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC39CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 19:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stB0b-0007sH-Iw; Tue, 24 Sep 2024 15:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1stB0N-0007Y4-Ny
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 15:15:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1stB0L-0004vJ-ME
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 15:15:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-374c7e64b60so3097336f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727205319; x=1727810119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YUogfJuU1I9/+JaCfV8qUdt50vZ6ZfbB1fjC8hifGa4=;
 b=tgxoQ9ufMG/JH2apYINehuABabgjCX49wUD+J+UkPojcxv8IabNnGiKbYNe3Xn/Zps
 wS+QH8G91Xuo/n7xGPaJamka/A5oSgSC4m8LVAVKP/89IpBb1bTfc5pcpd/MKDw8Q7V9
 ilW6iXoPUydXwGFLYs+Mqn2PIK53Fyee4lZ1BQV3SSIjwXeQyF9buk8S4Y5PL8eEOS89
 pNzucOoDWCo9oOBQUO7VgBSQUKLowFrzb93qXz8cS+Ar97G96/1gvPtslMotE6zXTSpn
 YFe11roO81Wj2R8bJIGasQ2+oiIWqxq1/eCgO9l6mUiHj3OzIFVWPeIKhpVNG7E+K+MY
 T3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727205319; x=1727810119;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YUogfJuU1I9/+JaCfV8qUdt50vZ6ZfbB1fjC8hifGa4=;
 b=gyt2D51EsxyB+YCDcKQRCX4+E0NPp3R1CvzFYDLw1T0HL7LfEcwcAgWiJr/ceriWbA
 B8buCyKd967C6ymXc7hnwwUL5bV+hvlORghcQYtUJiydXbmtuz15Y9a4td1m04Rr12NW
 TVlcDobBFc+XZ3YtvxolxM0Ng1RyOJgn/QEbUqF1G2mn5vpsLqCRazDxoZpteWl1OJoo
 IKca7rAHshwDxSjNDgP9v+WooCO7MTXyM197mFqjbkww4LU6zFy0dc/Y4eyC4DDawd31
 cKTziyyi5uXTnvoJQZQ+ENWYstOrSUd9R4Fw2X6RTAq7w+wrk4f8rRnFlJNKC+eadARE
 TSlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiKRmpTM6u4EDKdn5Uwu17d1dLC8fXTELGgpmJUUhPPGuiMMTKKcNLgnRRIRm1PDH0juRI5iVBlvW8@nongnu.org
X-Gm-Message-State: AOJu0YyWPwcsPnfKeetUjiqbV2L2W+lKR+2VIiynKBHbV474mV1Dqzmp
 PtJHCthbpZ7LOQtqwahu4HXSEqyekjZeVB9vMse0xwt6Oq3QxcgpHG0HAdcsgCA=
X-Google-Smtp-Source: AGHT+IEGus2jyAZgdq3GIwN/5gKff4emUY7I3Vl7WGBrrq8/954IPS05snrJux5PUbZGBTqcy9MiLA==
X-Received: by 2002:adf:ab16:0:b0:374:bfc4:b62f with SMTP id
 ffacd0b85a97d-37cc2465055mr206389f8f.3.1727205319156; 
 Tue, 24 Sep 2024 12:15:19 -0700 (PDT)
Received: from [192.168.240.175] (14.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2c2246sm2263656f8f.38.2024.09.24.12.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 12:15:18 -0700 (PDT)
Message-ID: <7c750b58-e845-4d80-b5a5-7eda8f505fb6@linaro.org>
Date: Tue, 24 Sep 2024 21:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] target/arm: Implement the SETG* instructions
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
 <20230912140434.1333369-10-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
In-Reply-To: <20230912140434.1333369-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Peter,

(patch merged as commit 6087df574400659226861fa5ba47970f1fbd277b).

On 12/9/23 16:04, Peter Maydell wrote:
> The FEAT_MOPS SETG* instructions are very similar to the SET*
> instructions, but as well as setting memory contents they also
> set the MTE tags. They are architecturally required to operate
> on tag-granule aligned regions only.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: - separate helper functions calling do_setp/setm/sete
>      - use cpu_st16_mmu()

So you replaced the pair of cpu_stq_mmuidx_ra() from v1 by
cpu_st16_mmu().

> ---
>   target/arm/internals.h         | 10 ++++
>   target/arm/tcg/helper-a64.h    |  3 ++
>   target/arm/tcg/a64.decode      |  5 ++
>   target/arm/tcg/helper-a64.c    | 86 ++++++++++++++++++++++++++++++++--
>   target/arm/tcg/mte_helper.c    | 40 ++++++++++++++++
>   target/arm/tcg/translate-a64.c | 20 +++++---
>   6 files changed, 155 insertions(+), 9 deletions(-)


> +/*
> + * Similar, but setting tags. The architecture requires us to do this
> + * in 16-byte chunks. SETP accesses are not tag checked; they set
> + * the tags.
> + */
> +static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
> +                              uint64_t setsize, uint32_t data, int memidx,
> +                              uint32_t *mtedesc, uintptr_t ra)
> +{
> +    void *mem;
> +    uint64_t cleanaddr;
> +
> +    setsize = MIN(setsize, page_limit(toaddr));
> +
> +    cleanaddr = useronly_clean_ptr(toaddr);
> +    /*
> +     * Trapless lookup: returns NULL for invalid page, I/O,
> +     * watchpoints, clean pages, etc.
> +     */
> +    mem = tlb_vaddr_to_host(env, cleanaddr, MMU_DATA_STORE, memidx);
> +
> +#ifndef CONFIG_USER_ONLY
> +    if (unlikely(!mem)) {
> +        /*
> +         * Slow-path: just do one write. This will handle the
> +         * watchpoint, invalid page, etc handling correctly.
> +         * The architecture requires that we do 16 bytes at a time,
> +         * and we know both ptr and size are 16 byte aligned.
> +         * For clean code pages, the next iteration will see
> +         * the page dirty and will use the fast path.
> +         */
> +        uint64_t repldata = data * 0x0101010101010101ULL;
> +        MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, memidx);

I'm trying to understand the MO_TE use, but I'm not seeing it in
https://developer.arm.com/documentation/ddi0602/2024-06/Base-Instructions/SETGP--SETGM--SETGE--Memory-set-with-tag-setting-
pseudo code. I also checked
https://developer.arm.com/documentation/ddi0602/2024-06/Shared-Pseudocode/aarch64-functions-mops?lang=en#impl-aarch64.MemSetBytes.4
and 
https://developer.arm.com/documentation/ddi0602/2024-06/Shared-Pseudocode/aarch64-functions-memory?lang=en#AArch64.MemSingleWrite.5

Is the following part in MemSingleWrite()?

     if !atomic && aligned && accdesc.ispair then

         bits(halfsize*8) lowhalf, highhalf;
         <highhalf, lowhalf> = value;

         memstatus = PhysMemWrite(memaddrdesc, halfsize, accdesc, lowhalf);

         memaddrdesc.paddress.address = memaddrdesc.paddress.address + 
halfsize;
         memstatus = PhysMemWrite(memaddrdesc, halfsize, accdesc, highhalf);

> +        cpu_st16_mmu(env, toaddr, int128_make128(repldata, repldata), oi16, ra);
> +        mte_mops_set_tags(env, toaddr, 16, *mtedesc);
> +        return 16;
> +    }
> +#endif
> +    /* Easy case: just memset the host memory */
> +    memset(mem, data, setsize);
> +    mte_mops_set_tags(env, toaddr, setsize, *mtedesc);
> +    return setsize;
> +}

If we need to endian swap, could we use the cached hflags instead of MO_TE?

The BE_DATA bit is iset in rebuild_hflags_a64() when
arm_cpu_data_is_big_endian_a64() is true. The following diff snippet
works for me but I'm out of my comfort zone here :)

-- >8 --
          uint64_t repldata = data * 0x0101010101010101ULL;
-        MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, memidx);
+        MemOp be_data = EX_TBFLAG_ANY(env->hflags, BE_DATA) ? MO_BE : 
MO_LE;
+        MemOpIdx oi16 = make_memop_idx(be_data | MO_128, memidx);
          cpu_st16_mmu(env, toaddr, int128_make128(repldata, repldata), 
oi16, ra);
          mte_mops_set_tags(env, toaddr, 16, *mtedesc);
          return 16;
---

Thanks,

Phil.

