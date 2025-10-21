Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5066CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEDh-0003fF-1q; Tue, 21 Oct 2025 11:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEDe-0003dY-Vp
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:24:14 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEDc-0003Py-VK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:24:14 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63b710f276fso6097006d50.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060251; x=1761665051; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c6gj7TDArST1viB6v94swNtLzYxWbfMUUIMQ2jCTgK8=;
 b=ngvLCls8KnqdTurMseuSk/BjugNQ3v5WPGg1Yx+7Td/j8dNmqHXPtqOEeJSNgmC6T0
 soLIZFYC5tSd3QLgBQ1s5WQ2VfaCrpwjhDRzq7LeYr07d/TP5IXQ2FUvJ7iBtmfoI5vo
 pBKgSXj6KCdvHiPGO4mTIUvzfCe1FpYqufIGoBkXXGFk/5XSuC52CKonQitm7Q+8MgUT
 UVj2GIVVv9bBE789CYhTtQ2mHYDl1vGQDdEkq9QIrUmhY8Nh9BHapM55YQc6u7nqVXD/
 cMntZuyCq1Nx7Nat6RS1aJ3PMSWUv1QeXiHdm9wr8+UTNQgID+j4nJ699/Aq9M6c33qP
 3Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060251; x=1761665051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6gj7TDArST1viB6v94swNtLzYxWbfMUUIMQ2jCTgK8=;
 b=nAfh2DSm/hGQEfTe9M7/X5nrcKokyAip44xt90wUuPC9kmktDf2I/5q45KwILBQjZs
 oj6B6NeKORap+HZWhCf5jZT+cIOYGDzpiLfsuXALMssVuV1pAk5E8ZIj7f5zfNwi1vH3
 l+V4ZVHMjSSh8ssDvvbaUT+VEtBVmKHxImgrSMNhCjI/X0kCKJcVqPoZWf0yAEaRSBT6
 nwxiOO/Vx3ZklFn6AzjwOcqro+24XmnA1618yP0iRMGJlRyAR8YJ2tgOOevY3BvL3OJf
 ZHxnUQJ+/zQehLAoNzh/xhDQh22yAvXEj3nKyZr0hoJRkVh8Teut8pRXgvIrDGsOZMH8
 Yi1Q==
X-Gm-Message-State: AOJu0YwH0zcXjuNJ3AHqG9LyKtDWkZ9/27ea7uGVlkqkMpzkWm4gH0J6
 a/w4pACfpS/eSqVHbhN7StNPWxyZ1nx9X2JpXZTvlXFAkhW1gTss5WmrrcI0s7KiPTc3dEZtDhK
 JYB03q2Y5+qKoFcqA2O3li5v4frIRUHw1L6d3ET89a0sGLRNiZJtN
X-Gm-Gg: ASbGncvq9Iio8ywPEFQbRTxzAI5hGfzzu6CnY37LQW8d0S3UDXoup8RlHuYyWBd+5By
 w4JCd2Uvt+c0nimmzKqaChccba4ojF81d0tYRfnh8PZEkv92G0aT67ksSWIJJxbewqCRo947hcl
 9scfsxxAQ4s8CUHkWXDw9uJ9Hj7e44z2zjQlY6Je0ZB823mj4pBTrUDtLcaGdDoq18kIewn1je5
 b/w5uIDn+G0I6chExBhm6wB07C8RMkPZvdn6ZrbJFqJzzfOjYg97mJX3beiliRa+oikmvdD
X-Google-Smtp-Source: AGHT+IGgsnDEHOYCZI9tu1XUpktqtwmiHAubJ7Mi7ZQPsVYUrJ7xJRuhHJuVUdjwYSCAwauaSjifQ7U+Vebd5e87bk4=
X-Received: by 2002:a05:690e:144c:b0:63e:3084:4809 with SMTP id
 956f58d0204a3-63e30844b2fmr8287285d50.33.1761060250809; Tue, 21 Oct 2025
 08:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
 <20251003032718.1324734-5-alistair.francis@wdc.com>
In-Reply-To: <20251003032718.1324734-5-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 16:23:59 +0100
X-Gm-Features: AS18NWCI5tTm9tcZ7EOzrV7BT6pD2cIxi8MfcmtS6Gd-z_4J6dR0_0mXaIHsCQ4
Message-ID: <CAFEAcA_y4bwd9GANbXnpTy2mv80Vg_jp+A-VkQS5V6f0+BFRAA@mail.gmail.com>
Subject: Re: [PULL 04/26] target/riscv: implement MonitorDef HMP API
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 3 Oct 2025 at 04:29, <alistair23@gmail.com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> The MonitorDef API is related to two HMP monitor commands: 'p' and 'x':
>
> (qemu) help p
> print|p /fmt expr -- print expression value (use $reg for CPU register access)
> (qemu) help x
> x /fmt addr -- virtual memory dump starting at 'addr'
>
> For x86, one of the few targets that implements it, it is possible to
> print the PC register value with $pc and use the PC value in the 'x'
> command as well.
>
> Those 2 commands are hooked into get_monitor_def(), called by
> exp_unary() in hmp.c. The function tries to fetch a reg value in two
> ways: by reading them directly via a target_monitor_defs array or using
> a target_get_monitor_def() helper. In RISC-V we have *A LOT* of
> registers and this number will keep getting bigger, so we're opting out
> of an array declaration.
>
> We're able to retrieve all regs but vregs because the API only fits an
> uint64_t and vregs have 'vlen' size that are bigger than that.

Hi; Coverity complains about these functions
(CID 161401, CID 1641393):

> +static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
> +                                 target_ulong *val, bool is_gprh)
> +{
> +    const char * const *reg_names;
> +    target_ulong *vals;
> +
> +    if (is_gprh) {
> +        reg_names = riscv_int_regnamesh;
> +        vals = env->gprh;
> +    } else {
> +        reg_names = riscv_int_regnames;
> +        vals = env->gpr;
> +    }
> +
> +    for (int i = 0; i < 32; i++) {
> +        g_autofree char *reg_name = g_strdup(reg_names[i]);
> +        char *reg1 = strtok(reg_name, "/");
> +        char *reg2 = strtok(NULL, "/");
> +
> +        if (strcasecmp(reg1, name) == 0 ||

Coverity complains because we call strtok() to get reg1,
and that might return NULL, but strcasecmp() wants a
non-NULL pointer.

Similarly with the use of strtok() in reg_is_u64_fpu().

We could fix this with an assert(reg1) since the
names are compile-time fixed and it would be an error
for the string to be empty.

But taking a step back, strtok() isn't thread safe.
Maybe we should use g_strsplit() instead ?

More speculatively, do we need to care about locale here?
strcasecmp() does a locale-aware comparison, which is
probably not what we want. (Notoriously Turkish locales
don't have the upper/lowercase mapping you would expect
for "i" and "I".) glib has a g_ascii_strcasecmp() which
might be helpful here.

> +            (reg2 && strcasecmp(reg2, name) == 0)) {
> +            *val = vals[i];
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}

thanks
-- PMM

