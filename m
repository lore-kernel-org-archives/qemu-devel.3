Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93088C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXWk-0008I7-BJ; Sun, 05 Jul 2026 20:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXWd-0008Dl-Qj
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:49:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXWb-0005jh-08
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:49:30 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c127a694ccbso303482666b.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783298967; cv=none;
 d=google.com; s=arc-20260327;
 b=R4EWUl1QyxwuARlaoVGhAJqOjO0aRgKnS4IC8JO6iPVcLdQqmCFj4x+tDQ93tQKfgq
 2jcWoqWnC24or2qpQ6Q++OfyjKcfKZs3q8o/1uefPzV5f8KsCsYoeuk991Zg6w9g4OS8
 6pO9fRY9NnmJlY00wIFk5c90hN8IedxNQ4aJIGPOfBImjtawh7yFZ4PGSG/xbdKqyv41
 JleLIF5r/HSUMOlnjjgxXkJbZ3cA33uhamc4sZ8i/131bpl9fNw2d6MZapuxWAfsuVl4
 ynURmqpohmFzOq7HiQbJ7kX7KkGjL+Qw/B0N/rk0oGMANOziERHnGLfZ+XpqnFr5nb2/
 RVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IpEQD+QbHkBTdotZo1bmOKvlBnTLOFB0i/2915gcx0M=;
 fh=F2jHHLOhAUdxIpT/mOESKAzlhKPgUW33d0+z1UtXHTg=;
 b=pIdpbxKNXAvHynVJWflCqOa/7b8ItL861H8m2raAZcTm8+utT4yNjFG4diCZQ2Xdm4
 yRpLJB7GQSkKpwspe7wsvQkcmLvJWerX0tSTBFWvmWSXEcWw+TCyRymW2CSuWSIrMXNV
 ikFpLV6ZpcKdmXzw4M6Udh0DINSNYegHz70767erb8R3P5ansmuQFGoqRWEvcWIj6xLa
 wODdEqYjqzbu3cvBLeySCZjMNZTdlVMrT+nJccuNtNhv+14NMzSWZ505AxqNV3MjM7fI
 xr7dMTUrJojTsi9MIsmgEvHZfWzWjIB/EySfeNmDag5pXExFFe57/aFpjWWjfbetadlu
 rk7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783298967; x=1783903767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IpEQD+QbHkBTdotZo1bmOKvlBnTLOFB0i/2915gcx0M=;
 b=gmOCy/GLM7scVfeaiAYiMjvchcAMGDvgDdadFVGdaEWxQhtXONiKgFLK3Uy5plotWK
 n4aCOjMrt20l6KCktZfFKbndcWvN+2szoYSCD0xuZouWYl7X0LNY1Y/JhWEMgktf/jgh
 GX3m883mAOfHs92G4+VJHqkYQsEhR3ApVZLRZQ1GBnN9UhRJp52v3mBEqLr2u7tiUFxC
 LqENULqyGfSoUNYM4P5jVYZ2i77oQJPN5dKK7Hg0dkd+IdT/sxN2rs9lZmkiOO5NoxMj
 c0iRletr6iXLbfgNQnxcPtxHsBB7mEZ4WQxfRHMdRTdy9VZo0YQIh8xOMoo/vTxKURwH
 I6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783298967; x=1783903767;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IpEQD+QbHkBTdotZo1bmOKvlBnTLOFB0i/2915gcx0M=;
 b=BIrrZ2DxMmq4GXeV+NnBNYjdaHdPUEOGMmTbkXgtfRNUREmj3rW6iO8f8z/ZymwnQi
 8q0iu4EAP1vginffSnAe9EJGl6mYhBrYgddZzKN/F/MXBiM2hEj/QKgWm5tFkYep5xHZ
 YTvgflabT6sNBu9mwBwlQ5El9lvUVoQa3pdwEY0MjdwIopcKs1BWIc+kBFsucKEegH+G
 mg4kOSklMv8KULVFq94f5p9IthQyWpw0GNEOg+tofpKuUelh60JcPWNPHvFU97dqdmiB
 IZc+lgmKmfplsev0RLrfncXQ1QWaWTm0pgGBFvYXA0K8G9Q8MK7zIxWOfzfxSuEdrbsT
 s3Fg==
