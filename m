Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4093FCD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVXKs-0005D5-15; Fri, 05 Jun 2026 12:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wVXKq-0005Bu-7r
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:23:52 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wVXKo-0002QW-ML
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:23:51 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-5177d1ff061so528571cf.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 09:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676629; cv=none;
 d=google.com; s=arc-20240605;
 b=I2lCWIJ8W1xtAc5omTSxIoNdIqw7XbDJutbY3VjurxJOlRIrWnszNq2E2ZKr4HtcCX
 ATY2F02qq9nW7RWD7HQpDPI1LnQJT5ZwRxEtA1STJprWvI9xpol1u4CGGvoibNtUT868
 TvoBOiasDGJaDt8LO13SMFeZat3XzABlRE/5WZxstO+93YvIN1n9kV5qPzSOo5D91q16
 9mYW5ged9yWImOvwBuLamSbxJQMIOlUyTkVdOjgftf/mjPynuP+HvMSb3PqRzh5yO3ho
 VgIvAHTqHH6WC/+d+QYrZK+SzG3OnLb++gfBRWlofIYitdJOuVmk/vRdm20Ll6d4nBLm
 VezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AhF+hpXoRDc6wprsIdiBOjKikAaT9FkhUsLbEm5B4j8=;
 fh=KtPQ1WAb8SCl5o2PFom9OaPLpf5dq68K3oi6xRymDPM=;
 b=GTz42xpICTR5j/Ce2gZQRUtnEiQVeJoJ6wSD0Vj5nmzwyzZ1EcnOGuh9Y1J1vgNgOr
 UXX+dSnAOvNTPhVjiY4BV1KE+Qf/zIATcvqJGTOKKVs55eydHgN04Sg1x5APp20vOCOR
 /qmPcnPs7/EwnpmxnkjC6yRRbky8pKWqeLBwikw4x9temqYWp/zN/jGTj3H31TI0W/Rm
 Thfvk9kQ1zropevovwt8zPv+b9Vr6j3yKHxhyZdVdqNCeyV3x7MYz6+57XbR2Ha7E2/7
 WzjS/p8U/rTIOCZlOXOp5JzLMWg17M2Z6aZvJtomjfaA+r2MAclFPYl493kbJ9jFKq+o
 +p5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780676629; x=1781281429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhF+hpXoRDc6wprsIdiBOjKikAaT9FkhUsLbEm5B4j8=;
 b=I4ktifrg/k5WRo2lirzCw4rg6fq8fWy7KUTm1Z4VzrgWLG4vTbNnojrN+ISU8QxC/4
 JQJSTwFahbopLqit9JSmH0pvrsE8Tp+mzFiy7J3zutqmk9lvcPs58BqR2+WvpjZ/hih9
 JBiYzvv70UjxS/i5QZkrI0G8Co5BCY7dv4K+07DZ2EKQZUw7ZgqznZLl2BS0QS2QQY6j
 fLrBJVYzcQ2pRUH5h6k5fgAE9/O3GDFXFjNeWP/SzWWoCNssU83d8WW5vBb8uwcdmdoo
 Lop7K94QY0mXY3ZTEuneJpuUDx5LxX3oUyi/seOJelx7+Yt++qpN6nFHDGJ8lzcbSJQg
 ESSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780676629; x=1781281429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhF+hpXoRDc6wprsIdiBOjKikAaT9FkhUsLbEm5B4j8=;
 b=WM5jp9/q6pmrCx62Dw1N4UDuCmezw7LGG3ZriLZf1Qc2DqKJNY1K0qW/cMQwhZczwc
 RaBsCgPKrvtyywdgqJeJiQUqDLud3ziiw8YXzemHZogVDB0fNJrEE8rPDqG132HRZqZ3
 4yhqRLpkMox9LW3EuDs5Kp6GqFSOj62L61zeNCgaT7APpcZORnMIuwotjh0MmHI+gJTO
 +3WFp34lMuggudKQEyzSr9WIV6FzipShrNuufEdG22pGdPQ5VY8rAS2i/Fm+mcH6ljdt
 PTKC0fc35xVuCWV87wqEpHBt6Pa0vE6zMA8ZJ1Dy4fL07mgZU8gVZQVBVtIeOjPyaZMu
 PFgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YxV3aheLb/ZM4lC8/zTjViUEZCsBVTaCOlHmRAAf8iM5gCn6MxQmtsR0TsEZVBjLiJmtfjobBlSA8@nongnu.org
