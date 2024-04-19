Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73C0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 10:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxlNQ-0004b6-CV; Fri, 19 Apr 2024 06:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxlNL-0004aP-3b
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:21:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxlNG-0007Ur-De
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:21:44 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so2034105a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713522098; x=1714126898; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCZAOLBvSmklkFZaOqYrqhu+QHELLWX95ASqLLV8uxA=;
 b=nZpxTf6bbV5MgeBj7Ji9VqmsgcsxKD2kGkCSPF01fbQ8cVlFkMFvaQqIiQWxQRkW8r
 +xVeb1O2err6yNnWoZmiy8uiCtmDrsLL0PAcZVw15JpGPafpOgHS4UncZOtQVBUpkpHx
 rkqUZnThHpAJELMsN7eK7GNZZYpju6ePSU28ezmFwxm7q4smI3FHDk5+g9ZHrJ7oRHGr
 UEcmy4D3HmN58domrZOoGyBDcVNHvT+FzIyTDHB/dUI5Jxr2NGnJUyFsh6rOsF4tV8TE
 zIcsOKLD8YsyWpAHoT/rA9XC3tqHdZ95DVYqVUfp21D/r0XAPEX5zkMLlNhOlVZ1dl/d
 ZKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713522098; x=1714126898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCZAOLBvSmklkFZaOqYrqhu+QHELLWX95ASqLLV8uxA=;
 b=gQsPoCdq16XUVZxLsrb9GLhKeVpi93jefd0SbpoOTewECmjvbtWA7aIiw4lJ5vBRo1
 dFro8bNIC+EevJh3DO3mJWoSIKiPr8m3zyxoHmkdhh4oDT9q2hmSueduaW8AAkpfdFQP
 7u18pRabE+JIiSus0Eutu5Mhg2jyrY/9ijRngjJ/wAKptogPL8De1424+JQvep3crbBB
 WGyO29xqF2ULIGaTG34JNlnh8Mu7IPYPnWHaulZoWsUqRTqti00u0QaQkWWrHxvDe/8y
 9w2igqrhqFv6sBRsYZe63HF6x9vQysDP18ddEAO117NUs0sWKvhzh9J4mhROiDmXiMd1
 dvTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCFHWI8MS+2MG/wIBhmrgQG3OPVwZWwhXBRiCcfSMdZVJWU0O/i7V1sgd+JQUKPw1pMkofgK9JNsQFdigHoIcGpxgN89I=
X-Gm-Message-State: AOJu0YwmzFBiWQ3Bk9AxOznWH1I485bT9eR6F3o2hJ0we7fjodEQC6OI
 qAp+4Wx7NM0IxGqgmsaWcTnkgVUsIpaTIuzSR0qV1WXi0+JTL/j1Hk2fjQlm27i192l5h9sxa2l
 65w/84LVGC1N4NL3gQ0bHafcj8hS1bQ7YHTR8WA==
X-Google-Smtp-Source: AGHT+IGCltBe0h4IXI8qKT3rtDdXXzmixgwNo0FgcWGWnZxoPPz5e738jLRaDnq6iMWILAZq96d6a61z7LuDNTgJW0g=
X-Received: by 2002:a50:d781:0:b0:56e:22b6:d924 with SMTP id
 w1-20020a50d781000000b0056e22b6d924mr1254676edi.13.1713522098154; Fri, 19 Apr
 2024 03:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_Q86TH19xZMT=gtRwL-ABook5NAFTgcGjfnfcqhgnwCw@mail.gmail.com>
 <5b29a661-1e37-4a90-8871-983d07094b69.jiangzw@tecorigin.com>
In-Reply-To: <5b29a661-1e37-4a90-8871-983d07094b69.jiangzw@tecorigin.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 11:21:26 +0100
Message-ID: <CAFEAcA82fjAT7Dh2x4i+UM3bvkWJpSCH8a-tH4KJc82_hfA-_A@mail.gmail.com>
Subject: Re: [PATCH] tcg: Fix the overflow in indexing tcg_ctx->temps
To: =?UTF-8?B?5aec5pm65Lyf?= <jiangzw@tecorigin.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, pbonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Fri, 19 Apr 2024 at 10:37, =E5=A7=9C=E6=99=BA=E4=BC=9F <jiangzw@tecorigi=
n.com> wrote:
> Peter Maydell wrote:
> > I feel like this might be a bug elsewhere. Can you provide
> > a repro binary and command line?
>
> The test file has been attached with RISCV CBO instruction as the first i=
nstruction to execute, with command-line arguments as
> ./build/qemu-system-riscv64 -M virt -smp 1 -nographic -bios crash_test.bi=
n

It looks like you're building without --enable-debug. If you do
that then you'll find that we hit an assert in the debug version
of the function, which your patch doesn't touch:

#6  0x00007ffff4b90e96 in __GI___assert_fail
    (assertion=3D0x55555639a508 "o < sizeof(TCGTemp) *
tcg_ctx->nb_temps", file=3D0x5555563995d5 "../../tcg/tcg.c", line=3D1940,
function=3D0x55555639c000 <__PRETTY_FUNCTION__.60> "tcgv_i32_temp") at
./assert/assert.c:101
#7  0x000055555613104c in tcgv_i32_temp (v=3D0x0) at ../../tcg/tcg.c:1940
#8  0x0000555555d0882b in tcgv_i64_temp (v=3D0x0) at
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/tcg/tcg.h:638
#9  0x0000555555d0c17b in gen_helper_cbo_inval (arg1=3D0x2a8, arg2=3D0x0)
at ../../target/riscv/helper.h:121
#10 0x0000555555d7be65 in trans_cbo_inval (ctx=3D0x7fffef1c8e50,
a=3D0x7fffef1c8cf0) at
../../target/riscv/insn_trans/trans_rvzicbo.c.inc:48
#11 0x0000555555d41f4f in decode_insn32 (ctx=3D0x7fffef1c8e50,
insn=3D8207) at libqemu-riscv64-softmmu.fa.p/decode-insn32.c.inc:2332
#12 0x0000555555d925f1 in decode_opc (env=3D0x555556d53e30,
ctx=3D0x7fffef1c8e50, opcode=3D8207) at
../../target/riscv/translate.c:1165
#13 0x0000555555d92ab4 in riscv_tr_translate_insn
(dcbase=3D0x7fffef1c8e50, cpu=3D0x555556d51670) at
../../target/riscv/translate.c:1236

This happens because we've been passed in 0 as our TCGv,
which isn't valid. That in turn is because trans_cbo_inval()
does:
           gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
but a->rs1 is 0.

The comment in riscv_translate_init() says:
    /*
     * cpu_gpr[0] is a placeholder for the zero register. Do not use it.
     * Use the gen_set_gpr and get_gpr helper functions when accessing regs=
,
     * unless you specifically block reads/writes to reg 0.
     */

trans_cbo_inval() doesn't do either of those things, so that is
where your bug is.

thanks
-- PMM

