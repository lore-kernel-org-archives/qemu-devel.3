Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F81DCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 18:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9pUe-0004NC-JH; Fri, 17 Oct 2025 14:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9pUa-0004Mp-At
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 14:47:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9pUX-00032e-5y
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 14:47:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso1559579b3a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760726871; x=1761331671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CcU4x6T33w+bruywnpNnmRVtUVwnr6OWT0dyPBHiY3s=;
 b=NTQo7WNbgU542k9V+UzdUHt/C23YdbZi+IAwbnc8Ven7QJPNHDzAh97DkI5n+SAN+Y
 EG12XBmjTvao35B0nRmPYU6ysmmTseobSJotn8O6ZvSMi5dExsoFrtvcTymkHBGw/yPy
 VHIEsidPF3vH7ST5StmuHcR9ImcbCkwyomq2IP7RMsZbXXjnt0p0C8KhpwMIwxRllfwi
 xjU40MI94xFXRGS7fIlknhbDtEoM/jV98ghPcMQvMqawLuRAFPTaDivxKOVLTph4TjnH
 h6I0fp7RJhuDygoTXBs3yxXW8vwKKPHutWRu54aKB2eptp4HLyh2pXfqel5tlo+cJ+rA
 zCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760726871; x=1761331671;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CcU4x6T33w+bruywnpNnmRVtUVwnr6OWT0dyPBHiY3s=;
 b=s1KXcJhRC7klC3nWoXN00cvHaeIIR8/lx2PeddFSMMO2TkuxkCp5w/r/sI4QFsvYO7
 GSdT3eq2pyX7wXm7pUyqX7MgenTDubDQRidjFLQZXNth/uKECuHuXZBOlMJuz5/u7UZr
 BPd/T0A54mHcRalc7BSMEJOZuDnthggmuQ/ySHIQiKHcZofya7i0yisiCfX3EgNPU379
 kihUUe2uS4B4AgOkZXgB4b5kQlNSUw46S3BxMoa/urVWeocJvkt1pQYS1WoWm0xNl+BR
 e0ZnDHZ+CfenEuY1qGG/qvxMIhwOnLemug5ckVmMflxIvRYy9zbsKnNweFPddmvDcurM
 kQNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQWLKWP/kLTOCPjDiKu2IEgJUid2CERREmeJo6eR6dhBW1diilQQTYRCU5hQS+PTICosuXzwDMIxRD@nongnu.org
X-Gm-Message-State: AOJu0YwBrQtnhk5p1VFVyPrIlgb3zE2wnKUadG0Xi7iIYMTRRGIZT4er
 BP+gLmW0HzZiL9/i2AoRmduYA7muuUrNbXI7VAeqJzMetgg5nwBZRZ+Yq3pTNIu2/tg=
X-Gm-Gg: ASbGnctEb+W2C0omUxmoZrrOupUA/gNZFeRiW97j9CdBiKfrRDLmpfUghr0+oFLKwN7
 YryKRLLruR+YhbD/U9ht3cRYdjQqe6PgFXBLX7MiBWi8u+8fN3Cs92qp/pmPxEKAEOxH/KoKFS6
 x5MQ6iBzD17TcYV4WZdNtI0rHNx/2HdHSqcnxar/LHampxEOmYnnI6tnPFCXkR2oqPt8eE0kqHT
 bAR84q9DckuyTrQTVt2r9bJMHpeAdaOVnwRW/dw+t7y+Yqn3HA+XdEMhk1fYlO/Tl8NlLL1CT5G
 vztdHZUiAf+75fDMVlC4+0MSxb2bT/ZsfTnCeMIJa9ndcydNGKk5nb/2Qmb9pCPzbQli8e6XCt0
 xeHi3dNpeEsedy8xrl7I749IbUqwENPHkwuWBxRE+9A5r5MPQrDtOzrFV9kaIYy+MM9hJvQ1CrW
 HYyKevKdrUVLL9rT8dTp3R/JOt20aJQYMuyvM=
X-Google-Smtp-Source: AGHT+IHBnGfG7khLKP1s0RApRldK06v5hN/ruWQhJGpH50QRFlAvNpQOQfONaYaPVTmS8VDZDPtYcQ==
X-Received: by 2002:a05:6a00:23c5:b0:781:1550:1ac7 with SMTP id
 d2e1a72fcca58-7a220a6086fmr5423361b3a.6.1760726870779; 
 Fri, 17 Oct 2025 11:47:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff38d30sm287894b3a.29.2025.10.17.11.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 11:47:50 -0700 (PDT)
