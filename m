Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2939EE98FC9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAimS-0004QS-2r; Thu, 09 Apr 2026 02:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAimQ-0004Q2-SM
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:22:18 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAimN-0001jQ-6p
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:22:18 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c62fc8debso71931166b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 23:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775715732; cv=none;
 d=google.com; s=arc-20240605;
 b=Le/FOhtS/RuaN3lbU8xCDAfAdKfINXYX7mB6YMJCveSJ+I8Ag3hmmoKHGdaysTra6s
 xNVjoUSsNGz0lZhmbfZr8BKInTz/IeRcxfnsVCaOSIHJ14SSSu8hrfcf551884pyFUfx
 qgt2E90XwimdpjyyqttnbSVEkf/ir7JnSlIMBbm+yIXkDPj7TAEZ5fqDYYkUj6ITjzjc
 NEOpe/Q5pxP3xTqBQB5G0hITilHT3dySdXL/4L98uz49i+LEr6uFIMo2BaYsNuUeLJqZ
 rZN81i54WDkIesD2FC8lPtpkjff9fX+M8halgsq7Y6FZhOhmedDxYCfuCMGur0xxsxBm
 Yxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8b0jRRyQRDVCpBwwEfzo+y0uMImwWFs5zaalBIgQABM=;
 fh=xT4R8q+AjyMPFvvOm6TQTX0erloV1XpqMDrcZhQnTKA=;
 b=gFLZ25y2y0WA0fhEQ5I+HSNAixmIrAMhf6vQeLXaxEv8kZd3xTOL/9STbCY3dk62UP
 dhOh+I6Gp62Vlya8tkNvKKFmUOQ/ey7+5y2MdepTUDH0k8Df7rlKkpPQYkZHNG1alPOQ
 1ZUmcML4OKZun8qYdiCaRXL8ftilqS98HlbPtCgZ1GHzdBJT1Q4H3nIg9AlTLkQX54G8
 NufpoQVClENDXUfyUpO+6tPQ7ZS354QaHxq4XGDfEjjViwaOmthKYeB8p8arjLq9a9Hp
 oM4bznTqGInOXaTjN8JHc6jvY2NNDMZfMveWVbg3l+DrCQxSgn+a+lJhy4OR9A8JhmL5
 v7Og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775715732; x=1776320532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b0jRRyQRDVCpBwwEfzo+y0uMImwWFs5zaalBIgQABM=;
 b=gKXx4AT5a75dDpRerCyPf8fD6V6aTjl3VFFgWB5vJqW5h4qq/RdlLYcNlQ+KQUGday
 BZkBep73Z2pKqgS2Yo9HtIrtIg84X54owcmxdV/1NLGfNQTt3tdYv6j/UpCYtYq7OKt0
 HVDNRF5hhqn+ppWRjk1D72rjY8+lwj8vAmU7KELljGsRlGpi5iDzCVsO7a+wJz1F9jM7
 8lDPwgxdmVwZon6vD3upxqPrfzTTeiLATDtxAxNjKmUOTQJZKTH0twuQ3iASncPMrMum
 oY2V24lHCJnZn1mBC5RxKAsGxSjqTuvl3LjSN8Ax0493WC9yxxYF+z49tQscrYjQ3DPT
 PFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775715732; x=1776320532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8b0jRRyQRDVCpBwwEfzo+y0uMImwWFs5zaalBIgQABM=;
 b=Ez4jkYrElWQFOnMpEEPia/0JGZtX8tcyUssBWsoVA3UF3k5qvbjCbnRt9Dd8PCyios
 XiM8ZCF7p5sFbzZFWM+1/D8qlXzq0ahVKbvMb+Gq5jf5Y5p51XruM9D/Sx/4P/ghuO9Y
 FGc2Y9ciQTpA5BOlv2ATtaZhw+7iKuCJQ7+Fu3eoAAs6GsFhW9y/BaOLEpQaU5zvFqLR
 Q+c/Q0/8jFPL4nFHCTBNUVlNH44T20hDt8aoz4ayiMFSbo8jz9jIZD1+3tlhSaB/Vi+e
 gUaxtY+2rIb2MVXVfTACgUt9Gtsx8Rx4yRg7Kr3ITIUjv4WeUCEz+aKa8WmdG8UwUIdG
 viCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOUQ1EmfKy/63qHeEWnLYbiGZd5zmAdfUbfvRQYAKbSv7xtz3w5mQX8FCtAOVf3IyKMXpYlkCIvTyB@nongnu.org
