Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452AFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXW5-00081U-74; Sun, 05 Jul 2026 20:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXVu-00080N-H7
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:48:46 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXVp-0005cp-SN
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:48:46 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso4447440a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783298920; cv=none;
 d=google.com; s=arc-20260327;
 b=c3T3/QduTMEhWzsl/VPp1Hhw05R3S9WZgfria4qBU8gkOlc6MABVl3wAFSV2jQIzjm
 RXBgc1/gul3VO2gKoqnnhW/9VJbGItTNbTlZzXsDpxV/Dc1k8bYGmn+MHKhQshMw/s53
 b/vGGihlET13riZg1T3q2jNkl9bWv9eqoL5vSCjFcnKOvocVdfiaZ6Z8PqT6hGPEr/W4
 lWBK/2T/XTWiybKAeg+i4H9kXtNNmq4GJjgxe6tpIndrO7H3TroyjPtIC2u41ftc7iqV
 JDzI3grAq7g5lFiA83pSxerjWszLPztCdXq56DGvjSYeljCHiBBGXkMQeiBggjXPnJpI
 EcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xmzNKL8aW9bGzuTcbOfJ4nLHl46p7jRPYxSxJ2NLVe0=;
 fh=F2jHHLOhAUdxIpT/mOESKAzlhKPgUW33d0+z1UtXHTg=;
 b=Rr4NQoy0FvpZIZ4aNKgQb2rV5DVs3xHOqVhIA4JtmDPdPTM6Uljcw8vY5+gH1s1ios
 jdJL5CJHNMyIykfzmaUbIrW2Vo8vvR+PWM69DAlJqW046zzgNZyE5jArr/vhYDAGXg0F
 jIJg111GOTlppQSaRIMbxkhHIfvNBTwkCQ3u2Q+MbB85sfK3d23ivO97Bpxy9fnP8tnp
 Uc6IPz2y1aoZqyolzh3VopiHRfrCHu0ocotpcgKCO2u8LvZ27c3bqB2QvkQQ4UIa9KRv
 9WO0GnfYTirV0rckCV2vEVIlIumeMnkswBRl7kB2rvhBfbZtjzGObG2IUzuufiWoFkGu
 od9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783298920; x=1783903720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmzNKL8aW9bGzuTcbOfJ4nLHl46p7jRPYxSxJ2NLVe0=;
 b=FBY3GTe9fWyxbBgzTY5vSXtocz3+IRQKfW3kmuuFN47f1AzlQOFRgfoEc1/+6htCl6
 ReVJZ+u/KXBxWqY/ODiT1KOl0upfY/zWj32YfEL2FR8FapStorFwEyzyyx1vL3jVqyEu
 LfFiCqM+yzqatnKi4jyNtVeXW8FBu8VacmTu1j9a0yV9AvYhdNyJBwthY9YQLJdgQZcw
 xpBXadlSEQezzEEm7Y9OIMefnOs1n3YyzTQTx2J3RNX095LLOsJsIjbcF+BIT8nhV5Ls
 24Kw9ytvsvXxTG1JS27OWtNGbuclJGwHhcuSIbqB9h3WSnXZW1cSGpvhTEbSlngy5xmw
 K8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783298920; x=1783903720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmzNKL8aW9bGzuTcbOfJ4nLHl46p7jRPYxSxJ2NLVe0=;
 b=N1xjtkGbNX0UaYuEVvMVOWY7Jq0pL/62XIsrSa/uTkZy5uzNvNRtmCDTzuZQSaiigB
 0so1fbF6mxahldOP98B+PLAgag2XuYODZzhih5wRwP/72objAsptxh+dWSHpJd5NnSYi
 zB5Ph04k0bZVCYC1PYR04gFGngCKdJd1dttLRfallkdwqpYgRPoJYS5IipmqyJueOD8q
 TZING2lXqscWkM8rYRISUcMigZ2QNon5/ShcSUg9pbYbobeJMh1kFR9HKf7U1Tn9dSfH
 wxZ73Rasxk2+ydxw3y3nlEgrfkOZbv4tOLtG7IrpD+rBoD6XsAftN5L2QH7GJfjRPjfD
 Jhhw==
X-Gm-Message-State: AOJu0Yz6k5OJWw8J1V4sGc6SazaYhADgJPgYXGM+mLA01O8UfNO3U38e
 U8G9Tx63Mj5vI+tb1mnqWOPXdjCqfjxsQpc5FoxvsVP+3vjpKpA0RzmnWFBby3idT/fY6yoj8os
 249OOK4Sa6AsZfMLS/P2X4EH3npiXyf8=
X-Gm-Gg: AfdE7ckQnuA+38bsWtCiGKbXHuPaYZInOgfOBNYBUHJWPBWjBm8kNVRdDgzDQiZ1GLw
 IPCWmkVQpbwu4mRMNOEJ9Is5oDtXTYS0tXEASsgx6JZG0gR2JTiH1sS6vgbSrzE1Kvrm3Nm1y+D
 eZaI3Uk/9mdQMoxp0b+LXtvFre8DE9lpMr/gU9c81n0SyFDhR6GnnQiXuhY9indzfqiYPagj4qd
 zcDDp9R+NFalPgRfepot8sLsp0y8+3ySNdZliJZP1aUqeb0lL+LWwLU5PwxChdbLmwC0G1aQ9pT
 sslwgnZcbqu/1JZoNVb5KmejPhU=
X-Received: by 2002:a05:6402:3592:b0:698:b92b:c785 with SMTP id
 4fb4d7f45d1cf-69a1aac3710mr3303812a12.3.1783298920288; Sun, 05 Jul 2026
 17:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
 <20260703180538.3346781-18-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260703180538.3346781-18-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 10:48:12 +1000
X-Gm-Features: AVVi8CdjMy5JQioA9y5lQ4yMZmezPxxS41P8ZLwSlT2Y6ztGXlW-2teSbqPQaqI
Message-ID: <CAKmqyKNjFmfe--jy7LwjhGOtXREtSk=w41OgUDmN95Zs5Ymmjw@mail.gmail.com>
Subject: Re: [PATCH v4 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Sat, Jul 4, 2026 at 4:08=E2=80=AFAM Daniel Henrique Barboza
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

