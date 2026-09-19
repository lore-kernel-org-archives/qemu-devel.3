Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE02C982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 21:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x82bG-0000gb-OF; Sat, 19 Sep 2026 17:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82bB-0000g9-BY
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:27:54 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82b9-0008D6-Bt
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:27:53 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f1b845so1572430e87.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 14:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853269; cv=none;
 d=google.com; s=arc-20260327;
 b=iEtgplVdWNGcqVOgvRGOtoQ9/RvHUyeVm85oxeW2G0/b2vxaMjQMrMpTUvNaBhxlG/
 EkO3xma2HtE+Su8W+dRRrDOWrnmJdkzn+uvZBrKMzQmlP9QhvWAwS5JeV7nDaZs1bkvL
 oVcd+OcaXsPpZ0EYrUaDeSGXyeMuJgyfkq0bW9XLiZiUgeFKLKeqFlJlsdQHcGp2zocj
 29DZwBbHmzpt80PZYInN1rAS9tAHppwR0DI+A9PiOey8dy3ib87vnqVa0S0Xx1VLNTM1
 Yle5S3ri5UHG6i+3xy1lAf+jv16JPbTU88IgFqLzhTYryL5mzciv2GXn3un8GBLQYmZY
 IojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WcytAA0pdyeULzpmKnNPIt79lEEG3cxKy2iAKEawNYA=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=HNWZMeSNGvI1WEj8Wv65FeLiZQDG6eDYzJbZPAtngb2gyzZakfNx4dg8O1a8shbPyP
 5Ra7db1PBD2iLYK7taoWYUq/GKaT5mjganuyAbP+QfEzn2X8Bwgsw3dR2FBFXwuYSUPo
 WGNb2oFCDoyIR3K+/MHkUFDhOeG6IB81Rgv4gdnOzqc4cVnqIC+G4VjrHdOheevkT6GI
 UwI9hU3lcDIHzgvwakbEbKaQHeLHyEoC/4BFxepHwBMox4bLqnL/m5BU9ANNLAHMp5a6
 6jbkie9JO3fa6GdPcBTBo1fw5NmQI3qXEWGNQ/S5ILgacLvrVfdOICc0/3llvNjF87Ae
 0IkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789853269; x=1790458069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WcytAA0pdyeULzpmKnNPIt79lEEG3cxKy2iAKEawNYA=;
 b=Z/jbOapEr+QzYxqB+xPBoCBgn0E9VDg3re2wM1dDKnByrWfHeFmGrjWW1QMiQGxQDG
 hj3IecjgAAJqLN2eL93PmlQAOMi4AmOZhkSwfBuraFcMwcwF6V0t8lrF01m537hJhzAu
 +WTg2ks4w8X7fxWMLU8zDK/iCAxSX1s8n7vQjPO6L8VbRAbGHE20o44hm5yDVZcXF9Ds
 Q/o1L5rH3mvZEyoFNLlKcMSoAVYr+Bo5unQT3y+cALWmDl6uSfZJamU1lYl1QMYMuaFa
 y+IuaXtO0yw7cuPkENswby6JmP+5ARrW55UVNtd/k71RF9c2x7LyDDrxyV7Bq21GmNpd
 iHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853269; x=1790458069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WcytAA0pdyeULzpmKnNPIt79lEEG3cxKy2iAKEawNYA=;
 b=ygAWaN8b6mNoDuOk1edWUtmqrAga3XgAJ81Xb7HUu9MeR5cWMW6x+3LGk9wrJnegOJ
 o/nKcjlCHiDZ5zPlysbEjY1YNuStXYxDka+JPN4hHp49nhJvQiiXH8gVeLU6lp1z41+P
 C8+Q8pfLZnL96j2Kh0K7dtuL/u5U0+cPbLA2sfTVraoPl08DhrHvN9PibawH+gHP8BJk
 4cWAowdBG6Csq9rkPQjgXUJXVRcgn6sRlEfknDEILVsOs3c18OHrXZeWqLr2Fbt9piH3
 5LPN2nwU5dYm/UVUe3IBoDfMoYrQEUq/wyMfT1lv7TVzMVlun8IGTXtOsh5rEmhukGIs
 xJsA==
X-Gm-Message-State: AFuF++klRErwBftqaw0eSpHXJXSuCiET3RL9oQL4pe4HzJ3TJQxZBauw
 Li1BK/UxwmVwb8dQhBPRPtw/yZBdW+Gn6vK9l1XvNRDK+F7yYWydnSvEELp7/1GDkq/NqOU9mkl
 Hw5fyUdlJO9zLRALux5CSPlSpYfXZrhDqzq0k1jQ=
