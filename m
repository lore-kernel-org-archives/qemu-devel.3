Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB929ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngaW-0005XD-QY; Mon, 09 Sep 2024 11:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sngaV-0005UR-Pm
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:45:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sngaU-0004MN-4h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:45:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso2616950b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725896756; x=1726501556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPaPLDSnMdnWanyjgDUo/IlvPiH1qii27WhbIBd+65s=;
 b=mUwXHkpootxfHb3NKtaQ401rnIwNILlJA9jne8ds1Kz/yoBjdudH91g17lUFYkY57f
 xN89qBw6q5l0ZQWhvmSS737aj+4jEbz2WFcgJJeuXl9MdOo+lgN0rCKN3Nzps2mruB8U
 7RSjQTF9RJt08ym1Rlz7gGq1kH2iTlC1XpASjbTeyVFHP41SsjmA/Gj9PawxbLpOdllD
 y7GsZUwWPLFCwWXt/h09e1I522f+7lP9p3INW34pTA0NcNJc7UP0bH+qWA4fe+E8fIIQ
 4VT7IDA5H8jRmY1yeekmyLKVnD1IJigUU0Kt8zEcA198gB7vkg5wsQgsUWhMVu/hF40J
 XUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725896756; x=1726501556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPaPLDSnMdnWanyjgDUo/IlvPiH1qii27WhbIBd+65s=;
 b=Onl4Mvxfk5XaK6pIjGJncsd2fnObMk054fWo42Ld083PFEZ7E/9b6mbocHETZAE/GM
 JJGdj+bDAA9MCjz27lsoohqh133lOu64+qnxuNlBQYXIQP72q/JJnBVL2OwwpOT3j+fp
 fJhZ3uAj6DVYEk8JE6pS+/phZ6yEB6wh4dNU9FHb7ZogJOyPjLFsbE4FgofAOJwu3aMh
 9+pk1o71T1A6+VZsX3ZBnlzdhJ9zDes8AFsQMhkMKDAxumFmBX+zOztvD6jtgBCCtETi
 7OAqrOzHHp0gnRb2y1pqYM2rMD5MqnWKkAt8lwvFlL0dDRkpDuw2CNKmWqLjbnCaKBWt
 AXgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS1B3FkCWrZ6JSvtXOdZAfOXJxST/SPfT3gDqAwyJWwQP4h9PQ25A4uCJsujhf5aUmEBQqpygjP8du@nongnu.org
X-Gm-Message-State: AOJu0YwnVGsnusQcHmllL9dquQmxcrd5mVu4Rt/kaPKbq52SRhwYTamm
 1eaNqQW4jXxAJkSjS+NV7EmgVyjh6yyBaji8Xn5arUln4Bd0jRgZv1ra5h0Klxc=
X-Google-Smtp-Source: AGHT+IF6Qku9cCk9Cc8kyEt1IF0ZwgGVSDBF1x4yN09v2dsOxlvVNO80AMjVRoU/od43e+RvU9hwqg==
X-Received: by 2002:a05:6a00:4b51:b0:714:1e28:da95 with SMTP id
 d2e1a72fcca58-718e3fbe921mr13720553b3a.7.1725896756000; 
 Mon, 09 Sep 2024 08:45:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e5968a09sm3673287b3a.117.2024.09.09.08.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 08:45:55 -0700 (PDT)
Message-ID: <0475550c-53c4-4166-bb04-1ff21f5d11b9@linaro.org>
Date: Mon, 9 Sep 2024 08:45:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] util: Add RISC-V vector extension probe in
 cpuinfo
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-3-zhiwei_liu@linux.alibaba.com>
 <286685da-74e3-401a-afe4-fed0831fd97c@linaro.org>
 <5fc48f87-b233-40b9-a0e1-4de920d97957@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5fc48f87-b233-40b9-a0e1-4de920d97957@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 9/9/24 00:18, LIU Zhiwei wrote:
> 
> On 2024/9/5 11:34, Richard Henderson wrote:
>> On 9/4/24 07:27, LIU Zhiwei wrote:
>>> +    if (info & CPUINFO_ZVE64X) {
>>> +        /*
>>> +         * Get vlenb for Vector: vsetvli rd, x0, e64.
>>> +         * VLMAX = LMUL * VLEN / SEW.
>>> +         * The "vsetvli rd, x0, e64" means "LMUL = 1, SEW = 64, rd = VLMAX",
>>> +         * so "vlenb = VLMAX * 64 / 8".
>>> +         */
>>> +        unsigned long vlmax = 0;
>>> +        asm volatile(".insn i 0x57, 7, %0, zero, (3 << 3)" : "=r"(vlmax));
>>> +        if (vlmax) {
>>> +            riscv_vlenb = vlmax * 8;
>>> +            assert(riscv_vlen >= 64 && !(riscv_vlen & (riscv_vlen - 1)));
>>> +        } else {
>>> +            info &= ~CPUINFO_ZVE64X;
>>> +        }
>>> +    }
>>
>> Surely this does not compile, since the riscv_vlen referenced in the assert does not exist.
> riscv_vlen is macro about riscv_vlenb. I think you miss it.

I did miss the macro.  But there's also no need for it to exist.

>>
>> That said, I've done some experimentation and I believe there is a further 
>> simplification to be had in instead saving log2(vlenb).
>>
>>     if (info & CPUINFO_ZVE64X) {
>>         /*
>>          * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
>>          * We are guaranteed by Zve64x that VLEN >= 64, and that
>>          * EEW of {8,16,32,64} are supported.
>>          *
>>          * Cache VLEN in a convenient form.
>>          */
>>         unsigned long vlenb;
>>         asm("csrr %0, vlenb" : "=r"(vlenb));
> 
> Should we use the .insn format here? Maybe we are having a compiler doesn't support vector.

Neither gcc nor clang requires V be enabled at compile time in order to access the CSR.
It does seem like a mistake, but I'm happy to use it.


r~