X-Gm-Message-State: AOJu0YzcXiGX6YfSpIJ2roTDGNef5gHB3sZkZ6Q8J0TnmTvKEICoDmzR
 n43eh9J55PRwav8FXN7PT5eVCtK8yisjU0NkDR+Y7I45soeAc/QkP4QqWS6bHI8NkoGZmkIA5X4
 3FGwJp4FYjOOpSSmHetC7svePdB9+pTIbHeaQPF4K
X-Gm-Gg: Acq92OGuoSEcrur0bwpQhLrOiYO1MXV9l0YKWXeRK9ssaN2uufo8/QHPm+T794+wGyq
 kRwpGXGOmjJ02IaXpadIcHDlY/EEseTPN0lRyJK+x+rk3DYYf2DkM6zxMsnTMeBKFJYlIH2NkJ7
 7b/BXsSGK58D4tI+J7tBGdkUmkfsAa1c6SJuPoV5N1cw4xDYf3a5nhLMStVdhYkOxKnSDVg1JMU
 46umop7xH8YYCp+swxHoumpLqZD894njYePuoAdurlO0cRAJk6Z8q1bCqQ+2PiX/VlrXha8Zkl6
 wnnIXXOuQje/mQ3O/nRMEgp1kLvDgJ7IfqcQv6dZjYfTHXdOKLA=
X-Received: by 2002:ac8:5e4e:0:b0:517:99ea:ab77 with SMTP id
 d75a77b69052e-51799eabeb4mr6473831cf.23.1780676628281; Fri, 05 Jun 2026
 09:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-23-3f20c3a029a7@redhat.com>
 <aiGjfMQamilAzhDg@redhat.com>
 <CAJ+F1C+dzi0Zc5p_vBNduV-X9vJx=jLgZ90m=nVwOT0j7TN9OQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+dzi0Zc5p_vBNduV-X9vJx=jLgZ90m=nVwOT0j7TN9OQ@mail.gmail.com>
From: Titus Rwantare <titusr@google.com>
Date: Fri, 5 Jun 2026 09:23:08 -0700
X-Gm-Features: AVHnY4JuMM-Qqx7eHiLnP5dWFe5GTQiIW_yXxTmjH1BAHRuH41S-AljS0TqFq2k
Message-ID: <CAMvPwGoqZTx4iWSFvwEbm4XjYnO5+pzvnze_VuZqh_h=YN+a4Q@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=titusr@google.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, 4 Jun 2026 at 13:36, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Jun 4, 2026 at 8:11=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> >
> > On Sat, May 16, 2026 at 11:59:22AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > The intermediate result of (Y * 10^-R - b) / m can be negative when
> > > the bias (b) is large and the raw register value is small (e.g. zero
> > > on an uninitialized device). Assigning that negative double to uint32=
_t
> > > is undefined behavior, caught by UBSan/clang.
> > >
> > > Use a double intermediate and clamp negative results to zero.
> > >
> > > Fixes: 3746d5c15e70 ("hw/i2c: add support for PMBus")
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/i2c/pmbus_device.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
> > > index 853dc4b4342..861f5b4fb63 100644
> > > --- a/hw/i2c/pmbus_device.c
> > > +++ b/hw/i2c/pmbus_device.c
> > > @@ -23,8 +23,8 @@ uint16_t pmbus_data2direct_mode(PMBusCoefficients c=
, uint32_t value)
> > >  uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value)
> > >  {
> > >      /* X =3D (Y * 10^-R - b) / m */
> > > -    uint32_t x =3D (value / pow(10, c.R) - c.b) / c.m;
> > > -    return x;
> > > +    double x =3D (value / pow(10, c.R) - c.b) / c.m;
> > > +    return (x > 0) ? (uint32_t)x : 0;
> >
> > Couldn't  'x' exceed  G_MAXUINT32 and thus truncate here which
> > while not undefined would still seem undesirable ? If so, then
> > perhaps
> >
> >   return (x > 0
> >             ? (x < G_MAXUINT32 ? (uint32_t)x : G_MAXUINT32)
> >             : 0);
> >
> > ?
> >
>
> Yes, applied.
> thanks
>

Reviewed-by: Titus Rwantare <titusr@google.com>

