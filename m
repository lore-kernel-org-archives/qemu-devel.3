Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E3CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnoW-0006Mb-53; Wed, 03 Jun 2026 11:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUnoS-0006M9-GZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:47:25 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wUnoP-0005i5-IR
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:47:24 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3966388b388so9430371fa.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 08:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780501637; cv=none;
 d=google.com; s=arc-20240605;
 b=d+87NGYnj8SsvMLcWF4sq8x0bud5NO4tGvA7ZOkZAHgiQmLi+AtYocULWZgplXV6Mx
 joT8TWLXwwQ+Z709pqAPYoRV56BYCJfDoMEbM3zdrmayoQ+ovUHAH8xe4nMmfkb8ZpV3
 o0qZlgUvEU0UCZHKSt0nBckCuAEdNdafB4G0osATvfLlVb29c3dyZYBXJQQt+ZRFOcYK
 jya3RuUEjSt9z5hXvRksrebrKzktCumjq+v3BbkKTmfxulbI7q5NwAo4kYcBbvpzsXZo
 naIkzFGeAXFVbSv1ANxGx6LJeemi7Rw/56bip0Yh2pSNSI6JUzMgfDt9ojw1pcxgEHIv
 19Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ACEdUYkNNumwhIC97dB3vTfZ8GlpyDQ2bd2Btf6u5Gs=;
 fh=46HxGYYCp/+o1Yud2mdYR3mzhgKPsqKC9dqNsdb8EK0=;
 b=TAWgGjoGwBggWXFngThsJDkq86k4YA7xID4gDyMtFtpH6/aKdi7TJNPIs3ANS7wMhB
 tWlCpPCmlRLtGFvs/V/evUWdP21kVCUwqB7pdzJn/ojDCsAlCDxonDibMnJ/c+LC8+AT
 Xvn9oBtikhsda/ePzbX6sgLFgO/vjXUQgX+e68FZLZXXqq/9+W6k+h7n2HZKgLgENVw4
 PP5lbNRI+HctK+MejmzVHgyah7SrnwtROQi+U7JSSa3jBH4YS8AOXGLRs+0vOVWPsouO
 ykerl9miRWshSb1w1Z3aUCS5VlFcQqMZlTVKGr9xvgb20wnJ2G0TzpGD/+cN6pwqmTNo
 5VxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780501637; x=1781106437; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACEdUYkNNumwhIC97dB3vTfZ8GlpyDQ2bd2Btf6u5Gs=;
 b=MEjwUVjD4TyBhjMoy18X7hjGqsg1LwteADtFnYGYB+gsRO/vpMHEukz0vHqROxQltj
 83kag5w+i/FLKk+dufw6iGiQl0o96PNT+xjHXNVfE1mhxevgb7NDvhuDMMsoKXXF71YI
 FzIt4FA6BoX60Ke8JrCO8JV6yS8NTBZvZUdc3yS8ESk888kM4cTlG6/qUJthv5Jpoi0u
 2WfncR2y4xEBZcXoR+78WLv6Bh5f+2rJtYFsKssGxFZ9v0j2o5cwPOz371eO2Tl17jXm
 cMgVzLxUK00uybey5WW/weRKsV8C56gjLbZKpYvAHUgKeW82h8y5zcCgUzpCZhNyMhVq
 B5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780501637; x=1781106437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ACEdUYkNNumwhIC97dB3vTfZ8GlpyDQ2bd2Btf6u5Gs=;
 b=tMGnPq67xoZkddvV1mNqsoVKMiwc5Cfo9LdSeaPjN1Wtu/FiNyLTXj5w1+uT41N7Bx
 pV23nyWrHDXhdyI4IXVvGCac5tsTeyr8Can2CWWT3i7CA5+QoM8V0qngQyl6jS4nWzAc
 r7yuIxPqy2UNDZ9IdxyG+VWCAhd+xu6U3qD770rF+2kvj2pWOEhCEBDpSBpXHOK+Npf8
 t+wKrMiSD/rgS0v991pQrwVpk545qmKafDr/kDN+lSSmYMwhML5ksnsEEH3v6/OOYPVJ
 YH+3iSgT9BGjO+cyCv4ADTthAdqr7i5B+6KUfA2FTy/UK7ZdjqtdH0UNo6Ox8+r8XJXJ
 jf9A==
X-Gm-Message-State: AOJu0YxRCs1oS7don053/CyAF/NPv5M33OewItS5BbtNCttGAlwEhOao
 wQ3+fZ5Dw4X5EszB3C5agPs3vt2SgHGI4bb2lvFRTBL/Tge1X8OfEVtFFVa9p4Lndx0Cz/q9ph3
 up0g6Nteh5UmF+sZAXkJNI+Zwm639b1U=