X-Gm-Message-State: AOJu0Yw9lmN5ZDXy3/NYSrh8SFf3iEBAGUk5w6agSCxfD0WoQQl+Oy2L
 UkPQ89wYT0x7C1Vv4H6rVb+CPXuMhiy6g0ii6AZkqlamtBr+q0duBW0nx4qmUUL53tCbOkfABji
 glRiffpnKjzn0OSDKcXnvfkM9ZxUcxi4=
X-Gm-Gg: AeBDies1sysFOMGFnrr43ImmgNjlqgI1rW5ftaOWunTGn5XKuK6hzbYbzPChtN4z8ZH
 x4AtydNMnFNrB7wJhpEJrYoZKOPjcnM0OjxfjfbDR3t5GTCffCioTf1rMGH1Rw7KXbUeNpii2sR
 +/NXYhG8JiSL3vB8Nd/VcFgNXOGRkPFpnfLgeTBddZfF891h2Ruq9ucHu8wKCWsHRIakJU5yevx
 nEDjyi3XbhgA+PXAiCnzNAYQ0ZuGBmprQQ6BMlvaaynAWIFacSy8ar30rbc46mm4GeYGo5L4Lvg
 NnE91wlG4oxr9h4Zn0cnEFHGMWD9xxRHSrN02w==
X-Received: by 2002:a17:907:3d51:b0:b8f:e98b:4952 with SMTP id
 a640c23a62f3a-b9d476bfe96mr108133066b.41.1775715731954; Wed, 08 Apr 2026
 23:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
 <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
 <09cf72c9-7333-4f1f-bb2a-bc88b668b294@linaro.org>
In-Reply-To: <09cf72c9-7333-4f1f-bb2a-bc88b668b294@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 16:21:45 +1000
X-Gm-Features: AQROBzCgW61uRy9XGxf1N5vGO5BALdj_f-tUsU_LqVhudpm7gEKjJM6n6PoYOOM
Message-ID: <CAKmqyKOP-69j14DiaWUbZSL-_5nytjgsDhXA6tmTVvLBzrxgSQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Apr 8, 2026 at 6:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 7/4/26 11:38, Daniel Henrique Barboza wrote:
> >
> >
> > On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> >> From: Alistair Francis <alistair.francis@wdc.com>
> >>
> >> The RISC-V spec states:
> >>
> >> "For the purposes of memory protection, a failed SC.W may be treated
> >> like a store."
> >>
> >> So if the comparison in sc.w fails we should still check for alignment
> >> and do a probe access to check permissions.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
> >> Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
> >
> > Typo: "Resoves"
> >
> >
> > Also, IIRC the bug URL that automatically closes Gitlab issues when
> > merging the patch is on the format:
> >
> > "Resolves: https://gitlab.com/qemu-project/qemu/-/issues/(number)"
> >
> >
> > Maybe this URL with "work_items" also works, but even with the regular
> > URL Gitlab fails to autoclose the bug sometimes.  I suggest changing th=
e
> > "work_items" to "issues" in all those URLs to be safe.
>
> FWIW I concur :)
>
> >
> >
> > That said,
> >
> >
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> >
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>   target/riscv/helper.h                   |  3 +++
> >>   target/riscv/op_helper.c                | 14 ++++++++++++++
> >>   target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
> >>   3 files changed, 23 insertions(+)
> >>
> >> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> >> index b785456ee0..af6cfcfc27 100644
> >> --- a/target/riscv/helper.h
> >> +++ b/target/riscv/helper.h
> >> @@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
> >>   #ifndef CONFIG_USER_ONLY
> >>   DEF_HELPER_1(ssamoswap_disabled, void, env)
> >>   #endif
> >> +
> >> +/* Zalrsc" SC write probe */
> >> +DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> >> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> >> index 6ccc127c30..b569366369 100644
> >> --- a/target/riscv/op_helper.c
> >> +++ b/target/riscv/op_helper.c
> >> @@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env,
> >> target_ulong address)
> >>       /* We don't emulate the cache-hierarchy, so we're done. */
> >>   }
> >> +void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
> >> +                           target_ulong size)
>
> We could directly use uint64_t for @size. Then after the release the
> @addr argument will be converted to vaddr type [*]. We could do that
> directly now:
>
>
> DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, vaddr, i64)
>
> void helper_sc_probe_write(CPURISCVState *env, vaddr addr,
>                             uint64_t size)

