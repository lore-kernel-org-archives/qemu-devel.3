Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B721C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXS9-0006Pl-LQ; Sun, 05 Jul 2026 20:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXS7-0006P0-U1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:44:51 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXS6-0004vc-Ax
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:44:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso4759158a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783298689; cv=none;
 d=google.com; s=arc-20260327;
 b=f9OeQ2NXqGir505wQrXYNsQBsJNeFa38my3LYtz6fdUrFcAVqiT/KxP37EQk3f7222
 385OgMnoOLaSBn0c3OXuR1qUBM5CDUb81glHz1apCUWSGKXUKqb1mSEZFX/2RV+znm0P
 8smS1GQxnDS0GwsCaVDBuC06GGsr4CmaEucHVTuj9m2c8vR2tbT1CuSbKHysinS/9mqz
 eUmLQaTF9qPQsN5WRLjRl7Fes9FxiJWhNPFdk0ubCCVVUKggbdSkVhkLHjR+FBKWsCs8
 q8D3eNDFsqyw1xa9o1JEnhTb9aSKEPQU9PM4wdw80Khle9EVzMEsa3cLz4dMJ7YMhdPQ
 0Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CcJvguEpjF2Le86U6ahpmHEv3eDT1qNTbQKc9DfMEfc=;
 fh=F2jHHLOhAUdxIpT/mOESKAzlhKPgUW33d0+z1UtXHTg=;
 b=aQOYfTc+u8+gSqREw4Vn/698hD67wSg/X5N+e3Ak8k3NOpMr7S9/v8gEJ97hPmKbfe
 eStsVzW02TBfy+bXuACoqsxoa2WXFmxQaf1nuYvKU5+hzjoaCzxi4/UM3jmhxrrj/yzy
 iwYVPabFMBaemKp4lrqZOzv7A+ftNQA0cDbLWeMFMUFg6Za3zPdAKxLWv3UkxLZjt7Yn
 A0j3bMRR1TgyDjxGvvUdniuhi8pkkcK9c7ewzL2XCNaYHVhxkr3RwGrz6w2T4b9vUP5p
 iVbTlVlY5xBWJu2aLmwLC8YDWEPICKohdhwfREWhsuhiXObGGk0nZoMUSlLEdgMN9HoT
 a/QQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783298689; x=1783903489; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcJvguEpjF2Le86U6ahpmHEv3eDT1qNTbQKc9DfMEfc=;
 b=cT8vDGz9GUZRq9/fA353PopLVOWT5MMz6FHPHvF1DZNaJThPZVDPt0PhyTLYOtxwhj
 /mIjrTTlGdgPlBPEiBIa9T/ldEZknI08zlvImn30nyLLPFeCsLMf4nYFaU/iy+QizDGG
 MtpOZ5leRKWpzfI5paPSmCdCgxGHvfyd6WXhysO2jcuYdw+veNWN3ORYK0d67KG9k7+Z
 kaIJbnBK5Eh6XBAODaWQVlOvueegHw3kAWZ/mH+L90XTyOGPS80FFGqslPawTdamRKMw
 aSn5uBGnGjNzJDixd//FxPF8dvDC7d+BEKXzjowjiFlaE14k+NdS66fGVk4fg3rSgQbG
 mbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783298689; x=1783903489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CcJvguEpjF2Le86U6ahpmHEv3eDT1qNTbQKc9DfMEfc=;
 b=jyOKCCQkPKEmpp4L/sPXwrFxOp7MTJnPrekJJFdXVlYVQcdl2vsAlaWBCJ91OZhqFd
 SrmwISgsOhK1thcA/oX6eSsWoDXWFHAKZBH3EVETWaIn/MrXyEsuWV15itn625dmf3dF
 qL0D5ukVL9bg1tdS3Zrzmq/NPBSJIP52d8/hPGw0m+vEH3JKoCxj2aDEnRfCB6YLxNA8
 87jEVLynVIVkIxsc1XJT/AV/I+NlNQwsqTC3K+BwQFHQvKVNt/l89ZIEbEdQBeM7p0eU
 huHbysxjuduvmwEwuUhMBovt17wwZD7AXu5MIYE3vk/Zqsmrncox+97M63XadN9WeG3f
 5m9w==
