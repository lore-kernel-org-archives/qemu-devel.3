Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B64CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhOn-0002GK-D4; Tue, 29 Sep 2026 19:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhOl-0002Fs-Ds
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:38:11 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhOj-0006MR-MU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:38:11 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5ba3d17a999so56350e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790725088; cv=none;
 d=google.com; s=arc-20260327;
 b=Il/Mi7vpdWKsqELExcmR7IQh4JbJWXv02Aulo+Acuna81djJEN5EsDefJHJRxa0JnE
 Lm285c/Olr98JPQl6pB+G/DERJKNLET8qNuOQEZE3Nisw3iErmmynhnwpdPd2TFjkcca
 03yBIodW3htVcw154OCvj+/S0EQ22qMZAQp6M5J21kdqk6mO6rP0gjDwMvHP7smkqThZ
 xc6VC2dSkDmSOb4aaOAGx880pxSCLPN6HC/6zuuJpa5joyTNkCClVnqu+KZjoVA+v5Ew
 UQqwsf08qRmLSNWo4g+ZYHzPCgPNZL9dprFVWGATUH5hS7n3+uXarqyv3PhVOnwIaDyq
 nU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UKmdA0yhVFxnhxqWWuM2LrmCA8xhSqULtlPho2vFdaI=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=R9mnYv4eNLDQs3sQbYHKnkhWRTRIM0r1M/ZbvAg6DmWgmBFX150I0HaKIHhEIyZPLX
 Fmvs/T3TtjqCq/ZDj1CjhPJ/H/BfE6cjhiIW9xgmcuhzCSCrrCxsP3XvrYdB8K7b4/vf
 sXtw6FUImscyrHeIdfWiqsJTBEo+2TjVdyCaahzpPCiVW6ZVfzHn3x9SVQSjZBjUOLJe
 MpziLAryi4DQnA0wHugKF5DtD0xGWW78nfRrLIHxBeEFgHkjfR+GlC6pjkxN1Ngx8SiO
 S2LX0uBuREURDT4xGh1jOvM9HYz8Vb4P19mfEqPrvkOwPYmuiqIVqqSYokVbwdKeBlsk
 ytdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790725088; x=1791329888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UKmdA0yhVFxnhxqWWuM2LrmCA8xhSqULtlPho2vFdaI=;
 b=RdZoxkGeYmXkUYjRBeYefGxnolpYimwJccuMc2JcD8iUuHi66289iqEKmJdM+AVE7A
 Qmy/9nvwzNV4mhsct53uaw2UxthpIkjg3HlJHuBZ7rO/s/HqNWKbnevvzIWzJ9o/dY9q
 zV5FlvZ6VRwHOkCykK1c8ca3vVjyBP42VmdG4qKLfAcaysZ2xNmRWoZaygOcWD5Iz/a/
 dma/xsEVLlnY2yl9tdVCqzhUUSX9qE/wrn9zEuEYcMO8/1UY+UYer3QfjTiuNolSm755
 RR6eIZjT8Yyj/rNky/vjBdX6iPKdcjOFVPHfy8xtPYh2JwwKsmgQyQP8byLf0NWIBKoo
 nsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790725088; x=1791329888;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UKmdA0yhVFxnhxqWWuM2LrmCA8xhSqULtlPho2vFdaI=;
 b=gqDV6l0/SD3EN4dSS0kcXC4CUtEYnegzklg2POZODM16khduq7RRoEyEQYBC7VSO4d
 QrWlZxuJ6mB/ZFVKISjcJm93h7EM9enDZ+hIrkqZpb1ksRK5b00xqcjqHLiV3aryHiJt
 V7yITo7A+oKDyYKMyZlCBcErwk82Of7FLHcTobmx6lahel7wPLkHZDTYNLbP7K2NIpHU
 5w8eNl2aZu+vboeoYLc7QCgzH6mbOaNAcBXU1bx5xu6Jy2VAYoR/xlFP2ColcFnaHclR
 xg8nf3MYUmRwhh/H2wF+VwvqphaHoBKiwZ6gSUkkTJB5ctR4qTvrcgowbLzigUg/B4AZ
 Ao+g==