That fails for RV32 linux-user

../target/riscv/insn_trans/trans_rva.c.inc:97:40: error: passing
argument 2 of =E2=80=98gen_helper_sc_probe_write=E2=80=99 from incompatible=
 pointer
type [-Wincompatible-po
inter-types]
  97 |     gen_helper_sc_probe_write(tcg_env, src1,
     |                                        ^~~~
     |                                        |
     |                                        TCGv {aka struct TCGv_i32_d *=
}
In file included from
/var/mnt/scratch/alistair/software/qemu/include/qemu/osdep.h:53,
                from ../target/riscv/translate.c:19:
/var/mnt/scratch/alistair/software/qemu/include/exec/helper-head.h.inc:128:=
57:
note: expected =E2=80=98TCGv_i64=E2=80=99 {aka =E2=80=98struct TCGv_i64_d *=
=E2=80=99} but argument is
of type
=E2=80=98TCGv=E2=80=99 {aka =E2=80=98struct TCGv_i32_d *=E2=80=99}
 128 | #define dh_arg_decl(t, n) glue(TCGv_, dh_alias(t)) glue(arg, n)
     |                                                         ^
/var/mnt/scratch/alistair/software/qemu/include/qemu/compiler.h:29:21:
note: in definition of macro =E2=80=98xglue=E2=80=99
  29 | #define xglue(x, y) x ## y
     |                     ^
/var/mnt/scratch/alistair/software/qemu/include/exec/helper-head.h.inc:128:=
52:
note: in expansion of macro =E2=80=98glue=E2=80=99
 128 | #define dh_arg_decl(t, n) glue(TCGv_, dh_alias(t)) glue(arg, n)
     |                                                    ^~~~
/var/mnt/scratch/alistair/software/qemu/include/exec/helper-gen.h.inc:44:25=
:
note: in expansion of macro =E2=80=98dh_arg_decl=E2=80=99
  44 |     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))     =
    \
     |                         ^~~~~~~~~~~
../target/riscv/helper.h:1294:1: note: in expansion of macro
=E2=80=98DEF_HELPER_FLAGS_3=E2=80=99
1294 | DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, vaddr,=
 i64)
     | ^~~~~~~~~~~~~~~~~~
In file included from
/var/mnt/scratch/alistair/software/qemu/include/tcg/tcg-op-common.h:11,
                from
/var/mnt/scratch/alistair/software/qemu/include/tcg/tcg-op.h:11,
                from ../target/riscv/translate.c:22:
/var/mnt/scratch/alistair/software/qemu/include/tcg/tcg.h:202:28:
note: =E2=80=98TCGv_i64=E2=80=99 declared here
 202 | typedef struct TCGv_i64_d *TCGv_i64;
     |                            ^~~~~~~~
/var/mnt/scratch/alistair/software/qemu/include/tcg/tcg-op.h:32:18:
note: =E2=80=98TCGv=E2=80=99 declared here
  32 | typedef TCGv_i32 TCGv;
     |                  ^~~~

Am I missing something?

Alistair

>
>
> [*]
> https://lore.kernel.org/qemu-devel/20260401143456.79843-1-philmd@linaro.o=
rg/
>
> >> +{
> >> +    uintptr_t ra =3D GETPC();
> >> +    int mmu_idx =3D riscv_env_mmu_index(env, false);
> >> +
> >> +    if (addr & (size - 1)) {
> >> +        env->badaddr =3D addr;
> >> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra)=
;
> >> +    }
> >> +
> >> +    probe_write(env, addr, size, mmu_idx, ra);
> >> +}