X-Gm-Message-State: AOJu0Ywqi+LccNR4d3SiyuUa3N+FdRy0Ck80YVda5vnZaP5gS4vmhUyb
 6eS+VFl4AjngCgUJ/+VQzoYMicHbIzy4T1L32BwbhuJQuP6Y4dmm/A7Syb4OpaIx2QGy5V4kvAu
 DUEQ1gxHQArmQMgfWApCBIz89ZrVR0mI=
X-Gm-Gg: AfdE7cmf9vGnkbdSzHdrt7c0ML3DQnRaM2aga1QIuctZ8+4SN+BwwF5T1JKv2p3HNxF
 lAdm49kd5/1UUfeF2r9df9/hFipn2LXHPeDqm5w/myhnWI9fzfaBS89d4WYIh0DbUl0MOSCsZB2
 bqw9Imb8m0IRVSmfLNJ0kd6LO8tTCXGvxtjCYuseFp4GM7IJ6MIXV6Eu/nKz7UPGIL4EqF3KoCf
 Hg1dg9Dd/b4K7KCQyuMBJYIlRWPvRcApmt2IBfJGtWSTbBuxrcwwm36xBNCAmlVMsIHXsfa9Y6r
 ty6WQeE/uER+0kyWml6RH/T8gCo=
X-Received: by 2002:a17:906:fe0d:b0:c12:79aa:8282 with SMTP id
 a640c23a62f3a-c12e6902f3emr283922166b.12.1783298966918; Sun, 05 Jul 2026
 17:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
 <20260703180538.3346781-23-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260703180538.3346781-23-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 10:48:59 +1000
X-Gm-Features: AVVi8CfQANyT_HfBUEHooi3p47iyQiG40gKErwkMMTEFzzDvyIpTVvBVw6k516Q
Message-ID: <CAKmqyKMjXMqW=kxjWXdoAH_PsufPv=+KJ1uh=_SRz7ZU-0kPaA@mail.gmail.com>
Subject: Re: [PATCH v4 22/24] target/riscv: move riscv_cpu_set_geilen() to
 riscv-imsic
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Jul 4, 2026 at 4:08=E2=80=AFAM Daniel Henrique Barboza
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
>  hw/intc/riscv_imsic.c         | 13 +++++++++++++
>  target/riscv/cpu.h            |  1 -
>  target/riscv/tcg/cpu_helper.c | 13 -------------
>  3 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 7e5b5349ba..ebb55191c7 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -46,6 +46,19 @@
>  #define IMSIC_EISTATE_ENPEND           (IMSIC_EISTATE_ENABLED | \
>                                          IMSIC_EISTATE_PENDING)
>
> +static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
> +{
> +    if (!riscv_has_ext(env, RVH)) {
> +        return;
> +    }
> +
> +    if (geilen > (TARGET_LONG_BITS - 1)) {
> +        return;
> +    }
> +
> +    env->geilen =3D geilen;
> +}
> +
>  static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
>  {
>      uint32_t i, max_irq, base;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7618110412..7a4d8abe07 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
>
>
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> -void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index 6b39152ee2..71a96a20ef 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -526,19 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *e=
nv)
>      }
>  }
>
> -void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
> -{
> -    if (!riscv_has_ext(env, RVH)) {
> -        return;
> -    }
> -
> -    if (geilen > (TARGET_LONG_BITS - 1)) {
> -        return;
> -    }
> -
> -    env->geilen =3D geilen;
> -}
> -
>  void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
>  {
>      CPURISCVState *env =3D &cpu->env;
> --
> 2.43.0
>
>

