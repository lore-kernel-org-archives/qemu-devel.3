Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87153CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvGZ-0000FR-Ji; Thu, 25 Jun 2026 21:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvGY-0000Eg-4U
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:21:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvGW-000613-K3
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:21:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6974ef0c3b1so482079a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436915; cv=none;
 d=google.com; s=arc-20260327;
 b=Ml9UEHQ3leBWf6DEuwToSdYzN893AG6FoKy1jjw6Qu3LSb/uu9FxvXyIHfcO0Y/LWa
 q+5NPplp4SG+7MIx/KOlVMoKtWHfhiPImZv/BglajN7jezoIaDy060GsbvtpZKtLynKF
 QYMvKJsVl88CouaflQ+EqiWouwXwQP0vQ78vzQrbZlVTKNV4tn7nZbUheBFwDAFH1fJF
 B02Ktun+7rn1GOZK87Qcyb4m0ydS84CYu+1oGGmjoVrZYiO5UwSenBschVR5J2F6efTh
 i4d2QMPNKliSnqGpzAw9+kje+rG71ZkV+UgO9GnFNZSY1Dbt+KpJOX3td9yiov3JzHfj
 1uMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zw6Spuw9dXNiOJVxyPosYsHQlTBndA5vPnf161OzyX0=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=GH4J9D+GTEIvR2w089XP0j/6pfDn4vGOferoDQM+zrZwbZtyJ/1SjdgBewTvKfyx17
 3CWm+qiwogqqygBV1Ou2PtJPnUgQWqjObFGIWTh4hrpszRFc/X+lwCr6dye7MamYUro0
 xWzn2YBx8bffDaKHoczV45R793joBHxj6YMc1Oz2N+C1Tb2InZY3ksbc2vBYrItu+0Zu
 oMq9/bhBvWh6lKzVNhZdbHWD3Sbh/FD80hCxcgJ2aSqHHbrU4a8mALW+Yrw6kFTUlL0H
 Q+Sh3xXZyGEnzQv+FRu13oghUCm0u98Wcob/c01OnPaQnKWsJ1rsjwAZsAiN9xbHdPmb
 m1wA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436915; x=1783041715; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw6Spuw9dXNiOJVxyPosYsHQlTBndA5vPnf161OzyX0=;
 b=phk+cLNZ9s3n6hYMbmaFKdYS/7XY407imPrX/2n1IwFL5tgBOxctD2sk5Yg/OpApuh
 07Xhz5/8zhHdAIt2URpHlgFbYVPyoJOx/NOKthwdqFGlBG1RxEJU/CXb+WQpPWWXNZ5b
 DrGc3RWjByUdukocXLqLNA8t87FfB4MfqpOB6AF7rUag2KPKnpJ4S7OQTGusa17zvuNw
 +DSxFe+mPIFqQ9UqHyLnV7ntGdvvzbMzXkVyp2rKtmpIH3hFPZ7EFAKiWDhTOY0SFxHb
 OhddjOM9m0R/kXDLTgObUutV84z3md9uuBct0k44f15KQQ6eJaCqPLFZvZLGbbcWMmAx
 8svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436915; x=1783041715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zw6Spuw9dXNiOJVxyPosYsHQlTBndA5vPnf161OzyX0=;
 b=JSIyURBapHuv5x1x3Tu7rLM5tUFOdP/xon63NoJYAQvE9t+FDkZY6RYR4lAfKan7MQ
 C5v9kulJXlgmTRVNUAYcFSL9c48nvo+6sGWEeHL8MCpNBA9LA5ercmY22DYnPJIu+eih
 BKXkO+f+/lWmQZVLKGZ5W8cHr2OVpZwUA4V6g/dP5R/5cu2+X/RCO6Clrwem7VP/Pc1P
 Zb/x7NBUAG+GRCx3mu65Knowwj4aVQaQZicVyrKzSRH183iLafpFURzJs0CQT6ppgIIG
 8Aqdzc/ppVarE8i/m3royLaK8eDMjF3yhNepY+ikNt/t/MjvJStx9im+GDq6xyRo+h4y
 Gc0Q==