X-Gm-Gg: AYBFou1BaDcGjbIkhWGXAPfbGzXXf1dlJc0ruAR4RIwEn//nhe6q0/jGYJHeZrDZcNO
 z/4AnKPNg8ImxoSDsL9FBilWEv4PGVsZwx1ihzxsXOZGHgdvSLdy/z2qpV9841fFersD13uYXY8
 mlulCKvUbxw+eQOgb4tXkXZZU2i04SvZx2OTEjiZ75t0YnDBIf+8R8Hux9OqTac9jrIzlPwNvxT
 GmITBBmM+vlaM8rVjDD51jFI55KYT4gV1Q7qp2dpFujwDO32NPaQJ5Lg71o/5JTf9VpJ5dmRmCG
 yHB+X6pq1khmxW2/Q6B+YtzNAOxpl4ccHFDzhaonWAW/bvZ0AYZxWSSZ/9ZzXplmXp6QAz0ocha
 ZmV6KKfUpPhac5w==
X-Received: by 2002:a05:6512:234e:b0:5b8:c05d:2ab5 with SMTP id
 2adb3069b0e04-5b8c18428acmr1725295e87.21.1789853269016; Sat, 19 Sep 2026
 14:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
 <20260917093307.1092084-8-richard.henderson@linaro.org>