X-Gm-Gg: Acq92OHx0rlmtidINp8XAyt+z7cvKc/5sWhz6kQ7qUBqi/7wExme+pINha0+9nyAu8w
 T9X2cMa39uLRoVExj35P66DRryQK2EcR4s/vUwT/kGVbJ3LC4cQnPu2/PaX9KUqNiz8aBar6sIY
 ohStQ+Wi5yrL5+m11iTlgqP714ga4m/1go9tc1ihET5/JpZaKWVxjWZH4jSF5DLcRMAmMfkLNUE
 47gjh6aaEHXJamfFc8i7qIPp4TTImECs3fT6AcuW9cjW9n/ua/aDXqrpSj2XhW0n4JymebmypDe
 BsAYf3htsej9lBBu7TiePowMih84Y9/yMcsenDSJT/0wXX2w1Q+N
X-Received: by 2002:a2e:920b:0:b0:38b:dd55:b71 with SMTP id
 38308e7fff4ca-396aef7f869mr8993271fa.20.1780501637160; Wed, 03 Jun 2026
 08:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152739.4122267-1-mattst88@gmail.com>
 <20c744a7-369f-4abf-93f5-c6553c3340fd@linaro.org>
 <CAEdQ38GwpNm1sFD3yP9O0BaFCUdjKawCOUO1jHCvhTTz4i=iWA@mail.gmail.com>
In-Reply-To: <CAEdQ38GwpNm1sFD3yP9O0BaFCUdjKawCOUO1jHCvhTTz4i=iWA@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 3 Jun 2026 11:47:04 -0400
X-Gm-Features: AVHnY4KUzAILiAJ_1QkIEzeaPm8i0o7ktiUllbVTFVrh7SZmzkj_GbnBoR-RPE8
Message-ID: <CAEdQ38F330SLJ0=JtNzKrzJP=oOEHmAmDgfVEF36bx6OJKx-ig@mail.gmail.com>
Subject: Re: [PATCH] target/sh4: decode_gusa: recognize add#imm with prior mov
 Rm, Rn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, May 28, 2026 at 7:51=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Mon, May 25, 2026 at 8:55=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 5/25/26 08:27, Matt Turner wrote:
> > > The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
> > > `mov Rm, Rn` appeared (mv_src >=3D 0), forcing a fallback to
> > > cpu_exec_step_atomic for sequences like:
> > >
> > >    mov.l  @r2, r3      ; load
> > >    mov    r3, r7       ; save old value (mv_src =3D=3D ld_dst)
> > >    add    #1, r7       ; increment copy
> > >    mov.l  r7, @r2      ; store
> > >
> > > When mv_src =3D=3D ld_dst the move merely copies the loaded value to
> > > preserve it -- exactly the situation already accepted for the
> > > `add Rm, Rn` form. The immediate form can be handled identically with
> > > tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inlin=
e
> > > instead of taking the slower single-step atomic fallback.
> > > ---
> > >   target/sh4/translate.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git ./target/sh4/translate.c ./target/sh4/translate.c
> > > index 5adf650744..d38a6bd352 100644
> > > --- ./target/sh4/translate.c
> > > +++ ./target/sh4/translate.c
> > > @@ -1974,7 +1974,7 @@ static void decode_gusa(DisasContext *ctx, CPUS=
H4State *env)
> > >           break;
> > >
> > >       case 0x7000 ... 0x700f: /* add #imm,Rn */
> > > -        if (op_dst !=3D B11_8 || mv_src >=3D 0) {
> > > +        if (op_dst !=3D B11_8 || (mv_src >=3D 0 && mv_src !=3D ld_ds=
t)) {
> > >               goto fail;
> >
> > Hmm, but then you don't further constrain B11_8.
> >
> > For the given example, afaics, B11_8 =3D=3D op_dst, so we're failing on=
ly because mv_src >=3D 0.
> >   Do we actually need the mv_src check?  I'm guessing not.
>
> I think you're exactly right that `mv_src >=3D 0` doesn't do anything by
> itself. With this patch, the `mv_src >=3D 0` check is needed to prevent
> a spurious failure for:
>
> mov.l  @r2, r3   ; ld_dst=3D3, op_dst=3D3 (set to ld_dst by default)
> add    #1, r3    ; B11_8=3D3
> mov.l  r3, @r2
>
> With just mv_src !=3D ld_dst (no mv_src >=3D 0 guard):
> - mv_src =3D -1, ld_dst =3D 3
> - -1 !=3D 3 -> true -> spurious fail

Unsure of the status on this patch. Will someone take it through their
tree, or are there remaining concerns?