X-Gm-Message-State: AOJu0YyrKfn7cgS7wUdy2xuQZYmTaHKH5hHnvDOvsNxiLM4PDfZzW/Y9
 HlClOGPKD7KNs7X7XjtDrbhsSx9PkIUMUYxGBGRRisWa6XtCgLdS35csNqkJ2RrDhne1MhGpU1d
 0Dlm7I9N+OQNS3oKTkNGJJMEZo73AqKA=
X-Gm-Gg: AfdE7cn9IizTerDgfsbUqtECEE0IE9CPiyUIHd0WPpaRyPpsis4TiYL9wGXZX7iVosg
 IlpepriwVi/M9cUrvGCwBZRowox35KgCA66Hhz9U3QHNaQipEcqu4hqDegN772vF+YCTY4+lSpJ
 DILkE5RtsWoW2EVbWAYyOJqa8VN5gsKkX/Idg92m4jC+4fmekXidVtzLNPwCTOLkoCX0LHGyyhD
 YULt5H+vOj/sxg+zCuCmsg6cMHEPkZtjMJR6/8XoipjKDvMF/At2BfgxnEzuKbA11MAS8IccxWa
 LNienabqw0RJhxtaUD8taORJBlU=
X-Received: by 2002:a05:6402:11d3:b0:69a:bfa:cb1c with SMTP id
 4fb4d7f45d1cf-69a1a3ba170mr2759319a12.31.1783298688796; Sun, 05 Jul 2026
 17:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-24-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-24-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 10:44:22 +1000
X-Gm-Features: AVVi8CfAJMRW8UxjljTqn5elIHyJowFm2P_rHvhzIrlLITNTmYXcegOgQ1MwabU
Message-ID: <CAKmqyKNcXzr+bmUnkGidkEjyXBpuS=r2swOBmFbQNTwP19EFXA@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] target/riscv: move
 riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Thu, Jul 2, 2026 at 11:58=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_imsic.c is the only caller.  Having it sitting in the TCG only
> cpu_helper.c gets in the way of --disable-tcg for no good reason.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_imsic.c         | 11 +++++++++++
>  target/riscv/cpu.h            |  3 ---
>  target/riscv/tcg/cpu_helper.c | 10 ----------
>  3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index ebb55191c7..d6b46cdca2 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -376,6 +376,17 @@ static void riscv_imsic_reset_enter(Object *obj, Res=
etType type)
>      }
>  }
>
> +static void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env,
> +                                          privilege_mode_t priv,
> +                                          aia_ireg_rmw_fn rmw_fn,
> +                                          void *rmw_fn_arg)
> +{
> +    if (priv <=3D PRV_M) {
> +        env->aia_ireg_rmw_cb[priv] =3D rmw_fn;
> +        env->aia_ireg_rmw_cb_arg[priv] =3D rmw_fn_arg;
> +    }
> +}
> +
>  static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>  {
>      RISCVIMSICState *imsic =3D RISCV_IMSIC(dev);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7a4d8abe07..c9dfa7daff 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -680,9 +680,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uin=
t64_t mask,
>  void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
>  void riscv_cpu_interrupt(CPURISCVState *env);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip valu=
e */
> -void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t =
priv,
> -                                   aia_ireg_rmw_fn rmw_fn,
> -                                   void *rmw_fn_arg);
>
>  RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t =
bit);
>  #endif /* !CONFIG_USER_ONLY */
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index 71a96a20ef..07d9222652 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -590,16 +590,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, ui=
nt64_t mask, uint64_t value)
>      return old;
>  }
>
> -void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t =
priv,
> -                                   aia_ireg_rmw_fn rmw_fn,
> -                                   void *rmw_fn_arg)
> -{
> -    if (priv <=3D PRV_M) {
> -        env->aia_ireg_rmw_cb[priv] =3D rmw_fn;
> -        env->aia_ireg_rmw_cb_arg[priv] =3D rmw_fn_arg;
> -    }
> -}
> -
>  static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
>                               bool virt)
>  {
> --
> 2.43.0
>
>

