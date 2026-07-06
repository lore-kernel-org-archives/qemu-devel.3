Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C430C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXQg-0005mB-T5; Sun, 05 Jul 2026 20:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXQb-0005li-TN
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:43:17 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXQa-0004ky-CZ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:43:17 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so4285087a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783298595; cv=none;
 d=google.com; s=arc-20260327;
 b=gkdAJrXhz/cJju9An/q5Dxr+b0nDa6osEvx/AKhofsFlROaY81RL/mUM2jQ6U+rlXe
 3KUq5dfaB+WTIhnRfzqcaenwnfXSRhroP2I7Sx4mRP2Ua5nB81+SRHulr+62HwplTGWF
 W92Yw3HaxfFpBxz7g7vXV/grYGWzDZ6GBAkfabLJ1kyQEY22OP9IzQr8dmWCCYNx5LWZ
 gdxQFynfLZMyZxgrp1k2tqXdmMftnYMkchRV159VqZoYveFPdi0F0DzoSzXNkYaADgpD
 Q+Xpeoy8iAWLTHsn+9ysDBv0wSXtg/l36RCRM1aKDhYV3pAhh6QIaRQJtegioetdugtG
 sJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vip14HjtKGQOtuQkxEUIST0A0gAK0vfI2mPhzNy0LQA=;
 fh=F2jHHLOhAUdxIpT/mOESKAzlhKPgUW33d0+z1UtXHTg=;
 b=eAYe4u8cXmEqkksqMbh8ct9siDRO38v3i3oa1y72DkF96lyckhc0ykbSHsW68Q4LKL
 0qXmU2OQJZ/5Gb+cqTNHD2sId2daWHq5dqP8Q/zdehCPqAXatuXPTj5FIBPJxi1xx0jJ
 a8GEZExavFnFIBj6dm9YulqnuYQYrAV+kMp4FoRtUpbk4RRSAz75dGztggUV/sa7dSeP
 i09A+/3lPOhwzQ3HI1W5uDoo7vgsbYS9qfFr4JNMmilLfdEpBlw5g5vjDhnHMtL72irR
 ws3a/oZO2rxBaF/lfZl46LniDGVGPOPUIldNKAdPXQjZeeodBFeEJdrRfBMBy3fVNN9P
 Vogw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783298595; x=1783903395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vip14HjtKGQOtuQkxEUIST0A0gAK0vfI2mPhzNy0LQA=;
 b=IxwU3+SyUWhl5xe8jFRfcdcbvye5NbkD8trsvgZ8zNZWZWApQ58AvDmWEKLOaepCph
 P+6OcDHicZ+7VZ4xDbRHacvhkESPfNt1d9rMJDjKD4NGNpTvkfkmKDNDugj98gJyb2eO
 2ZpMaSwKl/6+PaRqB6XSFlW3cwH3ogUwqvhSpz29GHR6LCH+IurE7xMG024BxZuBFDK6
 PQJoMqDpte5eiHm3rqJ9E2bat5s5xZv6sykWC/+f0EOP/W/fEWAmFa7izyGjo25WafLQ
 aGcHlrHFSzcv6DdfqwLzGQ7+HkwH/Kk+KOmwF57iQE1q8UD0lIvFfI92+/3ze/O2YW0i
 Ca7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783298595; x=1783903395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vip14HjtKGQOtuQkxEUIST0A0gAK0vfI2mPhzNy0LQA=;
 b=UBPrLt774DfpdDSc8YeS0VULOAPdzYB+Ft/UG9YO2XTpeX17rQIJ6ZJAvpCm2wqovT
 +nlPnPlHPzfqjQR2JcdACUKh4+gMuCjveJGLhRtdokaI3gPaleLWeiK11PkikqOzXTXs
 hUejR0pPyNwsMGO6efF8weJMTpTw9KJ+hKD5rE1lIQjhyBQeuf7Hm/f9hXki9CkN85Af
 pC5NUw+1sqlKo2yqa2HiTG5fRDRzaZFLxZXIDapTJJ677GK0NCZ+a+5Kl0L0PoYUXjTK
 HQk+ImV6ol+wmTMmQQtoxfihpDQrOA+voSMY7GH8JkiseoZUxONJBxnF8igFMlAcFk0W
 4ZdQ==
