Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AE2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4Cc-0005Nl-Ch; Thu, 08 Aug 2024 10:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc4Ca-0005Mf-5s
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:33:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc4CY-0006KE-FB
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:33:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7d638a1f27so43357866b.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723127593; x=1723732393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nioHeWMXtFzyLLKsZrn0g5FDxHVTN0nVtxne61S9YDE=;
 b=jRdclCRbNSxDR82OZIJylMhnPBFaLulHmHvBAdsqCAP7ImNM5f09ucXDhfZUXet5Fe
 MObWyk2UMQLlJ3YfOOz6KDYSyBv8IClhP44ewDeJL49sTp3XDl473Oowsd9l1Tkht+P6
 e18AFVoICv7jRuOEYpXPlUqIgYuf/7qWXZ9pfi9aah04k9+ZmXTwRPEbnurujN0qhq9N
 Ikyx/6hWOEF294AGwTzbNIf888MjDV0N3+jklruLC1tY/bDJjyjHDSKGRQCHdqWPILh5
 Yypr+g2ggF9x+o50mziqRNvxQ4teU/Db9mYLyYRTVvqBZtjRjOgACkh61inHztXh8OaC
 sFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723127593; x=1723732393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nioHeWMXtFzyLLKsZrn0g5FDxHVTN0nVtxne61S9YDE=;
 b=X8sdVx2LSn6G7PyS4IUhvwROpfHlg16WsOWONmZwqKY+v7s79CKwtTmheTJTSMSzk2
 Z4BpgTbyL1/UAecpSdJh6MlRIUtd8O1p5jE1PvGLamnLbwTZLEAte++4+oxinSMZAZsU
 mwil2q1cs0YYXVxDlzRCqS3ilZFvV9Anhb2VHWnq5QFfPXgodTpLwIdpI4q8ZYJHfW7o
 KCP5f+sL6xsI8Z9sy1Ec3sTK5v6KDxwNbRd0tRdzS+9VjMPy2OzDLEZlPxYDQQ30GZgF
 jfopxts7NP4lIWeq7k6hYuaBcUeXm4lY2cMav2Izq8epcxygXZdmcxBEoufMhij0FAFD
 bDnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1lcTOyle7iJdKQCPQeA829UP9VgUiCY4r51gE7/aEkVuqMBajT9nYwqgpDV9p941ZUV/TAupxhqWAI5bhkKRl1F+6uy0=
X-Gm-Message-State: AOJu0YzPKVYdNBX5tyiFVxYRuMcsRXnVYPUyZ3bk0fdwoj+iSFVSCM/Q
 XeTc882wAGBXDObKpa3PEwjsNsDqrUF/A/VfJI4Om/3MaI75jvKXHxp7scMC4Ia6P06sh1tzZNw
 4GMNhf21Q6kWCjnLhnGp0yTokjxnX+736dhuoLg==
X-Google-Smtp-Source: AGHT+IEYLXVxPzJLiyPO/q6WShUZe3dHASsvfU5IepBNjQ59+nhWBnbsAh8hqiingbqxdNmrAvKSpSWg4/eYfTsBl8k=
X-Received: by 2002:a05:6402:3484:b0:57a:3046:1cd8 with SMTP id
 4fb4d7f45d1cf-5bbb22399e9mr2377198a12.7.1723127592553; Thu, 08 Aug 2024
 07:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
 <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
 <e3e60776-3f63-4024-a595-2989a59e15ed@linaro.org>
In-Reply-To: <e3e60776-3f63-4024-a595-2989a59e15ed@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 15:33:01 +0100
Message-ID: <CAFEAcA_H+KtpBUKx4CcwKnNjL_4iOX-weLBXcrt+JzYBAgwJag@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Fixes: Coverity CID 1558831
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org, 
 Glenn Miles <milesg@linux.ibm.com>, Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, fbarrat@linux.ibm.com,
 clg@kaod.org, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com, 
 dantan@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Wed, 7 Aug 2024 at 21:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Back at this patch since C=C3=A9dric asked me to look at it.
