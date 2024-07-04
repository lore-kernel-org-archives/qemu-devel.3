Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCC7C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 13:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPMEd-000412-To; Thu, 04 Jul 2024 09:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPMEY-00040h-NB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 09:10:47 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPMEV-0003GC-1U
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 09:10:46 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a72988749f0so89299166b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720098638; x=1720703438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J9jXl/SAccJGn5LesSoh4AjnbcxAVfwKnvRvF1b8xdg=;
 b=uL9LDaZlhNbFrxY58zCn9k4rOJZUdlY4VEn3MY7OLmZZc8V28hZLw4sm7Alq5qBQmI
 RTI/L15RVeXAATapRjY548d9JC6gV7s1e/olwaP9FVo/ygDEJFFH640RYSiUI5aiBIif
 IwzexwHMBjKabUhz2NSjO4OL7HmEUjjNZ5HcdTnTrLVf0EhaA+cmPZBIz8tApN9nhuud
 zKwIEGftarc8PMNdJYE2KZl+IFmH2sjbkUIzwF9vadYONX8uK/wKSOgOxpbaAjHs5WAD
 CIcxtdAKpH+/2Hv8GbQ7kxUfEeNNGODqi9lYdMM5aBcGHNrXjQGnKac9za4MWNwRkb7o
 rTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720098638; x=1720703438;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9jXl/SAccJGn5LesSoh4AjnbcxAVfwKnvRvF1b8xdg=;
 b=YTdMNOYUEglNX3HbMOGAKkS376V9/UAtVotmtzyh6TNN473U3o3ao3NtxmRfwRkSs9
 owB3QVThmcWC6cMpr/j9a43UP1nPQ3nkbjccYBxG9C96l5me+BtQNlGsZlDqMxqJaFZF
 jw5DE7h6x0MmR/xbvDxl4GVwJ5fU/OORgbjULJMCcOO+I4xZVrYCXsX8eVAw0nszzRx6
 Wgebzu/8+Ta4mgFpw0Y5ucJ5TGbY9SBPE8dMhV2X5PP2/MeV57tBTgkiH3I2ATsRMzRc
 YJM25r3pOjnkZyuREv4AeE6cIU+KwxNkYo22uWTZopoMLyFVx3DNOSlp/ugEEMhLerO2
 jzFA==
X-Gm-Message-State: AOJu0YzXY6TYNrsn1Sy0PbbyMazKiUWhZzkFjskGAUHYLaOEa61vNzsx
 fp8A50dGkeo49h7jmX2oSRMLGbS6Si+Ij9WP3sbEW3oLkBDHbNazq5l+THfmc34=
X-Google-Smtp-Source: AGHT+IFvDB9ld3mXQCduKDUHkhXJ+lOn+yZQz7R2Wu8lvajpHMM9pM40UyiYwYx3tFnX2mpIwCs+Hg==
X-Received: by 2002:a17:906:abd4:b0:a75:360a:6cb0 with SMTP id
 a640c23a62f3a-a77ba46fa36mr107219766b.29.1720098637896; 
 Thu, 04 Jul 2024 06:10:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77affca606sm83950766b.170.2024.07.04.06.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 06:10:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E5FF5F839;
 Thu,  4 Jul 2024 14:10:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: TaiseiIto <taisei1212@outlook.jp>
Cc: qemu-devel@nongnu.org,  mst@redhat.com,  pbonzini@redhat.com, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/timer/hpet: Fix wrong HPET interrupts
In-Reply-To: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 (TaiseiIto's message of "Tue, 18 Jun 2024 13:10:44 +0000")
References: <TY0PR0101MB4285838139BC56DEC3D1CCFDA4CE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
Date: Thu, 04 Jul 2024 14:10:36 +0100
Message-ID: <871q49nvzn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TaiseiIto <taisei1212@outlook.jp> writes:

(widen CC list to include machine pc maintainers which use HPET)

> Before this commit, there are 3 problems about HPET timer interrupts. Fir=
st,
> HPET periodic timers cause a too early interrupt before HPET main counter
> value reaches a value written its comparator value register. Second,
> disabled HPET timers whose comparator value register is not
> 0xffffffffffffffff cause wrong interrupts. Third, enabled HPET timers who=
se
> comparator value register is 0xffffffffffffffff don't cause any interrupt=
s.
> About the first one, for example, an HPET driver writes 0x00000000aaaaaaaa
> to an HPET periodic timer comparator value register. As a result, the
> register becomes 0xffffffffaaaaaaaa because writing to the higher 32 bits
> of the register doesn't affect itself in periodic mode. (see
> "case HPET_TN_CMP + 4" of "hpet_ram_write" function.) And "timer->period"
> which means interrupt period in periodic mode becomes 0xaaaaaaaa. Next, t=
he
> HPET driver sets the HPET_CFG_ENABLE flag to start the main counter. The
> comparator value register (0xffffffffaaaaaaaa) indicate the next interrupt
> time. The period (0xaaaaaaaa) is added to the comparator value register at
> "hpet_timer" function because "hpet_time_after64" function returns true w=
hen
> the main counter is small. So, the first interrupt is planned when the ma=
in
> counter is 0x0000000055555554, but the first interrupt should occur when =
the
> main counter is 0x00000000aaaaaaaa. To solve this problem, I fix the code=
 to
> clear the higher 32 bits of comparator value registers of periodic mode
> timers when HPET starts the main counter. About the other two problems, it
> was decided by comparator value whether each timer is enabled, but it sho=
uld
> be decided by "timer_enabled" function which confirm "HPET_TN_ENABLE" fla=
g.
> To solve these problems, I fix the code to decide correctly whether each
> timer is enabled. After this commit, the 3 problems are solved. First, HP=
ET
> periodic timers cause the first interrupt when the main counter value
> reaches a value written its comparator value register. Second, disabled H=
PET
> timers never cause any interrupt. Third, enabled HPET timers cause
> interrupts correctly even if an HPET driver writes 0xffffffff to its
> comparator value register.
>
> Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
> ---
>  hw/timer/hpet.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 01efe4885d..2dcefa7049 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -599,8 +599,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>                  s->hpet_offset =3D
>                      ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEM=
U_CLOCK_VIRTUAL);
>                  for (i =3D 0; i < s->num_timers; i++) {
> -                    if ((&s->timer[i])->cmp !=3D ~0ULL) {
> -                        hpet_set_timer(&s->timer[i]);
> +                    HPETTimer *timer =3D &s->timer[i];
> +                    if (timer_enabled(timer)) {
> +                        if (timer_is_periodic(timer)) {
> +                            timer->cmp &=3D 0xffffffffULL;
> +                        }
> +                        hpet_set_timer(timer);
>                      }
>                  }
>              } else if (deactivating_bit(old_val, new_val, HPET_CFG_ENABL=
E)) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