In-Reply-To: <20260917093307.1092084-8-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 17:27:37 -0400
X-Gm-Features: AcwNN1W3tGqc_vGBpAWjYSn0CzWtdXx9Pw3n9uy-yXFPX7miqMf-NdgpgPxMDc4
Message-ID: <CAEdQ38HU8hML8u7rFTcD=05qKizHFw4A18sAXyov2VBrFU3ACg@mail.gmail.com>
Subject: Re: [PATCH v6 07/13] accel/tcg: add CF_NO_GOTO_JC, set while a
 breakpoint is present
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Sep 17, 2026 at 5:33=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Matt Turner <mattst88@gmail.com>
>
> The next patch dispatches a goto_jc by probing the TB jump cache from
> generated code. That probe cannot check everything helper_lookup_tb_ptr()
> checks, and the one that matters is breakpoints: check_for_breakpoints()
> raises EXCP_DEBUG on an exact pc match and selects CF_BP_PAGE cflags for =
the
> rest of the page, and inserting a breakpoint deliberately invalidates no =
TB.
>
> The probe compares the destination's cflags against the cflags of the blo=
ck
> doing the dispatching, and only takes the destination when they are equal=
.
> So a cflag is all that is needed.  Add CF_NO_GOTO_JC, set it in
> CPUState::tcg_cflags while cpu->breakpoints is non-empty, and blocks
> translated from then on both decline to dispatch inline themselves -- the
> next patch makes them emit the plain helper call -- and are unreachable f=
rom
> blocks that do, because their cflags no longer match.
>
> The two ends of the flag are cpu_breakpoint_insert() and
> cpu_breakpoint_remove_by_ref(), which are the only places the list change=
s.
> Both already run either on the CPU's own thread or with it stopped, or re=
ach
> another CPU exactly as cpu_single_step() does, which is where the previou=
s
> patch put the same kind of update.
>
> That leaves blocks translated before the breakpoint was inserted, which a=
re
> still live and still chain to each other. They do so on the old cflags, s=
o
> inline dispatch among them keeps working until the vCPU reaches its main
> loop, which then looks up with the new cflags and translates afresh. In
> system mode gdb inserts breakpoints with the vCPUs stopped, so there is n=
o
> window at all. In user mode the window is the one goto_tb chaining alread=
y
> has: a chained direct jump consults nothing either, and is not broken by
> inserting a breakpoint.
>
> Nothing reads CF_NO_GOTO_JC yet; the next patch does.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260901034808.3524945-6-mattst88@gmail.com>
> ---
>  include/exec/translation-block.h |  5 +++--
>  accel/tcg/cpu-exec-common.c      | 16 ++++++++++++++--
>  cpu-common.c                     | 25 ++++++++++++++++++++++++-
>  3 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/translation-block.h b/include/exec/translation-=
block.h
> index 40cc6990318..f3410dbcb93 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -76,14 +76,15 @@ struct TranslationBlock {
>  #define CF_COUNT_MASK    0x000001ff
>  #define CF_NO_GOTO_TB    0x00000200 /* Do not chain with goto_tb */
>  #define CF_NO_GOTO_PTR   0x00000400 /* Do not chain with goto_ptr */
> -#define CF_SINGLE_STEP   0x00000800 /* gdbstub single-step in effect */
> -#define CF_MEMI_ONLY     0x00001000 /* Only instrument memory ops */
> +#define CF_NO_GOTO_JC    0x00000800 /* Do not dispatch via the inline pr=
obe */
> +#define CF_SINGLE_STEP   0x00001000 /* gdbstub single-step in effect */
>  #define CF_USE_ICOUNT    0x00002000
>  #define CF_INVALID       0x00004000 /* TB is stale. Set with @jmp_lock h=
eld */
>  #define CF_PARALLEL      0x00008000 /* Generate code for a parallel cont=
ext */
>  #define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
>  #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
>  #define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page *=
/
> +#define CF_MEMI_ONLY     0x00080000 /* Only instrument memory ops */
>  #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
>  #define CF_CLUSTER_SHIFT 24
>
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 9f3517f36b6..9f9555e34f6 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -38,10 +38,11 @@ void tcg_cflags_set(CPUState *cpu, uint32_t flags)
>
>  /*
>   * The bits of CPUState::tcg_cflags that tcg_cflags_set() never sets, be=
cause
> - * they are derived from gdb single-step, one-insn-per-tb and -d nochain=
.
> + * they are derived from gdb single-step, one-insn-per-tb and -d nochain=
,
> + * or from various cpu parameters.
>   */
>  #define CF_DERIVED  (CF_COUNT_MASK | CF_NO_GOTO_TB | CF_NO_GOTO_PTR | \
> -                     CF_SINGLE_STEP)
> +                     CF_NO_GOTO_JC | CF_SINGLE_STEP)
>
>  void tcg_update_cflags(CPUState *cpu)
>  {
> @@ -62,6 +63,17 @@ void tcg_update_cflags(CPUState *cpu)
>          cflags |=3D CF_NO_GOTO_TB;
>      }
>
> +    /*
> +     * A block that dispatches through the jump cache inline does not co=
nsult
> +     * cpu->breakpoints, and inserting a breakpoint deliberately invalid=
ates
> +     * nothing.  Give blocks translated while one is set a distinct cfla=
gs, so
> +     * that they neither dispatch inline themselves nor are reached by a=
 block
> +     * that does, and check_for_breakpoints() gets to run on every dispa=
tch.
> +     */
> +    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
> +        cflags |=3D CF_NO_GOTO_JC;
> +    }
> +
>      cpu->tcg_cflags =3D cflags;
>  }
>
> diff --git a/cpu-common.c b/cpu-common.c
> index adb76b3a786..909f8d059b4 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -22,6 +22,7 @@
>  #include "exec/cpu-common.h"
>  #include "hw/core/cpu.h"
>  #include "qemu/lockable.h"
> +#include "system/tcg.h"
>  #include "trace/trace-root.h"
>
>  QemuMutex qemu_cpu_list_lock;
> @@ -429,6 +430,11 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, i=
nt flags,
>          *breakpoint =3D bp;
>      }
>
> +    /* The first breakpoint takes the CPU off the inline dispatch path. =
*/
> +    if (tcg_enabled()) {
> +        tcg_update_cflags(cpu);
> +    }
> +
>      trace_breakpoint_insert(cpu->cpu_index, pc, flags);
>      return 0;
>  }
> @@ -452,7 +458,7 @@ int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, in=
t flags)
>  }
>
>  /* Remove a specific breakpoint by reference.  */
> -void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
> +static void cpu_breakpoint_remove_by_ref_int(CPUState *cpu, CPUBreakpoin=
t *bp)
>  {
>      QTAILQ_REMOVE(&cpu->breakpoints, bp, entry);
>
> @@ -460,14 +466,31 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CP=
UBreakpoint *bp)
>      g_free(bp);
>  }
>
> +void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
> +{
> +    cpu_breakpoint_remove_by_ref_int(cpu, bp);
> +
> +    /* The last breakpoint puts the CPU back on the inline dispatch path=
. */
> +    if (tcg_enabled()) {
> +        tcg_update_cflags(cpu);
> +    }
> +}
> +
>  /* Remove all matching breakpoints. */
>  void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
>  {
>      CPUBreakpoint *bp, *next;
> +    bool removed =3D false;
>
>      QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
>          if (bp->flags & mask) {
>              cpu_breakpoint_remove_by_ref(cpu, bp);
> +            removed =3D true;
>          }
>      }
> +
> +    /* The last breakpoint puts the CPU back on the inline dispatch path=
. */
> +    if (tcg_enabled() && removed) {
> +        tcg_update_cflags(cpu);
> +    }
>  }

The loop still calls the public cpu_breakpoint_remove_by_ref(), which
now calls tcg_update_cflags() itself, so this updates the cflags once
per removed breakpoint and then once more at the end. I assume the
loop was meant to call cpu_breakpoint_remove_by_ref_int()?

