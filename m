Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22D3CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 10:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHgVB-00087s-UQ; Sat, 08 Nov 2025 05:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHgVA-00086d-EV
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 05:49:00 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHgV8-0007fo-JS
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 05:49:00 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63fbbad0ac3so1510273d50.1
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762598937; x=1763203737; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/7PzARsi/fJbtsIP4ReGVPzOE5ErTpCvAzEkeJbnX3w=;
 b=fa4W4kIX08fwIXY/mWMWY+nx91Jah+zAaFPkk+mXJ+6bLHx0alqI6lDk5j9Nt/PRur
 xfV2zoRo3Ler+aUvoEuBNOOsFgHIrbAKfKEoi5i6Kw7fcfn0jCl+MWxJteHyTwdKyAat
 1uK/v6Us0kJEunmEoTW1/qRyl/pTzA/EZxUnFG80hLgQsJLUVkJnxyoKDb0Sa7ncbOEj
 YiGceq2kKbGjCVediatsX/TqPDuNqwGidtnjMxW+DJ/b7c7lwoxDdf+VkyC+MXvLIF4y
 waAUzQcGr0YuZu7UuCLwPCZ8FTqX6p0hQqX3gLq1Zf8lldMnfPfaWSMTNPYD/N1Q6+z3
 Rfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762598937; x=1763203737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7PzARsi/fJbtsIP4ReGVPzOE5ErTpCvAzEkeJbnX3w=;
 b=AfEI93OKIRwGk27UORpONDdY08+Rx3K/FvIXuKIWSLmQoGCf4uuZXXsrp2XACBNXm9
 nX60D8fFxBKWg0tFkX/PovzrDrCydDcWQp+LX95rpRq8qqz761z6DH76AIXcIW9kBvHW
 Omm0/JNHLlbkGuORxzxkyqRySYamBAJgnkvL9Le/UwSlzsTa9OGAe8HDjbfHGjhIq39h
 lLJc2+h/IuPUv3OUon6c+h98o6fHvOoaz0t2qezhzz4jD29J/Q6uy6D99OrBaOfgUdIG
 vJO4mb/aCI2PoASFC1vzXI95Ei5KPntBMH+I60D3P6/IEkyhB5+5mkWlBPRr/PGhTHUy
 Z3gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp1KHH8X0BQTBlHn1RND9rU28VQK8+dlIJgIxwAqYAeIsJK3xo+iJUWWkJxfgwIp7fXHde0U25AKpp@nongnu.org
X-Gm-Message-State: AOJu0YxLDh+ixIOogxp3cfuZYWoqLETPCqonO2hCyYehb1KEoWXZlVMI
 3AWZDcq6P7oVpkRj0T/UeFPLszLAx057eSpWN+v0pjCjNvghKZ4QZ1oMf3dpve99vluAWyLAnbj
 EZOYZ6/7ZoV44RTOzs2ASFWuJ0f819lSHeXBriqNA0A==
X-Gm-Gg: ASbGnctXpt4DIWnRMApmZruYxLP52k06CPq5Mh6OvoDFFmwau3bTpvdyrMaEPPGzd8V
 6HstK7FO5D8IW+W4kkHPQMfXjkicSGx42u6+x+m5sKok6mIji8dfCfEZls30pICioMwQhaAVpZk
 c/AEdjnEGcaFdjnuzveB9Wxfnby89FDC/zyIMuhCP5w0LorOAYqS6ePjrGgSkggXp/L0yXIJYpC
 KWLMSSE6b8OpitPc8K6tfQ5Qpa9AeWXGju6tSjS+oJuIz4BwJCH76z0hAjodw==
X-Google-Smtp-Source: AGHT+IFtLRRgYVqK330VsT30yfLTVJ47sYTAD0x3DCMm0R2lJ+xLGt8Vg4b69olpAd5JiBrUqk+TOPUuor2PnGWiAg0=
X-Received: by 2002:a05:690e:42d2:b0:63f:a705:ea9 with SMTP id
 956f58d0204a3-640d45eeeebmr1467188d50.62.1762598937067; Sat, 08 Nov 2025
 02:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20251107154116.1396769-1-peter.maydell@linaro.org>
 <5da4fd2b-6c5b-e2f4-b421-0a440718af7b@eik.bme.hu>
In-Reply-To: <5da4fd2b-6c5b-e2f4-b421-0a440718af7b@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Nov 2025 10:48:45 +0000
X-Gm-Features: AWmQ_bkwnAxcUb4K5WNsKGiwGMJnYeNt0lxxdnJWrRXftSmiyiKnuB1bhuMsuUo
Message-ID: <CAFEAcA-chUva0qpzxsyRd65rtWMHhqC2A6XbNnQ1so3RtCjArA@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/lm4549: Don't try to open a zero-frequency audio
 voice
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sat, 8 Nov 2025 at 00:22, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 7 Nov 2025, Peter Maydell wrote:
> > If the guest incorrectly programs the lm4549 audio chip with a zero
> > frequency, we will pass this to AUD_open_out(), which will complain:
> >
> >   A bug was just triggered in AUD_open_out
> >   Save all your work and restart without audio
> >   I am sorry
> >   Context:
> >   audio: frequency=0 nchannels=2 fmt=S16 endianness=little
> >
> > The datasheet doesn't say what we should do here, only that the valid
> > range for the freqency is 8000 to 48000 Hz; we choose to log the
> > guest error and ignore an attempt to change the DAC rate to something
> > outside the valid range.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/410
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This bug has been around for so long and is a weird edge case whose
> > only effect is to print a debug message, so it doesn't really seem
> > worth cc'ing stable on.
> > ---
> > hw/audio/lm4549.c | 17 ++++++++++++++++-
> > 1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
> > index 745441bd790..bf711c49c04 100644
> > --- a/hw/audio/lm4549.c
> > +++ b/hw/audio/lm4549.c
> > @@ -15,6 +15,7 @@
> >
> > #include "qemu/osdep.h"
> > #include "hw/hw.h"
> > +#include "qemu/log.h"
> > #include "qemu/audio.h"
> > #include "lm4549.h"
> > #include "migration/vmstate.h"
> > @@ -179,9 +180,23 @@ void lm4549_write(lm4549_state *s,
> >         break;
> >
> >     case LM4549_PCM_Front_DAC_Rate:
> > -        regfile[LM4549_PCM_Front_DAC_Rate] = value;
> >         DPRINTF("DAC rate change = %i\n", value);
> >
> > +        /*
> > +         * Valid sample rates are 4kHz to 48kHz.
>
> Commit message says minimum is 8kHz. One of these is likely incorrect.
> Maybe a typo in commit message?

Whoops; yes, you're right, the commit message is the one
that's wrong. The datasheet for this is at
https://www.ti.com/lit/ds/symlink/lm4549b.pdf
and it says 4kHz.

-- PMM

