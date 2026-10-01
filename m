Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57724CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCFAs-0006Uw-A0; Thu, 01 Oct 2026 07:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCFAq-0006Uc-Ip
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:42:04 -0400
Received: from mail-ed2-x0c.google.com ([2a00:1450:4864:33::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCFAo-0000fs-CJ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:42:04 -0400
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acbdf627ccso3480707a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 04:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790854920; cv=none;
 d=google.com; s=arc-20260327;
 b=nmwaZzyiCMjxzaj0yfROQr9Zb1ft3mF1z3ZPk4lF4rhJ3dt8u6vtWXmBFQbPXLXylM
 Nop5TcDg+iOVe3cndQZI7wigeHgSXi5F4yRz1Dc9UFN4BLIabPxQZVpXhMKJL00EPJuS
 RfFoMhQ/LZYj04banhgFGB+tk2r708MkCVXcV3fiAV2Tntrufi08ph5Rk5LXZuMIbJVL
 DBZ+kdCbFahfC7E9DzfmL7WsU7ZxdK+ONKcetLcWJdVF8ovt/G1kOesyzoObAJZ2Tjuj
 B0cXULH3ZE3ehO/jX+WvJ4LBgU8dkbehzRBHJjivKX7u7kmOnRXwLhUUFB/nyCf1QD1I
 ZVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=nmZQ3RNqeCioaBWo8ptd7DIaFKJ7apfa1suXidIrHL8=;
 fh=7Qy2OUPUiv2W99GbnVhySuV+mvIvEUdqiNon6sOy69Q=;
 b=YkeyHQvafAJYneuGgMGx6bOh13GSwJ8uyYyUyPz2afGoXzajZymMj9tWu7IWf6y7Xp
 vRicKJQK/qVYIhOnELMNHvLy/BYGj1sDvxjJgGGXyaxAzD6iF5xN7jTjOA9p1fGTwTC4
 /0IpF4fehl2l5da5Bxi44ayYgGxfR74P8bI+OP1poJ1YmW1ReamskMl6CFC7AXdmywf6
 foPZLwWqmkp5LDbNzLRYjiDnnrh6SE/ucn2lRg+HhuAmDDiZVRTkeGAGGfWDENmmp1sD
 GmHbDi8uZNqJ5/kU322V9iIWXDvdZyzTetp3aWdiuV1XmMvisJTvVbl75WUTlJlXipx5
 6nyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790854920; x=1791459720; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nmZQ3RNqeCioaBWo8ptd7DIaFKJ7apfa1suXidIrHL8=;
 b=IYeuubLjNjQJ3BGbBgH7CYzyJYqxSCusPbzcjkPqhjsWaA4z2BvWSOmBr5SX1erWqT
 eqK+CDle1BkgHYgMSmMWZoi5F1p0Zo71uGIjfoopw6eLbxr0HZiYRiQ/zTvs6yaApyaQ
 EHTQq23kJL6FQqD3E3ihX+CfTqNSeW4W4is0M/fuDPPEuiQLe6FFAd75f1WXLB1/X8S2
 dUFES7SrYa748wzVOMpXP4XLElcYvQPg+66Ij3hlEv7EKWnGK+BnH06NYvC/LBFhqi/p
 pUcoTJRi/ZJavNhGvAiigkS/Lv9/Yh2fSiXHOcXD77uR6nJqVNnn6qLC/SuDJ7rLKdMO
 d47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790854920; x=1791459720;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nmZQ3RNqeCioaBWo8ptd7DIaFKJ7apfa1suXidIrHL8=;
 b=AFKAxFG2sqYpn0pN57ZmevhD2QQG+4sw0HrzsnAqrLD5cDqdsrDMzvG0DfWY2fER/r
 PXnlKl4ySYOaRTrBGu+3fBLaEVJNUm2OfuTFCKpB3Src3dtDmmja6xNZTa5Dkl8/JVUE
 ndK0U9rsCJALfIHBKQQw0v7Tny4F9Qfl1XCh1TCy+PoZV/yj1JYvEWQ5aEL+NgFrn5zW
 /fafwgqxyYGWoiYOFciJup4rXjib1RAHjkuuXFESlWLWmR2hXa9Ys5uIKRmFT4qKvClr
 6G4KhRFErbUXhaw5kN5NHGzcmOY07uaPXqxGQ0BbZJS+h83tV0oMKxY5huQvQFGM8/cD
 yrsg==
X-Gm-Message-State: AFq9FYK187v3AUIjGgPw8OaBeg2NbHzNtDz4zKHoVALCllpRxNfY28UV
 +12ViqT1Ou2RD/Ee0/jf/xKlu3Rbv4ZrKJdSuIROPD5OQY7IpgfrIf7/X5Vz3g4kVjyCU7DDOKf
 jxDQjblRIZGt9wAov8OFGB9SgxnwjP6E=
X-Gm-Gg: AYBFou20Ab0NRL8qSpXd2SwkTBmnmJUZcvO9c/PgcCmU8lbYgbYZiyhJpwjGnQ2AXfQ
 H54iZfrvXcJGKtBVGBoBv9N5DGctuKLh5ZnxK3IHFPU3WKgY2ydQ3XbxzMrPOhgPiFtiNLnMDqz
 EiQppaJW3GK+WdlIzbXVPdAcWccBdFLlUP+w257mxmjLv/2Ok/ZeldRjDWvcxVTw5EGPRQ12aS9
 GXgDTiVl3YiVRR8SMHWixC2IM13jyAtHcchrTCzxKvpn916O4lOZT3MRqac3tWM/AbSF3XzoBkC
 uCIJ1m45tTPQ+Pue76T7wOgK7VpBSChA0lekGFnE5ENpuyCtRBFg9O4=
X-Received: by 2002:a05:6402:27d0:b0:6ac:9375:a161 with SMTP id
 4fb4d7f45d1cf-6ae19921f27mr3435534a12.28.1790854920316; Thu, 01 Oct 2026
 04:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
 <20260930020108.217892-5-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260930020108.217892-5-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 1 Oct 2026 19:41:46 +0800
X-Gm-Features: AclHuK-IKtOkkHdoB2f6z8qCBC0QebYnOryIJlkvE8RjXtyU6_Jpn3t7lo4msOs
Message-ID: <CAE2XoE_XCgvZLZL8xpRcyw9b_vNXA3w8fmnbd0X4q_-8wjtoxw@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] target/microblaze: prefix helper conflicting
 with other arch
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Pierrick
I have prepared:

Subject: [PATCH v2 4/6] tcg: namespace target helper symbols for combined b=
uilds
at
https://lore.kernel.org/qemu-devel/20260930073935.712-5-luoyonggang@gmail.c=
om/

to deal with these issues in a generic way.

The idea is comes from Philippe at

https://lore.kernel.org/qemu-devel/816d8db4-ef58-4eab-be12-6d239300ffe4@oss=
.qualcomm.com/

That would help us to avoid these renames. do not have to be such way,
but it's a option.

On Wed, Sep 30, 2026 at 10:04=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  target/microblaze/helper.h    | 10 +++++-----
>  target/microblaze/op_helper.c | 10 +++++-----
>  target/microblaze/translate.c | 10 +++++-----
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
> index 1429c1727ef..63a94ac4bbc 100644
> --- a/target/microblaze/helper.h
> +++ b/target/microblaze/helper.h
> @@ -1,15 +1,15 @@
> -DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
> +DEF_HELPER_FLAGS_2(microblaze_raise_exception, TCG_CALL_NO_WG, noreturn,=
 env, i32)
>
>  DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
>
> -DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
> +DEF_HELPER_FLAGS_3(microblaze_fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_3(frsub, TCG_CALL_NO_WG, i32, env, i32, i32)
> -DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
> -DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
> +DEF_HELPER_FLAGS_3(microblaze_fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
> +DEF_HELPER_FLAGS_3(microblaze_fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_2(flt, TCG_CALL_NO_WG, i32, env, i32)
>  DEF_HELPER_FLAGS_2(fint, TCG_CALL_NO_WG, i32, env, i32)
> -DEF_HELPER_FLAGS_2(fsqrt, TCG_CALL_NO_WG, i32, env, i32)
> +DEF_HELPER_FLAGS_2(microblaze_fsqrt, TCG_CALL_NO_WG, i32, env, i32)
>
>  DEF_HELPER_FLAGS_3(fcmp_un, TCG_CALL_NO_WG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_3(fcmp_lt, TCG_CALL_NO_WG, i32, env, i32, i32)
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.=
c
> index 3da0c68da39..c169312e954 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -62,7 +62,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
>      return 0xdead0000 | id;
>  }
>
> -void helper_raise_exception(CPUMBState *env, uint32_t index)
> +void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
>  {
>      CPUState *cs =3D env_cpu(env);
>
> @@ -154,7 +154,7 @@ static void update_fpu_flags(CPUMBState *env, int fla=
gs, uintptr_t ra)
>      }
>  }
>
> -uint32_t helper_fadd(CPUMBState *env, uint32_t a, uint32_t b)
> +uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
>  {
>      CPU_FloatU fd, fa, fb;
>      int flags;
> @@ -183,7 +183,7 @@ uint32_t helper_frsub(CPUMBState *env, uint32_t a, ui=
nt32_t b)
>      return fd.l;
>  }
>
> -uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
> +uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
>  {
>      CPU_FloatU fd, fa, fb;
>      int flags;
> @@ -198,7 +198,7 @@ uint32_t helper_fmul(CPUMBState *env, uint32_t a, uin=
t32_t b)
>      return fd.l;
>  }
>
> -uint32_t helper_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
> +uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
>  {
>      CPU_FloatU fd, fa, fb;
>      int flags;
> @@ -352,7 +352,7 @@ uint32_t helper_fint(CPUMBState *env, uint32_t a)
>      return r;
>  }
>
> -uint32_t helper_fsqrt(CPUMBState *env, uint32_t a)
> +uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
>  {
>      CPU_FloatU fd, fa;
>      int flags;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 8b219afb5dd..16794059a22 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
>
>  static void gen_raise_exception(DisasContext *dc, uint32_t index)
>  {
> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
> +    gen_helper_microblaze_raise_exception(tcg_env, tcg_constant_i32(inde=
x));
>      dc->base.is_jmp =3D DISAS_NORETURN;
>  }
>
> @@ -421,10 +421,10 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TC=
Gv_i32 inb)
>  DO_TYPEA(cmp, false, gen_cmp)
>  DO_TYPEA(cmpu, false, gen_cmpu)
>
> -ENV_WRAPPER3(gen_fadd, gen_helper_fadd)
> +ENV_WRAPPER3(gen_fadd, gen_helper_microblaze_fadd)
>  ENV_WRAPPER3(gen_frsub, gen_helper_frsub)
> -ENV_WRAPPER3(gen_fmul, gen_helper_fmul)
> -ENV_WRAPPER3(gen_fdiv, gen_helper_fdiv)
> +ENV_WRAPPER3(gen_fmul, gen_helper_microblaze_fmul)
> +ENV_WRAPPER3(gen_fdiv, gen_helper_microblaze_fdiv)
>  ENV_WRAPPER3(gen_fcmp_un, gen_helper_fcmp_un)
>  ENV_WRAPPER3(gen_fcmp_lt, gen_helper_fcmp_lt)
>  ENV_WRAPPER3(gen_fcmp_eq, gen_helper_fcmp_eq)
> @@ -447,7 +447,7 @@ DO_TYPEA_CFG(fcmp_ge, use_fpu, true, gen_fcmp_ge)
>
>  ENV_WRAPPER2(gen_flt, gen_helper_flt)
>  ENV_WRAPPER2(gen_fint, gen_helper_fint)
> -ENV_WRAPPER2(gen_fsqrt, gen_helper_fsqrt)
> +ENV_WRAPPER2(gen_fsqrt, gen_helper_microblaze_fsqrt)
>
>  DO_TYPEA0_CFG(flt, use_fpu >=3D 2, true, gen_flt)
>  DO_TYPEA0_CFG(fint, use_fpu >=3D 2, true, gen_fint)
> --
> 2.43.0
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

