Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1E6D216B2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 16:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRCJS-0007lZ-32; Thu, 04 Dec 2025 11:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRCJQ-0007iR-39
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:36:12 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRCJK-0007wc-UW
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:36:11 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-641e4744e59so1111609d50.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764866165; x=1765470965; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGpPafuUcrIsQ0uNemVk2GIyfAmCee1ccsgLV0Yo5jU=;
 b=REzPn9LrMuBA6cUZU+J0Eo1EG0PqSkzmraXtNy4ghhEtuzsnVhv1vdwswRtA9vAYF1
 XfpRERHtXNO/6zLReq/JnUghj00v8cqWeve3rKLLvtPiBG+fktdjWf/DTRsCOt0pfNPz
 5Y08qgEJfZoLaHoElT3EeiqQHFQL5hk3kWBstRxF/EvF5OnsXzYdXoPTK5EM79uLHQXK
 X2tXct6xIrrwUU61GYZZ/CQgpFTS2BF4gvVrA/JpnrsdaM2ZwPOCAIdl6XwHk1qMzPGC
 k/DTWQlpicYvKlabWQE/pZQKhjdf5lVweMr5a3eNK6TSGaxd1eiY3V4bgyaovNgGxVS2
 YapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764866165; x=1765470965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hGpPafuUcrIsQ0uNemVk2GIyfAmCee1ccsgLV0Yo5jU=;
 b=cUI6so93hDX5FmvZUqC+55YDYGT1NryvZHL9j6XRkbIXSDbHsSAjwodf8z63UkH7uE
 HzOoHUcn/w6WpxoCZIg5SECf2qwpqF4eh8E+mmBdN9dBHqolo/9t9mzj2seThOpqz6Hb
 x5UGo06VER2sqg4SLv8A4HMQpyK2i1iWLQgHOqzvPDk4hNCfJba2Ht5qkh0idb+uTqeq
 6xfYnhzWJ/pvEkFf1HaZRtD6Wofmggxg2BzC73MH0nG64m1LXVrpVwphLjeKRC+HJam/
 JZlHOBTvFcYFPaZNhRRNFjcrNgOD3/0d/Vu9Rrwnmnr+VNsA7urZeWe1UatMG6tOpRei
 3XoQ==
X-Gm-Message-State: AOJu0Yz6Og9U0PazV0SMFkJc5ZAhik3uhTypkWRWAITb/wxby2j508hT
 qhH/2nlHBu8UCdpKxOQQsE9jrvnw8RrmQJMt7PZVDbi4QCIJs2OAK+/Kpe6hB8KZW3o2+Hvr67u
 jLM++AsFydbNNfrB5unaS5NhNsKNao52+7j9wOaeKVQ==
X-Gm-Gg: ASbGncv5umljA7Lfncml1AfwrxVklFfERnIfmPRoRFKqnJWkoI07jjTBDgFQepK3BsJ
 7uTzU1O6ubqOnQcA13uYajfErhcnoiiMRtxpkHtrUNmoBTdUVMCv5GU6pokqEg4h3TKsZpzaPBK
 CzVw6di7segfgMdSod/i/vlmFrF/XU42/ANQey8B2YzTlv/AVFqkq0kuay8QoMkVDuSusfESpL9
 gaFf+heuWUXLPePObX8OySg59YS5V1CpDwiAr+VuEqMhnR9UZTVkMcLJcNB4McJtRd4CsQs
X-Google-Smtp-Source: AGHT+IEbYLRgY86MB0K5qHW5yoBPJDYL1uGllh4z+Kmn0XmiuPPV6CUgfhCBDV0D4LFlNkeDpPevVYN7JUPi00FnZc0=
X-Received: by 2002:a05:690e:b86:b0:63f:9fda:e7f7 with SMTP id
 956f58d0204a3-644370217f6mr4621447d50.53.1764866165095; Thu, 04 Dec 2025
 08:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20251204155427.801085-1-alex.bennee@linaro.org>
In-Reply-To: <20251204155427.801085-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Dec 2025 16:35:53 +0000
X-Gm-Features: AWmQ_blCw6HN7Gpl4fU3nANxh_SCLzn-BxQQcBNWM-0_sDurdtiTLIzJ4YucWC8
Message-ID: <CAFEAcA8X338XQaODCgJuVQ5UgZu9OG0Vr48oM12t7nE++Akz3Q@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: handle unaligned PC during tlb probe
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 4 Dec 2025 at 15:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> PC alignment faults have priority over instruction aborts and we have
> code to deal with this in the translation front-ends. However during
> tb_lookup we can see a potentially faulting probe which doesn't get a
> MemOp set. If the page isn't available this results in
> EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).
>
> As there is no easy way to set the appropriate MemOp in the
> instruction fetch probe path lets just detect it in
> arm_cpu_tlb_fill_align() and set memop appropriately.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3233
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/tcg/tlb_helper.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index f1983a5732e..78c85cb3306 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -345,6 +345,17 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntr=
yFull *out, vaddr address,
>          fi =3D memset(&local_fi, 0, sizeof(local_fi));
>      }
>
> +    /*
> +     * PC alignment faults should be dealt with at translation time
> +     * but we also need to make sure other faults don't preempt them
> +     * while being probed.
> +     */
> +    if (access_type =3D=3D MMU_INST_FETCH && !cpu->env.thumb) {
> +        /* probe sets memop to 0 */
> +        g_assert(!memop);
> +        memop |=3D MO_ALIGN_4;
> +    }

I see that this does in practice get the right syndrome,
but I don't entirely understand why. Looking at the code,
what it seems like will happen is we'll come in here, set
the memop align bits, then that will trip the
existing check on address alignment if the PC isn't
4-aligned. So we'll set fi->type =3D ARMFault_Alignment,
and then (assuming not a mere probe) call
arm_deliver_fault(), which always uses syn_insn_abort()
for MMU_INST_FETCH.

I think this must be working because in practice we
call it once as a probe, and then the translate.c
code catches the misaligned-PC case before we get to
the point of doing a non-probe load. But the result
is that this function will do the wrong thing if it
ever is called for a non-probe load.

Plus we pass a different memop into get_phys_addr(), which
might do something unexpected as a result.

Maybe we should instead do:

    if (access_type =3D=3D MMU_INST_FETCH && !cpu->env.thumb &&
        (address & 3)) {
        fi->type =3D ARMFault_Alignment;
    } else if (address & ....) {
        fi->type =3D ARMFault_Alignment;
    } else if (!get_phys_addr(...)) {
        ...
    }

plus have arm_deliver_fault() do

    if (access_type =3D=3D MMU_INST_FETCH) {
        if (fi->type =3D ARMFault_Alignment) {
            syn =3D syn_pcalignment();
        } else {
            syn =3D syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
        }
        exc =3D EXCP_PREFETCH_ABORT;
   } ...

?

thanks
-- PMM

