Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40406C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 06:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUJYp-00042B-JY; Wed, 25 Jun 2025 02:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uUJYm-00041e-KG
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:24:40 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uUJYj-0001XC-1Z
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:24:40 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ade4679fba7so214698866b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1750832674; x=1751437474; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oi+k5ntCJ7ZQpOrFITAv/yNAoiH7BbKICRK3lEbvncg=;
 b=OCkF3EDpTgSFBFgvru5ju4O1jGZZsovjpgMy2pkco/eNSBY19oylnKuxflzdYaUmGt
 Hpnr4LLXqhND/tUGjM5sOdQsDK10feiI5ADxbfjKUOqLAcaT1hU2zMJk3+3hpBx884ry
 T+6RhyjCp/OSaQrCmruuwrZJ9tdSK7Navx16lb+xTxEbEkm2w09NfeyufpWA2dBW8UX+
 gl17K7OPd9uPOSFxtYLXgv7T6YOHJwrqmWNBZPmI4pbH9cOg2tOblPWJg2qNHSVjzbIw
 awvJXZ4BJn76GOK1oyeUSePmRkFlHZXFmJVLvygBDEnWdVUGUj6Df2fspzhDKRXfG++e
 1ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750832674; x=1751437474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oi+k5ntCJ7ZQpOrFITAv/yNAoiH7BbKICRK3lEbvncg=;
 b=If8d/IIaDMzSn/JARLGwxl5t5/i2FA5oUrXb36Q2fthJD7hO9ZzxgQKb2cMbXe6Q/f
 b/2Rc5Dpzolo2ofEoCj3O8lp1gnh47g7eSPSgJPAtIyVakmoK9STY+7j5/IkMfQXaBNX
 39LT1kehM9Nc+s0TH6xdArFnuExx31empaSc6ZG8HDCoX7uywR3STlzK1rA6mWgY5nom
 uYo24uTPvp1IpExk6TwywY8tn4FRdrHZUHqO/6GXyi1ciW97gQuSfddY9JSFsRTIN1dy
 x0QojakCQmkKz/d1zcXp3IM1/62iQHK/yRu1xN0yQ11HXSTdeBWkVLDyxtSlg+PsBI30
 7CWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhSHT2sY+IQN3XLu/yNv5ZeMNmWvJ/HuKeE98O+GUwUQFQ2WBZvUPBl6RP7h6IyZHDGZRhfOJabRy0@nongnu.org
X-Gm-Message-State: AOJu0YwHyyePk51ydfu2mWnUWjVtsHBm1jJzIbR8XSydPQ/+xjlcPCWz
 53hG0Fbl/jcGgv8aK1fYtDfw1TF+0Tv6sCjzlM4weLiB9Eo4h2F6z2cL44QYa6Q/naCMbVgYUZK
 wRBHCavPWvIX0HqrY9uTrt3Ih+7NS3/UPyQ9YuaN5lA==
X-Gm-Gg: ASbGncsZ5jK9xUZkK70/IhL2nAlcLdEfqpfqpbdy71InUeAz0Mb8HuOYP83GA4f/dDo
 bJ7kRRYdSt/gl61b063tp3RBFsOQkmn24fgI9ykBmFqq1/ZPhSOYijBglc4iBZfZG5vWCFAk2my
 EOR54blmMKe+hVe1jDDvZTPRnJoJnJKZKRo9Y/RnZCIN3jrg==
X-Google-Smtp-Source: AGHT+IHiduQTSRJ1TbDS1QBo9unFP3PbpRivsySEGMlgvD7Rq8a0w1bRCEQRnf7ZD34qQgxzS0vRLa4joohT7VKSgX4=
X-Received: by 2002:a17:907:3ccb:b0:ae0:ade2:606b with SMTP id
 a640c23a62f3a-ae0bf019d57mr185217466b.19.1750832673930; Tue, 24 Jun 2025
 23:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250623165329.2759651-1-rkrcmar@ventanamicro.com>
 <20250623165329.2759651-2-rkrcmar@ventanamicro.com>
 <0811914e-623e-41a2-a54b-8ce42f45740c@ventanamicro.com>
 <DAUT771C07KV.2JZ4ZCRQ1MEQM@ventanamicro.com>
In-Reply-To: <DAUT771C07KV.2JZ4ZCRQ1MEQM@ventanamicro.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 25 Jun 2025 14:24:25 +0800
X-Gm-Features: Ac12FXwQVt-wX-Sh-d8Y98iweHuxUFnomvShMPrALoMRZHxHj-WmiPkQd64vVZI
Message-ID: <CALw707rf-7ftLs3xM2Btxz9H78E0nDj6D=1N18jWe5jroZ_7Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: disable *stimecmp interrupts without
 *envcfg.STCE
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Atish Patra <atishp@rivosinc.com>, 
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Radim,

