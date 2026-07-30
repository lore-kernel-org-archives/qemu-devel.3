Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7BEC55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTMW-0005GA-Gt; Thu, 30 Jul 2026 12:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTMT-0005BB-9i
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:11:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpTMQ-0003He-7t
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:11:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso958144b3a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785427911; x=1786032711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WdBTdzTo6w5Qyog+GbxjiYLOJ20vhmXsolLk0+ayY1k=;
 b=RLKP9aCyZ2jhxQco/i54oLAV6fffe3YXdo5Mptu7boIhcN8vtA1yJtNnITKz2Jtbug
 2DIZJMAiSGynQ/yLvRlrcPdPeoZ5FjlgEM4UIHuFSkCqPvLLLCUfxHmu2laTelFF6eWV
 uoHbsuWoM5EZ9UxbknLTB0/LNnrq4c8nsFSd+LEB0JZb/ukJawUwjxkb8JMH1KI6EkZn
 UU9ny/BvVU7s6xw9BFAZ8zMYF0hpy1IDMf3NIJPnqpiR4QOMHYj19J0Rca+vf0ZiEAVu
 D/fRjAo3AWtNDcPTLCCr7uit3NDGc+5W/G8CATODc44sPTugFdLbwuH1S2vrYOsqPt+0
 7EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427911; x=1786032711;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WdBTdzTo6w5Qyog+GbxjiYLOJ20vhmXsolLk0+ayY1k=;
 b=E5loxZ7CvTvLqI8owTjFq7bBUp3aNGtfR+eXHokJH+o8YrXs3H+QOJGWFPdPN6WSbN
 bXjtiXOXhU8dnQEY32Tag3l1+15Qtr/Edjfs7uVF9YXKYmKBkiUJJNBEphR2O85ICupf
 I8hfTEwuv6wWosdwH4pQrvwO3R2AlNUuSpGzb77EQvBpn/q7FvQlT7cDOHUqLhnhld5V
 i95+HM83Dbofpn7O3kzjAjyc/5fisF6X1mvmfBZpi0WEgjnJ7ND4b4AKMHwM/Up0Wz+E
 GbVNIbrO8j1SGSn2uU3s/eZ5+elbgSzCYED5Aub+gsCgSXJw+j5TAkecsU98rYRPhCB/
 cEqg==
X-Gm-Message-State: AOJu0YwwD4w1F2R4M2tELOiulpkTM5ZTtR60vmaP27cQAseMcd2+2Wgo
 BCQIhsZKLlx0/lJNPYr3/szyfGV7kBJIzsDzf625C9yL7WjKZz3rwYlhI508IGfdn9PRKMF065x
 6PqPb
X-Gm-Gg: AR+sD11wp4qm1KxByYwVriv+jRgoH8/m6RfTb+4fpnadFNaAqF0yJzuIR2UdFDheJ/e
 zqeg7a68HS6h4G0BEZY7IfVpW1dbcWVOtPuJN9feggXcoVus7/+pIStDlwoQNuvLIyoldgSOBTR
 VNHt9Z96dDasQXKvU31TDoi+ZWQIhWCLasQHmxLA6v6j3zcNdcWh6Xych+tBYlFJhkKKXAtvjS3
 3JqcHkjA0ga6D5kp3NL39VcXV+jxuwMdgOxIuGrI6ohyU0Cj3xndHO0fE3apiCiemOes4VAtX4F
 UM82bd7C1Ytknrt8yIILx35y+8IHm15714ZDZBQ17lWYADIlnxfstu8RaQRU935dFkOx4PYg7yV
 IFLO+qV6pIaX986jNl7BDNYrCmHZwKT//U7Y/bCkOYdktQMv25ZqGHtEepsFLNBVjRKYSJ2a1ld
 031b8ngB8IlCas4sU6QQNn3raGeslgri6njsFuQ9S77M+QQ6Y7hKaRxUNPqSK66qSDC43x0HIxQ
 ohWSGSQqKgVLRLgyZewvdo3+iD2hZjvSL2QweM=
X-Received: by 2002:a05:6a00:4ac9:b0:848:2ef5:50dd with SMTP id
 d2e1a72fcca58-84eca884981mr703344b3a.37.1785427911346; 
 Thu, 30 Jul 2026 09:11:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea03d3f16sm3378227b3a.59.2026.07.30.09.11.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 09:11:50 -0700 (PDT)
Message-ID: <741317bf-5f3f-4631-ab77-26ba6f80a251@linaro.org>
Date: Thu, 30 Jul 2026 09:11:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/50] tcg: Introduce tcg-global-mappings
To: qemu-devel@nongnu.org
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-4-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260730031025.12926-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/29/26 20:09, Anton Johansson via qemu development wrote:
> +extern cpu_tcg_mapping tcg_global_mappings[];
> +extern size_t tcg_global_mapping_count;

No globals.  All such data structures would be local to the translators, calling

> +void init_cpu_tcg_mappings(cpu_tcg_mapping *mappings, size_t size);

as necessary.

> +void init_cpu_tcg_mappings(cpu_tcg_mapping *mappings, size_t size)
> +{
> +    uintptr_t tcg_addr;
> +    size_t cpu_offset;
> +    const char *name;
> +    cpu_tcg_mapping m;
> +
> +    /*
> +     * Paranoid assertion, this should always hold since
> +     * they're typedef'd to pointers. But you never know!
> +     */
> +    g_assert(sizeof(TCGv_i32) == sizeof(TCGv_i64));
> +
> +    /*
> +     * Loop over entries in tcg_global_mappings and
> +     * create the `mapped to` TCGv's.
> +     */
> +    for (int i = 0; i < size; ++i) {
> +        m = mappings[i];
> +
> +        for (int j = 0; j < m.number_of_elements; ++j) {
> +            /*
> +             * Here we are using the fact that
> +             * sizeof(TCGv_i32) == sizeof(TCGv_i64) == sizeof(TCGv)
> +             */
> +            assert(sizeof(TCGv_i32) == sizeof(TCGv_i64));

Two identical asserts in 10 lines.

Such things are better with a compile-time assert using QEMU_BUILD_BUG_ON, however...

> +            tcg_addr = (uintptr_t)m.tcg_var_base_address + j * sizeof(TCGv_i32);
> +            cpu_offset = m.cpu_var_base_offset + j * m.cpu_var_stride;
> +            name = m.cpu_var_names[j];
> +
> +            if (m.cpu_var_size < 8) {

I can understand wanting to use sizeof in the macros,
but we can do better than that with

   .type = _Generic(((struct_type *)0)->cpu_var,
                    uint64_t: TCG_TYPE_I64,
                    int64_t: TCG_TYPE_I64,
                    uint32_t: TCG_TYPE_I32,
                    int32_t: TCG_TYPE_I32),

which will catch mistakes earlier at compile-time.

> +                *(TCGv_i32 *)tcg_addr =
> +                    tcg_global_mem_new_i32(tcg_env, cpu_offset, name);
> +            } else {
> +                *(TCGv_i64 *)tcg_addr =
> +                    tcg_global_mem_new_i64(tcg_env, cpu_offset, name);
> +            }

At which point you can use tcg_global_mem_new_internal.


r~

