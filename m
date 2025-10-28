Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0D8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDk0b-0004Nl-Rf; Tue, 28 Oct 2025 09:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDk0T-0004I0-La
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:45:01 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDk0Q-0005bR-1q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:45:00 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4e8a25d96ecso93785851cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761659096; x=1762263896; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAzBP0ylFDH3aCqg/YCFWvWqn6e9H8X8WYM2/60+nrk=;
 b=XCWuOOciC41LSN3WXGtq73ya6le01EQVO2VjKMCEL9qy7nhqI5KjLy6DIv6VviEwvA
 FYUexiTPJB2PzaGaRkJR8MLia0qi3QA2V70Nnv07+5cqazt0m9+sGPdPYZK1Snb/MeNt
 I16QwDam7pg8HL+fkQVs2Coyve7RJY8hqXHphf7jQX1ukPtjrI1oheMubUXs8VGGtkKE
 jK4AGVH0+rZVbQsrSzNpTPNu5wVRiXhdud44NJoqbAOw29OXRn281DuHfAjluU8BvpsV
 Nbux88erRVFtfPL/e2I5ZpkFctkAGOn0l4i9YiupOYeITL7sjhB2hEdOcHFvZGuTzYdB
 tHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761659096; x=1762263896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAzBP0ylFDH3aCqg/YCFWvWqn6e9H8X8WYM2/60+nrk=;
 b=NdeQDkcvLT7lkUoQLQlIvfnL+Zdwx3an9srOMKr0lHJMZGnhbYyziOR1i8wTzuecuo
 qd8MT1+THa6enZIVf/vWO3Kh5IstvfQAnxq4xhdiYzpEMGt5Nx0KxInA3AclwWVmRyFy
 4N6TiT3UjwICmV5rNBMMLusPwH1Z8sCUQQgAdyfr3y7wUH0xt517CGXd0EgpAT2ywOJw
 gYBZQkOvZzqIuB+/AashDWSMeMbLxKXQEfun639JtWTcLsf1FlTw9d5pkL/T6IfgIhGn
 uO4dpnDZUATHDRioRGVyuL+Qp1BdpLaS/dw+pELX5bEqJ/Au/RCsEOOwEkAUf0xen0bo
 VyIA==
X-Gm-Message-State: AOJu0Yz0HQ4w7JtrWpJqNxx+IfP1SYT/0WBOAobK45QR3pCX5n3fMCx1
 0D2RYufg4j3mPB8Gnt3OPrXuJ7PpR3uNijh9CztuftwCz9fLcS7w1ngHsrCl55qHbawWppL5ldN
 OLm3ZUQS91h1D8Gbcu/4kVKQRvZAmHxw=
X-Gm-Gg: ASbGncv+3yUIUkJsbNnty0RZumrqDYBn1XhGRyaXpXfffaJuqN7Y34s4q0IGrDOZzU1
 gz+fXdcLd+nChdlSLXQ10mD08KSNOVpmLBpM2EmuELk8aM6nilEkd4g3WVuhRor0ntxrgjI9bvC
 Y9WMXzAQIip80rIeJtwbzQRsZOchonfVkgAsRbBA1eL1rKEdeLb3Rm2bLYgRNwDuicX8wU8hdcK
 GfdMGS60Tx8gPDUBSLsxOQxzjjd0kOgE4Om9FA4pZsXy3pSyAh1vH2lDwqWISI1uLplOE8n/PNn
 zYr4gf91fsINpqwg
X-Google-Smtp-Source: AGHT+IGYOi0Ss6VotGm3G2gtr5AE16k5ubJWWyuniLVw9QWY8kLrjzoNR7vychiJx09nUB5gaPxqPQQ9a8LAi9n1HH8=
X-Received: by 2002:a05:622a:2449:b0:4ec:f452:4ec0 with SMTP id
 d75a77b69052e-4ed0761d408mr47574801cf.69.1761659096103; Tue, 28 Oct 2025
 06:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-6-philmd@linaro.org>
In-Reply-To: <20251022150743.78183-6-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 17:44:44 +0400
X-Gm-Features: AWmQ_blAuG5AkxT67GnmcEfV8fpnNPG5rS8QzOPT9XFAzpVXtQJPejhV5mJBxSA
Message-ID: <CAJ+F1CJ4xxh-y_S89gG86gfEdEYviQ=ajvcC8OW4a8XfFW2gLg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] chardev/char-pty: Do not ignore chr_write()
 failures
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Oct 22, 2025 at 7:09=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> If ignoring this is deliberate, this must be described in a comment
> to avoid any confusion.

Agree
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This is from commit 4f7689f08 ("chardev/char-pty: Avoid losing bytes
when the other side just (re-)connected")

note: It's mildly annoying that the pty backend has still
!s->connected and we are writing. I wonder why the frontend is not
respecting the backend opened state, probably some race or buffering.


> ---
>  chardev/char-pty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index b066f014126..652b0bd9e73 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -125,7 +125,7 @@ static int char_pty_chr_write(Chardev *chr, const uin=
t8_t *buf, int len)
>      rc =3D RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>      g_assert(rc >=3D 0);
>      if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
> -        io_channel_send(s->ioc, buf, len);
> +        return io_channel_send(s->ioc, buf, len);
>      }
>
>      return len;
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

