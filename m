Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D3CD6E43
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 23:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSkW0-00089X-EQ; Thu, 28 May 2026 19:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wSkVl-00087i-HY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 19:51:37 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wSkVj-0004Gw-E5
 for qemu-devel@nongnu.org; Thu, 28 May 2026 19:51:36 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5aa21fa024cso11756728e87.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 16:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780012292; cv=none;
 d=google.com; s=arc-20240605;
 b=KfHZlIqFkIsmuXVqBKdyCzXY52wlpJ9EuIYGl/dLpkyCpxq/+/zZZPDazN6j6MsJda
 rOYfoxN3jiGEFYOAaAlcFFdNGOmDt7EVtjYbUT/RIWdrI2/iUQ1Xyn3f9mQ5xCOn/GTH
 +k/pA661g0Z/IxVPifBALsV3I+k86qSXPP1DppZDxFUUlc2wWLSS8NCdMXG0CScQ1dFn
 VIBcJgHqdac6/Sa4xAfyl/Twf+H83trau1tvwOT0noQbAzkzXKMTIhTP0ELIghqA3i5r
 4IHM85CPKxzgspUZrth0GEYzXLs/mHIgSzikoHwsbX1wrsEmS8Ddd4Ie64lPVHXi9UPC
 LACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9U8E96mOSn1XAGHvC3YZBTEGzoFP5ySSayZh3XhPnsk=;
 fh=46HxGYYCp/+o1Yud2mdYR3mzhgKPsqKC9dqNsdb8EK0=;
 b=CD9KqOhnP9urTotyVxjxv1yKOwsCu/IhgDb5iVG0UA3HNWkNKJaPonn8dK6veu8UjQ
 /xZMy0yzExCDu1HtyVyGHHixvNHL6h2e/VnLHTthebGkBppzgZbDBWKVbgCdLiPvNbyO
 YRvT7ukSZX0aXyTCwII6YMa/HpZDynSHx5UVh99J5BWUEyQ9Sc2XNzVcAFbSkiwaEemv
 q7auygENpRN7CdW9MsiwULGFS6pdIvWFF9oIyIrsG7XWue2mLaVqNxcg5zumIRPURLzK
 K4JsQGBVmrGn4IN8uasuu7reqytxGhN4FbINm1mecCkFNZyrQfJxiuHQerB7LWxPeZIU
 Ly+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780012292; x=1780617092; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9U8E96mOSn1XAGHvC3YZBTEGzoFP5ySSayZh3XhPnsk=;
 b=TEVXwcXcwX/beag5dm3+oV2hYAwFA2MUZs8nqXiQGBRR1x6pmELA+hjnBnoyAmJuwf
 vL3PRgzdt1/Fq0otZOC8dk9hkkdN/i2+aHxA8MshD7J4R57J1++SoVgBt0cYVbMp7lzR
 RQZQV2Wsz4bLkx3nGTufFXK/vTfXJvytfWIrlu/858JTm+tNiwWmpc46I7tDJieH8Nis
 rl1QCoaRG1dqYM/7r5dVn6uTc+13NuJebgNqxbGFzlJxPPit7SQryFDKraLXrTuf04ke
 z/hZOsHaO4/Ed46nlU8w71Sv6lqlFU2iFcvCtXYF9k8l9J7hodpWpnxuI8aBQHVJ+4Yc
 dVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780012292; x=1780617092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9U8E96mOSn1XAGHvC3YZBTEGzoFP5ySSayZh3XhPnsk=;
 b=nCptEa0BaH2hydzRB4leV4Jc9O+3wycT7XmMvkBJ4QbCRrLXd2l/4dRyinKRcATjKf
 s2Oye+ZQ1LblAd/Uu4sa3ST3VSdLrnCAXthvYBw82whm32diNYZ0ctVNQaignEYPyNxC
 A9W4j6rUcDUMutVRdr7idJeZ9kTcY/hD4XIgSDvel9UUwGLel7HFjWlFchUxH4SsuKxC
 udoax2GEtV2RQBciGWETUvqfFdn1YSLbAYWcxlj8M1dg6iJHGTiz9c+eDsm/xHaniD3f
 4/0uVmrNrysvQNjAmWZbgkbXbK/F9+rA/1Ne6lo5vrzqUZYSzb6jm1P+MNrgJ6BhvXZo
 +nWg==
