Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBB3CD98E4
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 20:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb2OC-0000UM-0O; Sat, 20 Jun 2026 16:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wb2OA-0000Tc-9m
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 16:34:02 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wb2O8-0002If-Pi
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 16:34:02 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-663271f8694so186485d50.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 13:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781987639; cv=none;
 d=google.com; s=arc-20240605;
 b=SOi2H994lCtTmtKLzCPZhJ6wKGjZm2lCiyXLAC+YhFBKO8bndC56Tk2r/PLY5cHPOq
 HFFHNAQhimNYYUiJNNVGx1UFr3u3BKSpAIAJPyQAyMm5SsYTs81sxUFsZQ7Tefs2gXaa
 oW2C+5yXf7H7zKgi4COGM7y+ExJdhcN82WhmvtEihMyLT1jCZJ5N14H2RSluWUFydRqU
 Ocjy7JduDHgKU+QmO0TRjsc1/UgjkHP+B8EIqHjuiZ9zQnCrdV1T0P2nQ140DJrKBYgZ
 ZF9cEZabEFVk2O8RXs7Qh78plAQQPBEvPKWAIKJOZOl05gbiYtF1SGiTxvIpZ/ZfXW1s
 ek2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1EbwOv8yj9dwK8UApjDfStz2RWrwDBklKn1BxxruFww=;
 fh=8JaUFgOhG+zB5v+lnCXwCeucgOe3HYCKIF2UinhTRLQ=;
 b=cSLLFR2bVg9Uc2rr+OVerXHKzE4wPuvC1MsJAdaOGItAzCfyw1OneCkw5zH6Hwn+qc
 wqZz1j/kxZlKzaWE2unSnBsJ/yalwHsGa1s3JXHVNb1h1aUIdsNWKXmfCOaCMhulMw72
 RCiBj9x2vlg0B9mdacNvO1W5j/xMeDedIsouPMVe4k2b+IDT+RCwbc0iCEhPGVj9BhyG
 yNV1OlZkLEJk+RuLy8ryHogqldCcY4Eui3pDU5uIR6vf/wpCzKzLkh9Jf43OpLa++FS7
 +lK2vGVh4m/2iMV4AD0RRqrxIkDTQ2u92Jf3Wl9rS2GeI3Wc07JlHCQ2cri//rBVR6df
 4eWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781987639; x=1782592439; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1EbwOv8yj9dwK8UApjDfStz2RWrwDBklKn1BxxruFww=;
 b=h7ONv8/oJYGPs9P8h8dVd4swC3ylEZvaDMtf6MGtZ1oCORBpdSwf0QsnGDuERNBzBT
 uwmiCzowGy505qePG8nn6voh8TgwiC1xI+QF7NA7d+9aOj0UMkAkY6zQtSDbPxxuEDrT
 WeFn5wIFi4N9Vdji56eDmIcWT2etqNP1x3H5pjjT8zmvKcGLhJdUKHWLLAw3hmbplAAM
 esuXsFQ3D0CnQuPVb0Bp97KLzjkD3YZTP+kP9I2kfN3dbBS59rwX/psHpDkJVkWR9nqP
 ebYxRL3GZCbNk5k+8X5N+5B1IoWWpZ2jL54pfk6/6qPjWY+AH2JaFgz+9cCvGAEr3+ID
 5Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781987639; x=1782592439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EbwOv8yj9dwK8UApjDfStz2RWrwDBklKn1BxxruFww=;
 b=fnvX2gqz74JsPzF4H6gQQ+U5tJDugOdZbxRnj1lTYdcFAW8K0aXBQYtHOuzB524gS6
 4Q4Y2P+H9SEUKvGesXXxVN6TmWzNY50Npd79E0OSO1qdmZ71gLTKPbVIGD496gUjDz8X
 p+eIVXO6q9RESDoFzmM0eEZBIhhjwbigHKb0a6ksszmDxfdw1BnVdB98+xjYV+jdSMDt
 DNur+nvedRPMTy7PZ+ich/mvKMt/7C1B14coI1ZkYzVUadONI89tWSCm0wNJXU4QMazj
 U49UuL3VjLBiAWLPn324inpRXN2oAxFmVZqTi3Veivg9BxAZs4EpRH6C7O5OEJuNeAqf
 dMQg==