Does your patchset want to resolve the same issue as my sstc patch [1]?
My sstc patchset has been merged to "riscv-to-apply.next".
Maybe you can review it or check if there is still any issue in the
"riscv-to-apply.next" branch, thanks!

[1]  "[PATCH v3 4/4] target/riscv: Enable/Disable S/VS-mode Timer when
STCE bit is changed"
https://patchew.org/QEMU/20250519143518.11086-1-jim.shu@sifive.com/20250519=
143518.11086-5-jim.shu@sifive.com/

Thanks,
Jim


On Tue, Jun 24, 2025 at 9:49=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-06-23T18:39:02-03:00, Daniel Henrique Barboza <dbarboza@ventanamicro=
.com>:
> > Hi Radim,
> >
> > It seems like this patch is breaking 'make check-functional':
>
> That is a nice command to know of, thanks!
>
> > 12/12 qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi   TIMEO=
UT         90.06s   killed by signal 15 SIGTERM
> >
> > Checking the logs I verified that the problem can be reproduced by runn=
ing the
> > 'spike' machine as follows:
> >
> > $ ./build/qemu-system-riscv64 -M spike   --nographic
> > Segmentation fault (core dumped)
> >
> > The expected result is to boot opensbi. The problem can't be reproduced=
 with
> > the 'virt' board, so something that you did here impacted 'spike' in pa=
rticular
> > for some reason.
>
> Uff, mtimer is NULL on spike:
>
>   0x0000555555c46618 in riscv_timer_write_timecmp (env=3Denv@entry=3D0x55=
5556888270, timer=3D0x5555568a61e0, timecmp=3D0, delta=3Ddelta@entry=3D0, t=
imer_irq=3Dtimer_irq@entry=3D32) at ../target/riscv/time_helper.c:49
>   49       uint32_t timebase_freq =3D mtimer->timebase_freq;
>   (gdb) bt
>   #0  0x0000555555c46618 in riscv_timer_write_timecmp (env=3Denv@entry=3D=
0x555556888270, timer=3D0x5555568a61e0, timecmp=3D0, delta=3Ddelta@entry=3D=
0, timer_irq=3Dtimer_irq@entry=3D32) at ../target/riscv/time_helper.c:49
>   #1  0x0000555555c6eb9e in write_menvcfg (env=3D0x555556888270, csrno=3D=
<optimized out>, val=3D<optimized out>, ra=3D140736012591329) at ../target/=
riscv/csr.c:3214
>   #2  0x0000555555c6a181 in riscv_csrrw_do64 (env=3Denv@entry=3D0x5555568=
88270, csrno=3D<optimized out>, ret_value=3Dret_value@entry=3D0x0, new_valu=
e=3D<optimized out>, write_mask=3D<optimized out>, ra=3D140736012591329) at=
 ../target/riscv/csr.c:5579
>   [...]
>   (gdb) p mtimer
>   $1 =3D (RISCVAclintMTimerState *) 0x0
>   (gdb) p timer
>   $2 =3D (QEMUTimer *) 0x5555568a61e0
>   (gdb) p *timer
>   $3 =3D {expire_time =3D -1, timer_list =3D 0x55555666b840, cb =3D 0x555=
555c465d0 <riscv_stimer_cb>, opaque =3D 0x5555568856b0, next =3D 0x0, attri=
butes =3D 0, scale =3D 1}
>
> I'll try to figure out is going on, but `make check-functional` passes
> with this hack:
>
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index 81a6a6394502..a2092206cb20 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -44,10 +44,8 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEM=
UTimer *timer,
>                                 uint64_t timecmp, uint64_t delta,
>                                 uint32_t timer_irq)
>  {
> -    uint64_t diff, ns_diff, next;
> +    uint64_t diff, ns_diff, next, timebase_freq, rtc_r;
>      RISCVAclintMTimerState *mtimer =3D env->rdtime_fn_arg;
> -    uint32_t timebase_freq =3D mtimer->timebase_freq;
> -    uint64_t rtc_r =3D env->rdtime_fn(env->rdtime_fn_arg) + delta;
>
>      /*
>       * *envcfg.STCE disables *stimecmp interrupts, but still allows high=
er
> @@ -59,6 +57,13 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEM=
UTimer *timer,
>          return;
>      }
>
> +    if (!mtimer) {
> +        return;
> +    }
> +
> +    timebase_freq =3D mtimer->timebase_freq;
> +    rtc_r =3D env->rdtime_fn(env->rdtime_fn_arg) + delta;
> +
>      if (timecmp <=3D rtc_r) {
>          /*
>           * If we're setting an stimecmp value in the "past",
>

