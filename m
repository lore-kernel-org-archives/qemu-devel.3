Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2574D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0NG-0001DV-2Z; Mon, 01 Dec 2025 04:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ0NF-0001Cg-1F
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:39:13 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ0ND-0007jv-6K
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:39:12 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78aa49cde3dso37497107b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764581949; x=1765186749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vk7N776ubxPfKBx1hNktvScJzUjhOlG47pzildGEWB0=;
 b=HbfiYzena3jkCo9LNPzqOJMUT/yrDM2bfrJ9GDkczoBWx1bGFOTzU6F8z+h9pQyOsC
 2YQZhVpJcM2etRkxSLyps9TsUbQk3Su/sov2AI8onAHJKPDl9zmVJVX4D/cJeCd6AX+a
 3PZCJrtD1yycOZp0grNOfEP/9fmZPbE4TvUDei1xpJL4mewVSpGQwXanrt9CN7xvRqrt
 htGAbNoroNPvPOLkbV8dXdg6Yf0+kiHb9RrbEcqekZYS+kPMkgdi4eitZzToEushkV5x
 ArISA8B/vPF55tpGfQ6rPtzfkxE6sFutdVy9KJPM3v/5hzZOJm7xIFtNXP5xGawMMDXB
 /c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764581949; x=1765186749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vk7N776ubxPfKBx1hNktvScJzUjhOlG47pzildGEWB0=;
 b=VIBpd4lfXNE3k2783aQFUlffUt5zYpZiAenRtRZfmBjTr0DALEaiTqTe3b9GUN3wG7
 xbq7LOe+i6PwZigznIKCTZmvTpCVqy8gzlMAXoQu77ZDNplNUj6qAWNi1pj4E7HWIgh+
 6BelGerzWXm3Hu8mgUdx4BK0Q/n/KHQoEm/u2bZ+NZVX5mQYZZsdOz8hC7tJA937sxYz
 z99ZroixJWKFZTR+mlHmGXkWPKy/mxtw9zmS2nBlJKHt3ErFrKy2zzXDUu54t/bem87s
 ygQhDszpsPjHol7yavd1g2kxoqAMtJqGK13SpTyoSOQgrLbJl5naGjd3ucEXFFkeY4od
 rAjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIdlS1QT7azfz/mtscbRTEKi3G15006ix8tSQ5hkBkgiNkiqQTbLDxEteXPDD1eN+gCf7ol3834v0+@nongnu.org
X-Gm-Message-State: AOJu0YwME48XNlKKnlMZ0c3L6H4a6YxYFquSpjarEp8VgxhfcmOmZwRA
 wmEdl2AK2jFZbTP1OC8CsoLVibr58+NODKQKyVqAbf6QStz8Ki5r7GjmQiwnl7WWcvJ3i0CX5Iu
 wf44X6xJpZ1GPGf8ROCwl1/wp/n6vdDnFdFwMcXkb+A==
X-Gm-Gg: ASbGncuZd8q+/QLQPbL70IboZ8+dHOvK/PQdYYOtjE4bHKrXP5Akf1Yaq5lANorjCB3
 sD4eT3UGnaHUI8uRABnob509ya5aixziRpVEGROcGGq//n8XtMP3bIyMFxzODe4fGUoeBJJ3bti
 QXZli+XPqaRvP+1IlSZzeYC5oi4Zo7ClKVWpY13bSp/UeFtKLfmOEiPrOKzd0gV8Hms0l5ueMOc
 McxNTOnPrPXHNC1HDcyiJzcQKyrcZW39irUYax2rtl1RqqO5ea8TSMK9aj+9RaL1UndU8w6BglM
 j0ueaVA=
X-Google-Smtp-Source: AGHT+IFTOPmMb+n9M0I4LBtTZUDPrbItivAwxig4hjFGYP2rrInJ2IlvhEheRt0C/VxneCVDZ7EFM5BakwCZ27jERv0=
X-Received: by 2002:a05:690c:6e07:b0:77f:9dae:34f0 with SMTP id
 00721157ae682-78a8b549d41mr310847237b3.46.1764581949025; Mon, 01 Dec 2025
 01:39:09 -0800 (PST)