X-Gm-Message-State: AOJu0Yz1njCx8Bxz21fLZl8wLzvg3Fs5SAukUMpi5JN7MVNDWUGrf9lI
 qX9kIw5iF4LDaDyKPZHegBM8EcMURPDHFU7N4h+k87haffrpzvH1rx5Pae0kexJM6TQ1t9w98iU
 /r8L8C+XP09V6aVFbHWFgMKslFb868gk=
X-Gm-Gg: AfdE7cndw74AyxIU2lwwOlX85cpkiyVRUFnucDH6v4w9zwHUgOT2p4s0Ux2udEjQufL
 AFsssXz/JZcOjb2jTwMgKGYf/4vEBiSh6w35Czt1ZbY7okKVU5iNsIcEj2X06+MieZTCjOdysNB
 XMrAyqEWqlWV+vdkBZP0EBXKsqIBV95Qp9nwPSySN/shcX1g70rfiJCDWuEbvMjva4+aZfxBlRG
 ndUybzbYC5dNKCyAr/cIpJ7L10+J41ns5/jDxWKX59jhJ+68CWxZ5c9O+YKB8ZylSOpUMEglAiD
 OeX+QTkvznGKDlsQGSEPHPeLrz0=
X-Received: by 2002:a17:906:eec9:b0:c05:b9db:68cc with SMTP id
 a640c23a62f3a-c1205b386famr324570566b.0.1782436915242; Thu, 25 Jun 2026
 18:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-21-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-21-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:21:28 +1000
X-Gm-Features: AVVi8Cegl5rOnU3eMP4xPgZmYsDhKR3OFn6GqymDSY_YZZtSURClYUe2E7C7_cg
Message-ID: <CAKmqyKPxmjpC6Ey+5cGB=SHCjuAagGTb+cFXo_kiB5ehPJSjUg@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] target/riscv: move riscv_cpu_set_rdtime_fn to
 riscv_aclint
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Wed, Jun 24, 2026 at 10:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> There's no need for it to be in cpu_helper since riscv_aclint is the
> only caller.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aclint.c        | 8 ++++++++
>  target/riscv/cpu.h            | 2 --
>  target/riscv/tcg/cpu_helper.c | 7 -------
>  3 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index e27e5fb394..361a8d1bcb 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -40,6 +40,14 @@ typedef struct riscv_aclint_mtimer_callback {
>      int num;
>  } riscv_aclint_mtimer_callback;
>
> +static void riscv_cpu_set_rdtime_fn(CPURISCVState *env,
> +                                    uint64_t (*fn)(void *),
> +                                    void *arg)
> +{
> +    env->rdtime_fn =3D fn;
> +    env->rdtime_fn_arg =3D arg;
> +}
> +
>  static uint64_t cpu_riscv_read_rtc_raw(uint32_t timebase_freq)
>  {
>      return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 396d9253e6..d6c5d6c1db 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -682,8 +682,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uin=
t64_t mask,
>  void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
>  void riscv_cpu_interrupt(CPURISCVState *env);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip valu=
e */
> -void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
> -                             void *arg);
>  void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t =
priv,
>                                     aia_ireg_rmw_fn rmw_fn,
>                                     void *rmw_fn_arg);
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index 9237d2129b..822c9fe483 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -612,13 +612,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, ui=
nt64_t mask, uint64_t value)
>      return old;
>  }
>
> -void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
> -                             void *arg)
> -{
> -    env->rdtime_fn =3D fn;
> -    env->rdtime_fn_arg =3D arg;
> -}
> -
>  void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t =
priv,
>                                     aia_ireg_rmw_fn rmw_fn,
>                                     void *rmw_fn_arg)
> --
> 2.43.0
>
>

