Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3247FC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 11:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucNG2-00019t-1q; Thu, 17 Jul 2025 07:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucNFm-0000vG-BJ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:58:25 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucNFj-00024P-Da
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:58:21 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e75668006b9so904899276.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752753495; x=1753358295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVuev9yDrGiFoGIGEv73OFi90r0CIH38nwWEIgRkJPw=;
 b=oMh0AqSkQGZzjRRzCSw6KPGeGdXlOgluzp1qV+riRyPkHsPXk86o8P5gQ9lOQ+aoFs
 KrT/Yq/mfNST4l6O+9U2SsHs0XHi3RftWVyb7iWuw8ytegJjeGLgniqaGzW5yjd3lAYU
 WSQJeuJqDBXKtwm1F6NTQ0E2HVGpnYaZOMgw09VD0scrjpNShoHpIMnKZ6SbSXkxYDd8
 K6qwi+12Zlq1LfptMKYsEfQ7cRDWoWUQa/dhnLuvVRDcq7x6DiCQ4TEhNHHhDL6eYlGB
 E3ATPcefI46WkTr490CAmuGoiFJHLeA/puWo0hjqbNosJyYQR4tOV7CklfU3Lqblh7GR
 doDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752753496; x=1753358296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVuev9yDrGiFoGIGEv73OFi90r0CIH38nwWEIgRkJPw=;
 b=vuQ73/ryJnsdWTsa6I1RPXtsYn16bmO+jJGpFFYZsGPwn+WVf1h8gp/I8FoUym38eY
 IJlBuxwYhj8KfV1nzy82XwN09dX+rCRhBz73cl5Rqp0Oa1V7H10Ul9qyPjZ7FQuJkVXp
 CwQdB89LWBz2ynqCCvMoGKE5648k/TFyyXJ1bkeDtcvI5f8VU0/RQU7/SxqO3XHqHAl4
 6ieGVsVGgscE0qug6U1+C7tQjEk30qRcRKEjHyoV2jL43ebhDt+4YufS2aUKbhiEX2+E
 KNjBgpqbH8qzC7K8lKn4h+c6amJ5IpYiq8aJjH8VEKRVYyZ8EDcaJrD4aNyIdrrMJxrQ
 KzzA==
X-Gm-Message-State: AOJu0YwGO7x1vOUXofobTNrFK1SdeeWTFT0MjatbF3QKNqPghfXxjuMH
 csoeTVbKAKr/qnakJjMPD4u14CNidm5Dtzz9QtSC3M2pT+3KFYXs0asNaHUUkaRlvQxIzoOHSGo
 eNSaq13eGsYANffskSdVyrSaCIkTQWl2r21RZYXpAaA==
X-Gm-Gg: ASbGncssxBzE33oYBmcMhfZkb68/1X3axv8bNb+bQQ+CqcxPz7j32tlAGRxrkoomwOB
 1HkV7qzQMDGO0bKLWH+M6FQ11ymtvcLCmPI58TDvMcHQ9TkPCY0ppKx8YXjMKRGmTS9LknyQ7v8
 7al1nP8wa3oUg1whyaEGLX55eMxKc7+NqdczMoVfTesJiGAA/wGN4xLSPix65Utd/7rRzqjdiQH
 gbZTfC+ElgNa2tmBfY=
X-Google-Smtp-Source: AGHT+IEx6o77e/ySYnyJp+1cZvlwd+c4fLX+gh9L0RVi1OprWgui6ugD9MDQcqzBXnZdzsBsRai4EgQ1pNi2DSSC9fg=
X-Received: by 2002:a05:690c:600d:b0:70d:ed5d:b4dd with SMTP id
 00721157ae682-71837470fa0mr78789607b3.25.1752753495487; Thu, 17 Jul 2025
 04:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250715061918.44971-1-philmd@linaro.org>
 <20250715061918.44971-15-philmd@linaro.org>
 <4319b447-5e85-4e14-8146-b8615d497171@linaro.org>
In-Reply-To: <4319b447-5e85-4e14-8146-b8615d497171@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 12:58:02 +0100
X-Gm-Features: Ac12FXxB1AY81ScSowZhQUj_5--ROprdikWfExS1GPa3QhkBYE0f_WlZCu1uKGI
Message-ID: <CAFEAcA_C16Ta0HT1i10RErmSOMJNuecHuDX=JDALn701+9YtpA@mail.gmail.com>
Subject: Re: [PULL 14/17] esp.c: only call dma_memory_read function if
 transfer length is non-zero
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Thu, 17 Jul 2025 at 12:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Mark,
>
> On 15/7/25 08:19, Philippe Mathieu-Daud=C3=A9 wrote:
> > From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >
> > In the cases where mixed DMA/non-DMA transfers are used or no data is
> > available, it is possible for the calculated transfer length to be zero=
.
> > Only call the dma_memory_read function where the transfer length is
> > non-zero to avoid invoking the DMA engine for a zero length transfer
> > which can have side-effects (along with generating additional tracing
> > noise).
> >
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Message-ID: <20250711204636.542964-5-mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   hw/scsi/esp.c | 20 +++++++++++++-------
> >   1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> > index 62ba4061492..ec9fcbeddf4 100644
> > --- a/hw/scsi/esp.c
> > +++ b/hw/scsi/esp.c
> > @@ -487,8 +487,10 @@ static void esp_do_dma(ESPState *s)
> >       case STAT_MO:
> >           if (s->dma_memory_read) {
> >               len =3D MIN(len, fifo8_num_free(&s->cmdfifo));
> > -            s->dma_memory_read(s->dma_opaque, buf, len);
> > -            esp_set_tc(s, esp_get_tc(s) - len);
> > +            if (len) {
> > +                s->dma_memory_read(s->dma_opaque, buf, len);
> > +                esp_set_tc(s, esp_get_tc(s) - len);
> > +            }
> >           } else {
> >               len =3D esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo)=
);
> >               len =3D MIN(fifo8_num_free(&s->cmdfifo), len);
>              }
>              fifo8_push_all(&s->cmdfifo, buf, len);
>
> Coverity reported access to uninitialized buf[]:
>
>  >>>     CID 1612373:         Uninitialized variables  (UNINIT)
>  >>>     Using uninitialized value "*buf" when calling "fifo8_push_all".
>
> Do you mind having a look?

I think this is a false positive (and marked it that way in
the Coverity Scan UI). Coverity is complaining that
we might access buf[] uninitialized, but in the code path
it is complaining about we know that len is zero. The
fifo8_push_all() does a "memcpy(&fifo->data[start], data, num)"
and if num is 0 that is valid and won't access anything in buf[].

We could I suppose make fifo8_push_all() return early for the
num =3D=3D 0 case, just to make it clearer that it's supposed to work.

thanks
-- PMM