X-Gm-Message-State: AOJu0YxHS/6n5snDQ7XmDqolPK2/LmVZ+B+rmFLip8h71vfP+HW+kkSs
 C3OeHWUZItabkxXXlK1wI4RbLU6iU8TLTjvp+qIDxt7G8enFZGof499MirM4c6PwWQBQi+0D6TF
 D/1c3XgG35PmXTGEREmHID+iel9K3pN0=
X-Gm-Gg: Acq92OEjuKbS8ISsVM798YTni19xeEHywx+tdAleenAMdPxnS/zeRW1uORQxqwXvhB4
 /jfodmeLSmxatiullBs27uphp2ZWMju+W17C9sNUPy24L1Ffhdx72g4oNUQUWlcIo6JRDn6fPu1
 y0KG6a8t2JttBxQFJjcZ9ajxjEjBTRclHqOs1jRbZ2bain6EN7D1R7yFqsU7ZQ+iFgwPwaaD2a7
 vd+LAArQlVUaKhhr8pltzR8v7klHSMmqipOTAh91msaQMrXYfjbYeh+bsu6VK/5ulVNZLZjw5Sk
 xhfF0P5nOnGH5sKTauxf
X-Received: by 2002:a05:6512:4017:b0:5aa:213d:6cbd with SMTP id
 2adb3069b0e04-5aa594b0243mr69420e87.28.1780012292157; Thu, 28 May 2026
 16:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152739.4122267-1-mattst88@gmail.com>
 <20c744a7-369f-4abf-93f5-c6553c3340fd@linaro.org>
In-Reply-To: <20c744a7-369f-4abf-93f5-c6553c3340fd@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 28 May 2026 19:51:18 -0400
X-Gm-Features: AVHnY4I97fYrx97jpxME7_zYq9UYTkAEKevqmyI5A-6rp92PcxMYMqm3TbtfGeg
Message-ID: <CAEdQ38GwpNm1sFD3yP9O0BaFCUdjKawCOUO1jHCvhTTz4i=iWA@mail.gmail.com>
Subject: Re: [PATCH] target/sh4: decode_gusa: recognize add#imm with prior mov
 Rm, Rn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x12e.google.com
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

On Mon, May 25, 2026 at 8:55=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/25/26 08:27, Matt Turner wrote:
> > The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
> > `mov Rm, Rn` appeared (mv_src >=3D 0), forcing a fallback to
> > cpu_exec_step_atomic for sequences like:
> >
> >    mov.l  @r2, r3      ; load
> >    mov    r3, r7       ; save old value (mv_src =3D=3D ld_dst)
> >    add    #1, r7       ; increment copy
> >    mov.l  r7, @r2      ; store
> >
> > When mv_src =3D=3D ld_dst the move merely copies the loaded value to
> > preserve it -- exactly the situation already accepted for the
> > `add Rm, Rn` form. The immediate form can be handled identically with
> > tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inline
> > instead of taking the slower single-step atomic fallback.
> > ---
> >   target/sh4/translate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git ./target/sh4/translate.c ./target/sh4/translate.c
> > index 5adf650744..d38a6bd352 100644
> > --- ./target/sh4/translate.c
> > +++ ./target/sh4/translate.c
> > @@ -1974,7 +1974,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4=
State *env)
> >           break;
> >
> >       case 0x7000 ... 0x700f: /* add #imm,Rn */
> > -        if (op_dst !=3D B11_8 || mv_src >=3D 0) {
> > +        if (op_dst !=3D B11_8 || (mv_src >=3D 0 && mv_src !=3D ld_dst)=
) {
> >               goto fail;
>
> Hmm, but then you don't further constrain B11_8.
>
> For the given example, afaics, B11_8 =3D=3D op_dst, so we're failing only=
 because mv_src >=3D 0.
>   Do we actually need the mv_src check?  I'm guessing not.

I think you're exactly right that `mv_src >=3D 0` doesn't do anything by
itself. With this patch, the `mv_src >=3D 0` check is needed to prevent
a spurious failure for:

mov.l  @r2, r3   ; ld_dst=3D3, op_dst=3D3 (set to ld_dst by default)
add    #1, r3    ; B11_8=3D3
mov.l  r3, @r2

With just mv_src !=3D ld_dst (no mv_src >=3D 0 guard):
- mv_src =3D -1, ld_dst =3D 3
- -1 !=3D 3 -> true -> spurious fail