>
> On 6/8/24 15:48, Chalapathi V wrote:
> > In this commit the following coverity scan defect has been fixed
> > CID 1558831:  Resource leaks  (RESOURCE_LEAK)
> >    Variable "rsp_payload" going out of scope leaks the storage it
> >    points to.
> >
> > Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> > ---
> >   hw/ssi/pnv_spi.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> > index a33f682897..dbe06df224 100644
> > --- a/hw/ssi/pnv_spi.c
> > +++ b/hw/ssi/pnv_spi.c
> > @@ -237,6 +237,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payl=
oad)
> >       }
> >       if (rsp_payload !=3D NULL) {
> >           spi_response(s, s->N1_bits, rsp_payload);
> > +        pnv_spi_xfer_buffer_free(rsp_payload);
> >       }
> >   }
> >
>
> Or bigger patch but simpler logic:
>
> -- >8 --
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index c1297ab733..aaedba84af 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -217,6 +217,9 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payloa=
d)
>       PnvXferBuffer *rsp_payload =3D NULL;
>
>       rsp_payload =3D pnv_spi_xfer_buffer_new();
> +    if (!rsp_payload) {
> +        return;
> +    }

pnv_spi_xfer_buffer_new() cannot fail (it calls
g_malloc0, which aborts on not having enough memory)
so we don't need to check it for NULL.

>       for (int offset =3D 0; offset < payload->len; offset +=3D
> s->transfer_len) {
>           tx =3D 0;
>           for (int i =3D 0; i < s->transfer_len; i++) {
> @@ -235,9 +238,8 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payloa=
d)
>                       (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
>           }
>       }
> -    if (rsp_payload !=3D NULL) {
> -        spi_response(s, s->N1_bits, rsp_payload);
> -    }

(So this NULL check was unnecessary in the old code.)

> +    spi_response(s, s->N1_bits, rsp_payload);
> +    pnv_spi_xfer_buffer_free(rsp_payload);
>   }
>
> ---
>
> I note few things is odd here:
>
> 1/ pnv_spi_xfer_buffer_new() uses the GLib g_malloc0() call
>     while pnv_spi_xfer_buffer_free() uses plan free().

This does work (glib guarantees now that g_malloc and friends
can be paired with free), but it is not great style.

> 2/ pnv_spi_xfer_buffer_free() frees payload->data so doesn't
>     match pnv_spi_xfer_buffer_new().

This part I think is OK -- the payload->data buffer is
allocated with g_realloc(), so pnv_spi_xfer_buffer_new()
creates a valid initial state (payload->data =3D NULL and
payload->len =3D 0), pnv_spi_xfer_buffer_write_ptr() may
allocate or extend the buffer (using g_realloc and
updating the payload->len to match), and
pnv_spi_xfer_buffer_free() will free the buffer
(including handling the "buffer never allocated so
payload->data =3D NULL" case, because free(NULL) is OK).

What it doesn't get right I think is that when
pnv_spi_xfer_buffer_write_ptr() extends the payload->data
buffer it doesn't zero the newly added memory, so I think
we might end up giving the guest back the contents of
uninitialized memory.

Another style issue is:
    PnvXferBuffer *payload =3D g_malloc0(sizeof(*payload));
g_new0(PnvXferBuffer, 1) is the better way to say
"allocate me a zeroed out PnvXferBuffer", rather than
manual use of sizeof.

The various places which do
    if (*payload =3D=3D NULL) {
        *payload =3D pnv_spi_xfer_buffer_new();
    }
also look odd to me -- I'm pretty sure that
in operation_shiftn1() and operation_shiftn2() it
is impossible for them to be called with a NULL payload.

The PnvXferBuffer struct is only 12 bytes large
(a length and a pointer), so it seems rather overkill
to be allocating and freeing it -- is it possible to
have it be a local variable instead?

My other question here is whether we need to be doing
dynamic memory allocation, extension and freeing of the
payload->data at all. This is quite an unusual thing to
need to do in a hardware device model, because usually
the real hardware we're modelling doesn't have infinite
resources, it has some fixed amount of memory that it
has to work with. If the guest can effectively ask
us to allocate arbitrary amounts of memory, do we
have appropriate guards in place to forbid that?

Is there a datasheet for this device?

thanks
-- PMM