X-Gm-Message-State: AOJu0YyI+EETTb0Lggi7HcUHg0cAuVTR7FYij2oSDWGcWCYGrXc+8OAo
 O1Jy5VULSyKIHD7K7RPM0JcyziGWgI9Ob2aUe8GQowqSbuMgdDlLM3NsRX8UsPWwrCAbA1U5akI
 whPhBc+tlNgZWSOCgkwJil4h0P3doaQQ=
X-Gm-Gg: AfdE7cmid003Y3B7heYFTSCVvWrIYkuFVCDyxs4chBHS5/ElGeVEK6/k18TmAwJfHKc
 C2Pq/TMlBiJsjEc3r3H54H/NBZmCnNANTPGUnFnzPOOpJCjb3MOy8oAw4lyscrdKaSP61nI83Aw
 z93jcDnUPnhIPZp7FX6gHfuByZawS3h8SwCvm6TbeocCvrR7whdHdXD4RLiQpXC/ayu2Ye+bGYN
 L7+zGxyitqTv94b/iy3pud39q2m47QPUZU/vbnpCg25dF6EALvvyAGhz4x3XKxIPXOAxvPxUEwr
 aadnECNsvzmGnDMVVEeedWaE2v8=
X-Received: by 2002:a05:6402:4345:b0:698:ec2f:d6c9 with SMTP id
 4fb4d7f45d1cf-69a1ab2a74bmr2664158a12.14.1783298594475; Sun, 05 Jul 2026
 17:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-18-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-18-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 10:42:47 +1000
X-Gm-Features: AVVi8Ce3wfHYya6HsvEyV6rXok7TBCKfr_5x-Wdy4fErHydDCSAacTXGzfakX2k
Message-ID: <CAKmqyKPRQVBBwsPX_+m3K4o10UdRYAqv=de_VJAA1_SC4dW8NA@mail.gmail.com>
Subject: Re: [PATCH v3 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Thu, Jul 2, 2026 at 11:53=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We have a lot of TCG only initialization in the common cpu_reset_hold
> callback that prevents --disable-tcg to work.
>
> Put a CONFIG_TCG ifdef around those bits to make the build work.
> Eventually we'll create a TCG specific reset function in tcg-cpu.c but
> for now this suffices.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6b79dcc5ee..5a82e6563b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -965,10 +965,6 @@ bool riscv_cpu_has_work(CPUState *cs)
>
>  static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>  {
> -#ifndef CONFIG_USER_ONLY
> -    uint8_t iprio;
> -    int i, irq, rdzero;
> -#endif
>      CPUState *cs =3D CPU(obj);
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(obj);
> @@ -1020,6 +1016,10 @@ static void riscv_cpu_reset_hold(Object *obj, Rese=
tType type)
>                      MENVCFG_ADUE : 0);
>      env->henvcfg =3D 0;
>
> +#ifdef CONFIG_TCG
> +    uint8_t iprio;
> +    int i, irq, rdzero;
> +
>      /* Initialized default priorities of local interrupts. */
>      for (i =3D 0; i < ARRAY_SIZE(env->miprio); i++) {
>          iprio =3D riscv_cpu_default_priority(i);
> @@ -1057,11 +1057,12 @@ static void riscv_cpu_reset_hold(Object *obj, Res=
etType type)
>      }
>
>      pmp_unlock_entries(env);
> +#endif /* ifdef CONFIG_TCG */
>  #else
>      env->priv =3D PRV_U;
>      env->senvcfg =3D 0;
>      env->menvcfg =3D 0;
> -#endif
> +#endif /* !CONFIG_USER_ONLY */
>
>      /* on reset elp is clear */
>      env->elp =3D false;
> --
> 2.43.0
>
>

