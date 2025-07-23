Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA6FC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZgc-00024u-Vw; Wed, 23 Jul 2025 09:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueZgb-000232-1n
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:39:09 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueZgX-0006Tv-G3
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:39:08 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aec46b50f33so1151770966b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753277943; x=1753882743; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO7D/HrU1mVkgOY2yanGLpvFsSuau4X76y1xrCDv92U=;
 b=YTSRdL2i6NtVPEzCe5zi+u1eDTTWryGHx7IThfF8DyBUF3QvKNA+AOFN0F1LKsLxQV
 /ai5Qe6vFS4fmQ6Gy+SPRhfn4dU9l3kPoE0iKVr1WbQw/ug5CO1mcrrkro4pN1TkR2M8
 rCNoHN5omezXvwMcsP1l6f0OqXQRx+WCoDDbS57jqfZOJcwoKdxHGPSZdCguW40ilvr+
 P+22sWczeG2qYK0zrmOQK7Qo9QV5ZdKstHaHijoiBE5iPhIMORNKjYxAiAhBpag8LFpS
 elZlnAq6MX08NfOvtbb6oM8pu4qW4ghuj2k2NT5hWlkS7KxXdlDhHqqt36HSqIhy26ed
 HV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753277943; x=1753882743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tO7D/HrU1mVkgOY2yanGLpvFsSuau4X76y1xrCDv92U=;
 b=G2m+MmP/v6sz0u+OBq/exMzRGGI0GGuONX8pqA/Gb6zaCsccIlvhJe6GgDgs0RIIZO
 VCkM3SCIe3+k5kJD/griStz8ZkRDCKkG6jrR4yZKAJmmGaSAs6kbmi19t5CG3o8INv9j
 WUZLYauKnTmj70gAURLSO8oaysPvLDZ0l+7ECLBoNTEvelFU7jZ/62/1GLX7WKe2N4J2
 Fm2eJU3xVL2bP38choju1vDzZU1WM0aWrmU/gzLuJUD0RNgH5TC9RYOfDOjnfs5o7fKT
 /r/A+3eiLWP4Khec0E/A6BMf4+ypcQpkSBBwp0ibyuXbSovLZIAKSxYhPnfzqqAZMWaM
 /bOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZcarvkAbkVn462UpnQNJ0wSzMeBMpDKKOUXfdUPjyQb55e5Q6RFgwv/Np5CylhVY6nayTpYftpUXw@nongnu.org
X-Gm-Message-State: AOJu0Yy6eYZgobbfLKIeDc2AtFrckLny2dxNwdm1z6GRhBc+Taz8DZdg
 1aWWc66sReiLuz9LmRKu2cXbGeoBTlwxm2JVjkNDozylho5VspXRHvF0JSZP9MwEspkXB2S9qDH
 RzrIxsEP/rSv/Hrt6y0xBjfAb845+Wkt+Kykkutq4xLGC0ic7rXvU
X-Gm-Gg: ASbGnct69OBKxfAKZKGMua4qzrzsD3yRWECCKA+eo+x+L3josOk2S2DGhJ63y30bBnu
 +SdHKzGvEop7zyabUC0rtPU6ckxdq/yGEBicBbFLE9EsPaTE2wS8mpu+P7TfIYvE53gwSHR06T3
 2WPFvnoz0LlXFyhl8EaLFcGGtrtH2n8MNiPjKYpN3N4vSHOXWQd6VKk35mOip5As0eGHZ2IYY4v
 iVvNgf1
X-Google-Smtp-Source: AGHT+IETH+0m3Bg+1LztvqUvbUUjGefSyXOJTMcfojB0blO+5gPZmtXf65MFN5RDGj+qVGEwpU3Wmebe/voGLyPxK0w=
X-Received: by 2002:a17:907:60d1:b0:ad8:9a86:cf52 with SMTP id
 a640c23a62f3a-af2f66c1e43mr326393066b.11.1753277942912; Wed, 23 Jul 2025
 06:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250722090547.109117-1-ben.dooks@codethink.co.uk>
 <87seinulb7.fsf@draig.linaro.org>
In-Reply-To: <87seinulb7.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jul 2025 14:38:49 +0100
X-Gm-Features: Ac12FXyScXWtj_ATb4oUcw7OVjIxlC9qSpbcaPvDnt31goHJ3hUh1SLIqSyRCtk
Message-ID: <CAFEAcA8c0GRxvXUANBbNvMdTqBwBgCjTZkqc2RNjE8bRQo772w@mail.gmail.com>
Subject: Re: [PATCH] hw/sd: print bad s->arglen in unexpected response
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 23 Jul 2025 at 13:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Ben Dooks <ben.dooks@codethink.co.uk> writes:
>
> (Add maintainers to CC)
>
> You should get your patch workflow to use scripts/get_maintainer.pl so
> they get CC'd and reduces the chance of it being missed in the fire-hose
> of qemu-devel.
>
> > If we get "ssi_sd: error: Unexpected response to cmd" then having
> > the bad s->arglen would be useful debug and does not add any complexity
> > to the code.
>
> Generally we should be removing the old-style DPRINTF debug and
> replacing them with tracepoints where they are warranted. The main
> problem with the old style DPRINTF's is the format strings tend to
> bitrot because they are not enabled by default.
>
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> >  hw/sd/ssi-sd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> > index 6c90a86ab4..f1441d2c97 100644
> > --- a/hw/sd/ssi-sd.c
> > +++ b/hw/sd/ssi-sd.c
> > @@ -183,7 +183,7 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev,=
 uint32_t val)
> >                  s->response[0] =3D 1;
> >                  memcpy(&s->response[1], longresp, 4);
> >              } else if (s->arglen !=3D 4) {
> > -                BADF("Unexpected response to cmd %d\n", s->cmd);
> > +                BADF("Unexpected response to cmd %d, arglen=3D%d\n", s=
->cmd, s->arglen);
>
> That said BADF is defined in both cases (although the exit(1) for the
> debug leg is a bit aggressive). Is this an error of the guest
> miss-programming the device with invalid data?
>
> There could be an argument for using:
>
>   qemu_log_mask(LOG_GUEST_ERROR, "Unexpected response to cmd %d, arglen=
=3D%d\n", s->cmd, s->arglen);
>
> instead.

This unexpected response comes from QEMU's SD card emulation,
so I'm not sure to what extent LOG_GUEST_ERROR is appropriate.
Is this triggered by the guest doing something silly, or by
a bug in QEMU itself?

I agree that the BADF() macro is rather a legacy relic
(you can see it in a handful of other files too). exit(1)
seems unlikely to be very useful behaviour even if you are
trying to debug this code, and we have slowly been weeding
out places where QEMU just barfs on error cases.

thanks
-- PMM

