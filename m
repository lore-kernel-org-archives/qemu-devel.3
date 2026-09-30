Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D479CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqZ0-0000LC-Qf; Wed, 30 Sep 2026 05:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBqYz-0000Kb-Av
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:25:21 -0400
Received: from mail-ed2-x2b.google.com ([2a00:1450:4864:33::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBqYx-0005p6-I6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:25:20 -0400
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ad795d5205so619852a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790760318; cv=none;
 d=google.com; s=arc-20260327;
 b=HHHdwJcQJqYyJqskMKG9YKRZl4Rq6h/cfFyTcKDNJsZJUTGVHufc7GkH23tpbOTyH3
 UEmgk/R9hZND+sUTKUzfzj3ZCj0nnyt/+mRdZOOAmlcWdFoFh6QKeFwRKj5vU8o8VvmN
 IS1ckaODAd4754GB805Nz7MhupggcdLyB7GmXw4ktu/SczRoofu9fomRW4o4oJJOwma1
 191kNLmJT8C5iBgYaQpSXCbE6DS9Xu7AaOTzEQxCtRMa6aYyDDMD0inocF06NngJgkZE
 FPUvVBDa+aRYrxT9s30zIa0hbKIIU9r4RnVPig5bRvXbUW3XW0Nv4gTOGv+gIjt7jnf4
 dOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=DjPVIhDRjXpMV55FoiRr5UtkH0uoDc2jlnBq+FQy1dw=;
 fh=egWSVmAxPkZ58xN0z2owM8pI8GXXLsp70UgBKNWuXJE=;
 b=My4GbYzjCEUn/ZVVJYaG0nvglagtp7SwbXpL+1FGpLEi7MUfVckLy1jnVWbGDHBFxN
 tY/0DYHg8KtBeS6l6yFXs8p/60JtsUqvuEku+/sSGnuQmlDGR/zjkgI41Y9MoL7pb04e
 rnfDuYpzIVpmCWkFy5WFsQ1hDvCZ+atq4BEDq5Gefuk54fwq0TUB+yjsTjsLdtqpLGDR
 s5L/AZ00a+o9zZG/TfFsFd1vo1TkgcySkS+RrZa6WHbE1fNo3YI03wRuWi69NPyPSNrd
 5WUTNByIo2sGwvka9WQCL7FfbNlZ2qWY3uCYc+b1rszOO6/PfbmmBWjiWXjLTdy16yb7
 YdPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790760318; x=1791365118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DjPVIhDRjXpMV55FoiRr5UtkH0uoDc2jlnBq+FQy1dw=;
 b=Zjv8UoR04Z0ED7CmsagXJcUYIbpnFYzT5UmIZ4WSEhVFtAoavpe63+Iv1rPgSOVad+
 kNzNxmsRZNb74XpV7tRbJHkKnAps8XUji5XAnmavvWrfwTwh8sYMgsxctoWbtGd43MmK
 O1T2pTMmVlhx+IFpn6CmZhQUaSOLByfrA0uTfR2zzorlb/3LqjSxANeo7flZUbMIgLY+
 Jmc0JbNeShM+FqyBH07ebSRXF+hdd66PfPpH0n8JKjqowVvUdpn58N5Lk4kJtiwkWoX3
 cLF+7l/BDWtFsIeewsXT8NZcrsNqdAz+Bhtp17CtD19tzUJsY7HPOfy5BiFwDxC99gxA
 vZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790760318; x=1791365118;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DjPVIhDRjXpMV55FoiRr5UtkH0uoDc2jlnBq+FQy1dw=;
 b=I79uYDXMIHdpPzz0FYXz84fxCmbOSvCP0ryLTCtrUcreuZ1UDNxMk+aPOP3x+EX36t
 uCrC3DnWcFLLTJLFWayYQOVTI0uAcStqjbnA/e0lHMLVWtYlQYeHGkVTy/+jV1peJSUx
 SUn/2mBkCbMGzRDvXafMXEt22cnt/ERhtJARE/v2oP0Kyt7Wx3mL8XUjV4l/qNUHtrz5
 MpWvt1R1djstoPDW4nJ0QQAJBNT4uOSUv+L9bvAgl1pyhcRss8SuB6FUoX1udISfORbB
 70XV41h8C/MDCyJ+SbpTKm/mRZaajsgsPIdjvt0V/r8i3Q8EzRfJOQHqXEtCp9MBUl9O
 KaeA==
X-Gm-Message-State: AFq9FYI/1+Udjnlwi/f76vKY+Tx7jWIJYuxLVVtlJeImGOdbhU+GkJae
 sD3sVm/0kfUs1qcrs1Ghz1IY/4S+sQUJiCB1XODX3HqK/FWECbcTPmUvpph/TIeiLF5yVb9fzJp
 ntBHZqdu7meR69bVwapIYrJmP0S+0FX0=
X-Gm-Gg: AYBFou2Rie+7CPNMnuqgKlJlyxa3vnYH2k0+2BShnRPTo1xB7yTdWZ4skNpLvmfUbD9
 4Mgq0cn8frvK/Kj+LXkbyQhscbLBE5fw63Q0ybWjWOUf2an4eV4+0hPc0a0w+fzX8/ByLHblfAz
 /Y7fgbq2Irqu2npJYU+KyfwCw5i32MYqwxHALP7wf0+5K6TtNJC2/IiOMuNudyYG9R+R5m+GlPy
 kQdNCCdvFdSb8dbGG214y30TEUcFGG6BOagm9ZvfEcAWgru05Xv3e1vkYFm5BtryRsWcE7w09fp
 z9xHp3RmT1Y161uYK0qZd0pyxk6s04xOJX/fno+79P1PfGtDkoT8HlXxBdHIyxj4zw==
X-Received: by 2002:a05:6402:4001:b0:6aa:f1d2:ddc6 with SMTP id
 4fb4d7f45d1cf-6ae199096c4mr411686a12.20.1790760317542; Wed, 30 Sep 2026
 02:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260930072033.603-1-luoyonggang@gmail.com>
 <43ac1d16-25a6-4745-8919-af1d7985a1b3@oss.qualcomm.com>
In-Reply-To: <43ac1d16-25a6-4745-8919-af1d7985a1b3@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 30 Sep 2026 17:25:05 +0800
X-Gm-Features: AclHuK8SIwTrTX-tRXLpg8V0MorN-wERbdcAwBHQf-8ty1Kx8_a4JEfIY3J52yM
Message-ID: <CAE2XoE_=8B9-fPxFeuWpK7VwWCSq2iPLGurs8u85pUe1ViFvNA@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: use vaddr for wait PC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::2b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 30, 2026 at 5:10=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 30/9/26 09:20, Yonggang Luo wrote:
> > Pass the wait-instruction resume PC as vaddr through the helper
> > interface and implementation.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   target/hexagon/gen_tcg_sys.h | 2 +-
> >   target/hexagon/helper.h      | 2 +-
> >   target/hexagon/op_helper.c   | 8 ++++----
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.=
h
> > index af5032214c..de66b85b49 100644
> > --- a/target/hexagon/gen_tcg_sys.h
> > +++ b/target/hexagon/gen_tcg_sys.h
> > @@ -80,7 +80,7 @@
> >   #define fGEN_TCG_Y2_wait(SHORTCODE) \
> >       do { \
> >           RsV =3D RsV; \
> > -        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
> > +        gen_helper_wait(tcg_env, tcg_constant_vaddr(ctx->pkt.pc)); \
>
> Just curious, why tcg_constant_vaddr over tcg_constant_i32?

because "pc" is more like an addr than i32, if the hexagon is i32 only
then i32 is fine. but addr is still easier to understand(pc is an address).

>
> >       } while (0)
> >
> >   #define fGEN_TCG_Y2_resume(SHORTCODE) \
> > diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> > index 71c8da4c46..18cff7f4d2 100644
> > --- a/target/hexagon/helper.h
> > +++ b/target/hexagon/helper.h
> > @@ -136,7 +136,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32=
)
> >   DEF_HELPER_3(setprio, void, env, i32, i32)
> >   DEF_HELPER_2(start, void, env, i32)
> >   DEF_HELPER_1(stop, void, env)
> > -DEF_HELPER_2(wait, void, env, i32)
> > +DEF_HELPER_2(wait, void, env, vaddr)
> >   DEF_HELPER_2(resume, void, env, i32)
> >   DEF_HELPER_1(resched, void, env)
> >   DEF_HELPER_3(modify_ssr, void, env, i32, i32)
> > diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> > index 4f00ca773f..0785f1a127 100644
> > --- a/target/hexagon/op_helper.c
> > +++ b/target/hexagon/op_helper.c
> > @@ -1741,7 +1741,7 @@ static void set_wait_mode(CPUHexagonState *env)
> >       SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_ma=
sk);
> >   }
> >
> > -static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
> > +static void hexagon_wait_thread(CPUHexagonState *env, vaddr pc)
> >   {
> >       CPUState *cs;
> >
> > @@ -1768,7 +1768,7 @@ static void hexagon_wait_thread(CPUHexagonState *=
env, uint32_t PC)
> >           return;
> >       }
> >       set_wait_mode(env);
> > -    env->wait_next_pc =3D PC + 4;
> > +    env->wait_next_pc =3D pc + 4;
> >
> >       cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> >   }
> > @@ -1836,12 +1836,12 @@ void HELPER(resched)(CPUHexagonState *env)
> >       resched(env);
> >   }
> >
> > -void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
> > +void HELPER(wait)(CPUHexagonState *env, vaddr pc)
> >   {
> >       BQL_LOCK_GUARD();
> >
> >       if (!fIN_DEBUG_MODE(env->threadId)) {
> > -        hexagon_wait_thread(env, PC);
> > +        hexagon_wait_thread(env, pc);
> >       }
> >   }
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

