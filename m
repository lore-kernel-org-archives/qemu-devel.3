Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C79EC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y19-0007cS-1a; Tue, 08 Sep 2026 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3y0z-0007bd-Fo
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:45:43 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3y0w-0007Gn-6o
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:45:41 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-87f4e914a45so302437b3.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 08:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882337; cv=none;
 d=google.com; s=arc-20260327;
 b=Y+fzOZy3jTjBkYbvm8P/kWrnVj6KHKjkl1luNqTTzuvMkjJWmHcWbRlTpXlcWlRARv
 p3kyJ7ZQ7qnmcdmI+1m9vEF2xuoOHxjZVyL7QesfOIxnZ+OybEGcwe/quKbuoaNmQbfN
 X5IigLcC08dA9YU0aDuMyIZ80y30XPS9D86XmvcHYHwjTUR505xJ+AJg0dpolz+Rv6o6
 hwXkI8JPdjIubVtXDZnvSAG469/BtxxT4rqBK04u4rhRevxlGsNbm6PevtHx4oXf1PPv
 VPKgm4slI6AXsaf0g/RYKksbQ6gR7aFYW9e9+FZ7hehl3+FRCpt2ZoYnmR2gemsHRQi1
 1l8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dXNhbUTQLyXLjddhQo0c/S3BfE2+aYqa9Ck0ukPYbl0=;
 fh=d0W1eWBwur3YwtwKrxg94vGNNcM/kmG1mpUFOgEt3TI=;
 b=TBFPsV6/w3L0v+JV5ilGmMGCk604SB0p+neIUxpt9O3TLsu3qqNh+0nh6Yu0NfS1Nn
 Tl1g13q68DWkAY9tqFnRVCxJjGbQ5Isvqeu7yyGuLe+HwG31mvmmbDy/7I1yCWy2OHPr
 tMS2JkiMsDMSx876l+TgxQf4Ka6JlUn0AHTDcUl0isIauITkZdMYlyOq4tmaKE4f8uil
 wdPhAGjHufbT/8IokRmnqjyBjGBKlkt3t96GNp0+a/ggHFnxwHxzJKyf7/QqcEDT3ZUz
 igtixTJRJ8JrJ1aBeO8PK8In6BTbyKlpCZWwStIkkKD6nc3Xv1ts/3mqrk3YSpeKN5pK
 OIsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788882337; x=1789487137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dXNhbUTQLyXLjddhQo0c/S3BfE2+aYqa9Ck0ukPYbl0=;
 b=H2Q9IvnwNH9CU2e2uLuh2yLdrKUwjvdMp8QcknsU1pO66fbAtzlF8Qj6CdbSNafaak
 BSAdn1U+COoEzIqgpZ998KWPuMTewgTIA11fJUX0tcxZBgqMa9cyZELZt7eymZkRqiF7
 bmm39VRfzmaUggph6dE3GceLYCcp51pfeNk1REIuaprUaBK/wcPbA6LaRlcE26Z2TMyu
 UnTRymy1JPj2qSYmYlMcQgjciw3zXt5ke0fybFYWECBzyuTXcrwwZKOLFFacrLy+t2Tz
 QJVbuZjEJ/3HUTYTVbr7nkf1LGAhKB4FsIp6MigIYMXFtmagTG9dwpe5dC6L+VCO3rmG
 Hlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788882337; x=1789487137;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dXNhbUTQLyXLjddhQo0c/S3BfE2+aYqa9Ck0ukPYbl0=;
 b=Un4Ltvq88NIc+XVRzN7/vc4K6GvDW6sU3C6qzjEkq5KyJXDgw/Jy+zh5m/+yFuHLPM
 teYCQ0W8NWdxgLggMy8ZDzTHame7bg3KjuIq1RTjBPzgqpvBp5tiIirUCWe3JvL/ap5t
 nL9DSvfTdgmts7Jymzq+1qmRCBxxyNbec3alPBRBFIRnZPbXmCR7EOCmsva7cP1JctEB
 Iv3nE6o6kIaeXaSL49RtR5nkPKq04zeXxcQBwCYQB5H8TlqFQO+u6mCz5IbMGj4utYg9
 qg9X7Jy9JyiOLy2eF17ptBd1dt7MPfokzjIYA8sqT3crAREEXr7Vm6EvAqX8cbiQHAjf
 Gwrg==
X-Gm-Message-State: AFuF++lx0T1QiOyp43GjVVoNXiOXNOp4xzL+MZZ0/+Ex7fi8Kycvbb8T
 8YKNPSVS1T7llk24pieo6tYBOlFnNAA1Ks8p4pZqk1eVGZsvor7SyShM8xpWpFJdrRPUgoRGBg4
 LAH8nVp/S/rz5Ul5ab1rktt292fGCtbGE6sbJ4SMlJA==