X-Gm-Message-State: AFq9FYLY0woFJFQR2x2p3YRl6gxy/ovu2VTgBmMWIDbHUhO5vdoKmoXh
 UHzCROzGferqvba3PI3ZSVHZyyA/8Ij7Ivtc9Vm231UIn6LqAI27QgsObaQ31TjAoq7nK5SiyEk
 g5LKj1ssD7wOG06zfJrOeQlsvjgLMwm005g==
X-Gm-Gg: AYBFou3ML2HSFapeVIObHAfbdAwHqbJm/9dfAj1dJ7rvVfwqF3CyoOg+0auvZ+LkFp6
 rACoMYlk+s77Z5ZM/gQhQftec9XNzEGzdmfhY9pAyv+D/vJ3DJTpGYtH+YPrFAJ6MeVXRN67ywC
 kQSsZUm6UfEbs6Yt9/9o+Bb8QmD2JSM1XwI0qo/IBxy6B1D1/eZk4tIHYI68rfv75Omr+PNLc3g
 fRvii25YwWSyaLTZ4gdjZ/vPKL+oZ5mCpOvYJX+g47t5vD03eDAZCwgPxRWD/JDBDZ39tZe0zQP
 D9amV+3NTm3O1uwoMgKJRNgCMx/VO8KHO24iDHQ+n+6uympPqYDEUo6Vl6B3mUZXPW95sfBTMVK
 HxJcW05mitX1+GA==
X-Received: by 2002:ac2:51d2:0:b0:5ba:3e13:20a5 with SMTP id
 2adb3069b0e04-5ba3e132190mr19132e87.20.1790725087643; Tue, 29 Sep 2026
 16:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-55-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-55-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 19:37:54 -0400
X-Gm-Features: AclHuK_yAyuWyDBF_fOKpncu9Mc5G5sP2vdkcsYF3AA5dZU2rX02Q9LKQU0B47U
Message-ID: <CAEdQ38EgQKjRUgdwTQ5fYDRwpei5ddGd3nc4mGu6MdPM82rB8w@mail.gmail.com>
Subject: Re: [PATCH v5 054/101] tcg: Generic expansion of tcg_gen_ctpop_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x10.google.com
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

On Sun, Sep 27, 2026 at 5:04=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |  2 --
>  include/tcg/tcg-op-def.h.inc |  1 +
>  tcg/tcg-op.c                 | 41 +++++++++++++++---------------------
>  3 files changed, 18 insertions(+), 26 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index acdd31dbeaf..7f977661b3d 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>  void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
> -void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
>  void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
> @@ -191,7 +190,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg=
_target_long offset);
>  void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
> -void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
>  void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index cf832a6dc07..66977cada1f 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -10,6 +10,7 @@ DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
>  DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
>  DEF3(clz, TCGV, TCGV, TCGV)
>  DEF3(clzi, TCGV, TCGV, TINT)
> +DEF2(ctpop, TCGV, TCGV)
>  DEF1(discard, TCGV)
>  DEF3(div, TCGV, TCGV, TCGV)
>  DEF3(divu, TCGV, TCGV, TCGV)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index f168386f46b..86dae114859 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -450,6 +450,23 @@ void tcg_gen_clzi(TCGType type, TCGTemp *dst, TCGTem=
p *src1, int64_t src2)
>      tcg_gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
>  }
>
> +void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
> +{
> +    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
> +        tcg_gen_op_tt(INDEX_op_ctpop, type, dst, src);
> +    } else if (type =3D=3D TCG_TYPE_I64) {
> +        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
> +    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
> +        g_autoptr(TCGTemp) tmp =3D tcg_temp_new_ebb(TCG_TYPE_I64);
> +
> +        tcg_gen_extu(tmp, src);
> +        tcg_gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, src);

ctpop should read tmp instead of src, right? Otherwise the extu
immediately above is dead.

> +        tcg_gen_extrl(dst, tmp);
> +    } else {
> +        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
> +    }
> +}