MIME-Version: 1.0
References: <d2265ebb-84bc-41b7-a2d7-05dc9a5a2055@accesssoftek.com>
 <CAFEAcA8j6sAmm-uT9LdDt1VP2fWmui9ETXn90bDWbCh4aEMG4A@mail.gmail.com>
 <1706a491-f76a-45e1-9653-f3ba730690ec@linaro.org>
In-Reply-To: <1706a491-f76a-45e1-9653-f3ba730690ec@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 09:38:57 +0000
X-Gm-Features: AWmQ_bksnXU9o-MEVg0d_MH7N1_aRKGWMiymZxr0eUZrJuH8C9RxZ4Au_ZuCDyU
Message-ID: <CAFEAcA-z1p7iPmRUm0O3CboqGYpO--H98SaMu=xEK17dCgp=4A@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix assert on BRA.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Harald van Dijk <hdijk@accesssoftek.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Sun, 30 Nov 2025 at 20:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/28/25 01:31, Peter Maydell wrote:
> > On Fri, 28 Nov 2025 at 04:38, Harald van Dijk <hdijk@accesssoftek.com> wrote:
> >>
> >> trans_BRA does
> >>
> >>      gen_a64_set_pc(s, dst);
> >>      set_btype_for_br(s, a->rn);
> >>
> >> gen_a64_set_pc does
> >>
> >>      s->pc_save = -1;
> >>
> >> set_btype_for_br (if aa64_bti is enabled and the register is not x16 or
> >> x17) does
> >>
> >>      gen_pc_plus_diff(s, pc, 0);
> >>
> >> gen_pc_plus_diff does
> >>
> >>      assert(s->pc_save != -1);
> >>
> >> Hence, this assert is getting hit. We need to call set_btype_for_br
> >> before gen_a64_set_pc, and there is nothing in set_btype_for_br that
> >> depends on gen_a64_set_pc having already been called, so this commit
> >> simply swaps the calls.
> >>
> >> Signed-off-by: Harald van Dijk <hdijk@accesssoftek.com>
> >> ---
> >>   target/arm/tcg/translate-a64.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> >> index 08b21d7dbf..cde22a5cca 100644
> >> --- a/target/arm/tcg/translate-a64.c
> >> +++ b/target/arm/tcg/translate-a64.c
> >> @@ -1916,8 +1916,8 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
> >>           return false;
> >>       }
> >>       dst = auth_branch_target(s, cpu_reg(s,a->rn), cpu_reg_sp(s, a->rm), !a->m);
> >> -    gen_a64_set_pc(s, dst);
> >>       set_btype_for_br(s, a->rn);
> >> +    gen_a64_set_pc(s, dst);
> >>       s->base.is_jmp = DISAS_JUMP;
> >>       return true;
> >>   }
> >
> > The commit message on commit 64678fc45d8f6 says
> >      The set_btype_for_br call must be moved after the gen_a64_set_pc
> >      call to ensure the current pc can still be computed.
> >
> > but I think that is incorrect and it meant to say "moved before",
> > because the actual code changes it makes to trans_BR() and
> > trans_BRAZ() are
> >
> > @@ -1521,8 +1528,8 @@ static void set_btype_for_blr(DisasContext *s)
> >
> >   static bool trans_BR(DisasContext *s, arg_r *a)
> >   {
> > -    gen_a64_set_pc(s, cpu_reg(s, a->rn));
> >       set_btype_for_br(s, a->rn);
> > +    gen_a64_set_pc(s, cpu_reg(s, a->rn));
> >       s->base.is_jmp = DISAS_JUMP;
> >       return true;
> >   }
> > @@ -1581,8 +1588,8 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
> >       }
> >
> >       dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
> > -    gen_a64_set_pc(s, dst);
> >       set_btype_for_br(s, a->rn);
> > +    gen_a64_set_pc(s, dst);
> >       s->base.is_jmp = DISAS_JUMP;
> >       return true;
> >   }
> >
> > which move the set_btype_for_br() call to before gen_a64_set_pc().
> >
> > So I think that we just forgot to also include trans_BRA() in
> > that change, and your patch here fixes that.
> >
> > Richard,  does that sound right?
>
> Yep.
>
> >
> > If so, this should be:
> > Cc: qemu-stable@nongnu.org
> > Fixes: 64678fc45d8f6 ("target/arm: Fix BTI versus CF_PCREL")
> >
> > and you can have
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


Applied to target-arm.next, thanks.

-- PMM