X-Gm-Gg: AYBFou1RTL4Xy8sMQ9j6pkrvhlXI1AFkB9yYMtfEkt2tRf8u+8PwMKq3aTIinsUayrc
 oAsnZMwQAu3CWOqYvsF52dV0elrrPVI9HWzj0xlpbD3iakI5u/Aj4VIRFpSyfTAauHFZWinqB8J
 Fn/MX+KgG1ziK5Z7S7y9uZsfuaFfZQAdaHtqX/9JLoDshvxa7SNDasCPcMBoiPtaTwQkM6MAv7/
 8clKqpryQYZ+XGEVEcWA7z2y3G5yU9sAd5Pn4yM+dA/vRngl0O7E1jodjjO7O3a+Nj8K+JTkxF5
 HaFWVlfhs6QgTVCP0GyubK4RN+G1OwCUvej6g6XcYg/7i1nwmFjJDKYLj7x3o4B8w9u7l0YEE4V
 G5Yu/0gCRKZs+4GT2/C1wGAc5cw5j
X-Received: by 2002:a05:690c:698b:b0:81e:5d2e:89c8 with SMTP id
 00721157ae682-871246aaa7dmr112500817b3.14.1788882335996; Tue, 08 Sep 2026
 08:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260903142212.1451770-1-alex.bennee@linaro.org>
 <20260903142212.1451770-2-alex.bennee@linaro.org>
In-Reply-To: <20260903142212.1451770-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 16:45:24 +0100
X-Gm-Features: AcwNN1XwYS1q5YCIlWYka3RceK_vNqHIDQQ97YREPB1hQd8UvcHlfrxqcYdFuqo
Message-ID: <CAFEAcA8i4Pj1_uHyQnCd3xoxLKFxF81PoPXLRRyp+rw4kQCOkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/intc: include CPUID for SGIs on GIC HPPIR reads
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 3 Sept 2026 at 15:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> In ARM GICv2 (and GICv1), reads of the Highest Priority Pending
> Interrupt Register (GICC_HPPIR and GICV_HPPIR) must include the
> requesting CPU ID in bits [12:10] when the highest priority pending
> interrupt is an SGI (interrupt IDs 0-15).

This is true. The SGI field also is in the GICC_IAR
(interrupt acknowledge register) and needs to be accepted
for writes to GICC_EOIR (end of interrupt). Currently we don't
do any of that (we don't fill in the SGI field for reads
from GICC_IARR, and we just ignore the SGI field for writes
to GICC_EOIR rather than using it.

The important thing here is that "an SGI of ID X from source CPU Y"
is different (has its own pending state, etc) from "an SGI of ID X
from source CPU Z").

Perhaps we should in retrospect have made the interrupt ID values
for SGIs include the CPU source ID part, rather than dropping the
source ID and then trying to bolt it back on afterwards,
but trying to change that at this point is probably a bit invasive.

> Introduce gic_get_sgi_source() to look up the source CPU ID for both
> physical and virtual interfaces, and include it in bits [12:10] of the
> HPPIR read value for SGIs.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4402
> AI-used-for: initial prototype changes
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> NOTE:
>   - the initial patch was more expansive and included re-factoring
>     gic_clear_pending_sgi to use the new helper. I dumped that change
>     so I could reason through the fix on its own.
> ---
>  hw/intc/arm_gic.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 4d4b79e6f34..181d17ead7c 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -568,6 +568,17 @@ static void gic_drop_prio(GICState *s, int cpu, int =
group)
>      s->running_priority[cpu] =3D gic_get_prio_from_apr_bits(s, cpu);
>  }
>
> +static inline int gic_get_sgi_source(GICState *s, int irq, int cpu)
> +{
> +    if (gic_is_vcpu(cpu)) {
> +        uint32_t *lr_entry =3D gic_get_lr_entry(s, irq, cpu);
> +        return GICH_LR_HW(*lr_entry) ? 0 : GICH_LR_CPUID(*lr_entry);
> +    } else {
> +        assert(s->sgi_pending[irq][cpu] !=3D 0);
> +        return ctz32(s->sgi_pending[irq][cpu]) & 0x7;

Why mask with 7 ? Unless something's gone wrong there shouldn't
be any unexpected bits set.

> +    }
> +}
> +
>  static inline uint32_t gic_clear_pending_sgi(GICState *s, int irq, int c=
pu)
>  {
>      int src;
> @@ -1648,8 +1659,16 @@ static MemTxResult gic_cpu_read(GICState *s, int c=
pu, int offset,
>          *data =3D gic_get_running_priority(s, cpu, attrs);
>          break;
>      case 0x18: /* Highest Pending Interrupt */
> -        *data =3D gic_get_current_pending_irq(s, cpu, attrs);
> +    {
> +        uint16_t p =3D gic_get_current_pending_irq(s, cpu, attrs);
> +
> +        if (p < GIC_NR_SGIS && s->revision !=3D REV_11MPCORE) {

Why "not if 11mpcore" ? The 11mpcore TRM says it has the SGI
field for HPPIR and IAR:

https://support.arm.com/documentation/ddi0360/f/mpcore-distributed-interrup=
t-controller/cpu-interrupt-interface-registers/highest-pending-interrupt-re=
gister--0x18?lang=3Den

> +            *data =3D p | (gic_get_sgi_source(s, p, cpu) << 10);
> +        } else {
> +            *data =3D p;
> +        }
>          break;
> +    }
>      case 0x1c: /* Aliased Binary Point */
>          /* GIC v2, no security: ABPR
>           * GIC v1, no security: not implemented (RAZ/WI)
> --
> 2.47.3

-- PMM