Message-ID: <8f0db5c1-f20b-4b7a-8d6c-76ce7ec7b4e0@linaro.org>
Date: Fri, 17 Oct 2025 11:47:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target-info: Introduce runtime
 TARGET_PHYS_ADDR_SPACE_BITS
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 Song Gao <gaosong@loongson.cn>, Helge Deller <deller@gmx.de>
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-4-8b416eda42cf@rev.ng>
 <673e3c7b-b8ef-4908-b74d-62203b131229@linaro.org>
 <7jzcbl2yqkssu5lshz4umayaesoxwg3gcskrrkobc37df2p4z2@s26yst4mfxoe>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7jzcbl2yqkssu5lshz4umayaesoxwg3gcskrrkobc37df2p4z2@s26yst4mfxoe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/17/25 09:11, Anton Johansson wrote:
> Hmm you're right looking at git grep -C1 TARGET_PHYS_ADDR_SPACE_BITS
> (output below excluding the hw/riscv change in the following patch),
> there are really aren't that many uses left and none in common code.
> 
> We still got to move it to a runtime value somewhere though, what
> would be a more suitable location?  Maybe as a field in CPUArchState or
> some parent QOM machine as only i386, hppa, loongarch, riscv, alpha
> actually use the definition.

A fair few of these are arguably wrong.


>    hw/loongarch/boot.c:    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>    --
>    hw/loongarch/boot.c-    *kernel_entry = extract64(le64_to_cpu(hdr->kernel_entry),
>    hw/loongarch/boot.c:                              0, TARGET_PHYS_ADDR_SPACE_BITS);
>    hw/loongarch/boot.c-    *kernel_low = extract64(le64_to_cpu(hdr->load_offset),
>    hw/loongarch/boot.c:                            0, TARGET_PHYS_ADDR_SPACE_BITS);

This is cpu_loongarch_virt_to_phys, and some repetitions.

This should probably use a loongarch-specific runtime function to find the address space 
range supported by the chosen cpu.  Or perhaps just a target-specific constant mask.


>    linux-user/alpha/target_proc.h-            "L3 cache\t\t: n/a\n",
>    linux-user/alpha/target_proc.h:            model, TARGET_PAGE_SIZE, TARGET_PHYS_ADDR_SPACE_BITS,
>    linux-user/alpha/target_proc.h-            max_cpus, num_cpus, cpu_mask);

This is the alpha-linux-user implementation of /proc/cpuinfo.

Ideally this should be a target-specific function; see

/* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
#define TARGET_PHYS_ADDR_SPACE_BITS  44

It's certainly not generic, and it's also not really important.

>    --
>    target/hppa/mem_helper.c:    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
>    target/hppa/mem_helper.c:    return sextract64(addr, 0, TARGET_PHYS_ADDR_SPACE_BITS);
>    --
>    target/hppa/mem_helper.c:        addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
>    --
>    target/hppa/mem_helper.c-    /* Ignore the bits beyond physical address space. */
>    target/hppa/mem_helper.c:    ent->pa = sextract64(ent->pa, 0, TARGET_PHYS_ADDR_SPACE_BITS);

Similarly

/* ??? PA-8000 through 8600 have 40 bits; PA-8700 and 8900 have 44 bits. */
# define TARGET_PHYS_ADDR_SPACE_BITS  40

While we don't actually name concrete cpu models, bios advertises the (32-bit) HP B160L 
machine, which originally had a 7300LC, and the (64-bit) which had a 8700.

I can't find definitive documentation, but I suspect the 7300LC has only 32 physical 
address bits.  And according to our own comment we get the 8700 value wrong.

In either case, it's not exposed to generic code.

>    --
>    target/i386/cpu.c-        if (cpu->phys_bits &&
>    target/i386/cpu.c:            (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
>    target/i386/cpu.c-            cpu->phys_bits < 32)) {
>    --
>    target/i386/cpu.c-                             " (but is %u)",
>    target/i386/cpu.c:                             TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
>    --
>    target/i386/kvm/kvm.c:        QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 52);
>    target/i386/kvm/kvm.c:        assert(cpu->phys_bits <= TARGET_PHYS_ADDR_SPACE_BITS);

All of these are simply making sure that cpu->phys_bits is "in range", which is now 
irrelevant because TARGET_PHYS_ADDR_SPACE_BITS itself is no longer in use.  They can all 
be removed.

>    --
>    target/i386/tcg/helper-tcg.h:QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);

Likewise.


>    target/loongarch/internals.h:#define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)

This is used by target/loongarch/tcg/tlb_helper.c.

I'm not sure what the implications are.
Should it be using a common function with the loongarch boot virt-to-phys?
Is it re-using TARGET_PHYS_ADDR_SPACE_BITS just because it was convienient?

In either case, it's not exposed to generic code.


r~