X-Gm-Message-State: AOJu0YzPYAGcKkPUF48Q9PlqqYjFJWOZPgc2zmmVQWkCqt02pGZmgu5x
 2ctVhOavu0OuqxTE6tL/s4vSdL2ouOS33v3bV3cZOzI8uZF7RLvjSl0C+n4uaPy/GhoP+5kdLAd
 p2dXmSEihTnU7Ar8JBTL2kMvEc7rpcBk=
X-Gm-Gg: AfdE7clr62sS5E2oWQiQxJ/kN3AMe5yLsW/MNn55zMvS/609gWlGXT6m9OyFWY4m8Xm
 Uh4kkHhkBSDjznZJzkDrxOJhiBzLZisxPhdxe/8wrpyrOFDzveKRMWK7TCumPSf4H4ZkHVcPlsD
 M2OQ3ct8q9dopyel7AVk5GyhmrmlXVURw8rVv7ExOP8PMIj43Do8xpzEY8TtsK1isSAjDUgLSR6
 MoGiSBvTnh4aqkaTATgdkHPei7dSo27ljpJAf0lmMHqOyyxFWhusUhHZUPOsDEb4LYxXEyMPg==
X-Received: by 2002:a53:d017:0:b0:662:dfb5:bac7 with SMTP id
 956f58d0204a3-662ffea4ed8mr6728692d50.58.1781987639453; Sat, 20 Jun 2026
 13:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260620171318.24189-1-randomjack94dev@gmail.com>
 <CAFEAcA9_Cy1x46YQSawzmF_fc4GVq_77vyRF7TWwruBND9eCGg@mail.gmail.com>
In-Reply-To: <CAFEAcA9_Cy1x46YQSawzmF_fc4GVq_77vyRF7TWwruBND9eCGg@mail.gmail.com>
From: Evgeny <randomjack94dev@gmail.com>
Date: Sat, 20 Jun 2026 23:33:48 +0300
X-Gm-Features: AVVi8Cc4QBnUlljz6fudyhiag9f0BZdgszf4Wx1nqcRxHPF1v17FstSnfrNbhm0
Message-ID: <CAFvcSaQ4R7oQ9KMrEb81mZOaqZaR5XqCLn8-DJn-OX7GQuSSCQ@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/soc_dma: Replace if-else chain with array lookup
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003e6aa40654b55498"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=randomjack94dev@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003e6aa40654b55498
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Peter,

No particular reason.

Just found a small refactor-like TODO comment.
Did not think about this code being ancient.
Feel free to discard the patch then.

Thank you for your time!

Best regards,
Evgeny

On Sat, Jun 20, 2026 at 11:23=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Sat, 20 Jun 2026 at 18:20, Evgeny Kolmakov <randomjack94dev@gmail.com>
> wrote:
> >
> > Refactor transfer_fn assignment in soc_dma_ch_update()
> > via array lookup as suggested by the TODO comment.
> >
> > Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
>
> Any particular reason why you're looking at this ancient
> code? It's used only by the omap SoC -- if we care enough
> to do anything to it then converting it to qdev is fairly
> high up the list...
>
> thanks
> -- PMM
>

--0000000000003e6aa40654b55498
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Dear Peter,</div><div><br>No particular rea=
son.<br><br></div>Just found a small refactor-like TODO=C2=A0comment.<br>Di=
d not think about this code being ancient.<br></div><div>Feel free to disca=
rd the patch then.<br><br></div><div>Thank you for your time!</div><div><br=
></div>Best regards,<br>Evgeny</div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jun 20, 2=
026 at 11:23=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Sat, 20 Jun 2026 at 18:20, Evgeny Kol=
makov &lt;<a href=3D"mailto:randomjack94dev@gmail.com" target=3D"_blank">ra=
ndomjack94dev@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Refactor transfer_fn assignment in soc_dma_ch_update()<br>
&gt; via array lookup as suggested by the TODO comment.<br>
&gt;<br>
&gt; Signed-off-by: Evgeny Kolmakov &lt;<a href=3D"mailto:randomjack94dev@g=
mail.com" target=3D"_blank">randomjack94dev@gmail.com</a>&gt;<br>
<br>
Any particular reason why you&#39;re looking at this ancient<br>
code? It&#39;s used only by the omap SoC -- if we care enough<br>
to do anything to it then converting it to qdev is fairly<br>
high up the list...<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000003e6aa40654b55498--

