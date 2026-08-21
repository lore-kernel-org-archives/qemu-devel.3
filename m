Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5762FC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxM08-0005iP-8H; Fri, 21 Aug 2026 05:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxM06-0005i6-Rl
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:57:26 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxM04-0004c7-VV
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:57:26 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836cde02992so10057357b3.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787306243; cv=none;
 d=google.com; s=arc-20260327;
 b=g4mQp8jVtUlnLp8hl3vwwEJWZovDJ0sNzvTyETi0YuEgd6STrifAJevISogH3Y8WyI
 l/bEq60ioVXqPcfi8BEkS0qAUzflgbjlXK8KgApwGYTXvEAQOYKvdFcdYckrfEUw5TAe
 f5tmDZgbzmD6OM59GAISDs6DLrvrWxwAxSiYfPv7lTboid+YkVsU4UFFvlC2wQV5Y14H
 Qb8YZlmY+U7RdC8LII/lo8V6Oo93CqFoBgcDL/uPwt3NQhx+7HmnHoTUZWuZ7/liGZ0V
 kbXPMewJISzOvoIRPFSGVPMMoLnVBdZxQGeWy1Ke2ShH+pPCBn8/jSatY71RFLbMcOr1
 bFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QlwE2BZT0vFPaM9sreHJ6Q5FEFcI6GiSfHphOHDg26c=;
 fh=6SBFmKFZaeQ76lZmIHB1k9Da5YCHYK8VnV94Xo5DFKs=;
 b=RWQirhnbXhleoWAbR2BiSCmZGX2IAC2XmTUiak5n/RLKBq6GdNN01dVtHiV1OwIyrQ
 lG7iLBYXiixzLEdsY1eKdbMEdtL4e2dUNma3J6J5L69OUhj8Jydt3rT0cVpODI+7BbKY
 Q1/M2RV25wzVq10SzYh4upCYVOq8FpxWcY9Y1FqJleRdms0gzmzLc4KQQDxiQqu10hcP
 4bSCcjCvZ4qrEQ8/Mw8kY62J4eepFN22DndidyKdCD18ougGy80ji1VFtiO+SdlZ01vb
 Y9e1nwFF64HuQYUds+P7toMj6z7voZANOrQnBDIb9fZ+yeWbMFIqH+tLmGGKYlGCLiJy
 ivNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787306243; x=1787911043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QlwE2BZT0vFPaM9sreHJ6Q5FEFcI6GiSfHphOHDg26c=;
 b=xCW2u4Wsxe5Zotj/kBQUAVn3q4jsLfnJGTj1gIVhmdDDDHtbBMI+HBpc92hkgPqTpn
 7XX2z5qn9qTZMpAkVBIyL08JjW9YyVDqAfrkE7i9Nl/NjllVx4tzXwlNGUYTWM8a+azd
 /rG6Upm5T4fC0myNsTi25vWsdkUcqsgYtER9/O7zOHcNNOULtwO21+8Qfk+ShwK6rMld
 H0gw9T3OOVOw1xxPSOAt1LSKDGfo+hRvmOiE26rD2MGMFXTkoutxfB0Q7/OIv/zucPcf
 dpIs/zO14qboFR0/53EHPkLp6a+4eeuveEd8Pmi7aJv3p+DaJQ5NwZ3TgQBMZY72IeCS
 GZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787306243; x=1787911043;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QlwE2BZT0vFPaM9sreHJ6Q5FEFcI6GiSfHphOHDg26c=;
 b=ktPzC/vJZnc/QpvngWpsMc91xATdZb0EnfkbttBWrrhtSDx+gZaOfvxUtk4IswRQ8s
 5knQ22K6dfvjhbJPe6fX3w+DrJyx017St66QGsqeVlkkHdeChg/fualdu8tgujUPrsFY
 CQKqYLLnF5dRiS8zJSYIs6iKHu+lZe88DBacNEOv5MGfMI1NXyZytkkmVh6sDVjSpD3n
 HWPc+Ezm1Ik2h6rjN698rtCymRQcmHDurCbtG84vi+oeLCFln03OEIpI5FyGUx8XLs0E
 t2MHy7Pm+Y1dzrJ7Uqhv78BN/VolN7PpSZMMWg88Cbaj+5oPZJFa5g2PVUooYBnsp9QN
 IqoA==
X-Gm-Message-State: AFuF++kR1IUX6PoTdGM9S6xq/yUCt152Ut2QxLnwXFAvLIU/FxJNFNTj
 co2AgnsiKALf1gM3RbquKFs49QO2aY+vgCa00V8xqT34TG2ZSMrxDO6MsQGssfjZB07oMhNm3v2
 KSLO5nHHixkR02DKznEXZkz429jcAZ4HX0LoyW1e8YQ==
X-Gm-Gg: AR+sD11KEjXAfmO1slZMNIUhyCxrJS2BdbLaVCSRY2CUmk+Wdus/d9tT05leODFPBoJ
 EQDz953sVlsYEJtwT9O+esxwFLf1A1IBvLAW87uQmMgpjtVuSsvTBEfnrYbFMaLmHhdxyeNpO8c
 hXCzW1aGuxxePr7lokZTzGcqB2uDsrTSzNaE4OuI5naMzm3wik+f88XmUZIU+m7FX+P66dHDozA
 vtzFBpc/i90pEe8NOqeXRwDy77hmaC3CEia6MbMXzoGb9RjbEY0AkJRC5dD/XvLgfv1d3JJ02g8
 yjnUCcT45UwNbTDlEWGyZRwhwGrVGBD7er932AyioYkPMRAYvuIgtM8AMjEC+7UrayOV38M0rVM
 SLaLkziw4Qi/5qVTusVQQCDCbx5Si
X-Received: by 2002:a05:690e:1c0c:b0:66b:2f08:db1f with SMTP id
 956f58d0204a3-66ce4a54085mr2022772d50.19.1787306243478; Fri, 21 Aug 2026
 02:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260817113349.103833-1-alexander@mihalicyn.com>
In-Reply-To: <20260817113349.103833-1-alexander@mihalicyn.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 10:57:10 +0100
X-Gm-Features: AcwNN1X-J4scuRABFwA-0Icsm2oGAxxK0j1_zYAKmr-eyqDSlvc_c65wnUXDd2A
Message-ID: <CAFEAcA-BsxOCC4eM1ohcnr3_xmCabKNWQchtdsVzO91stiir-Q@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/pl011: support backend hotswap
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 17 Aug 2026 at 12:33, Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Currently, when Incus issues "chardev-change" QMP command to change
> chardev backend from ringbuf to socket it receives an error (with aarch64=
 VM):
> "Chardev user does not support chardev hotswap" [1], [2]
>
> Let's fix this by properly implementing BackendChangeHandler for pl011.
>
> Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, because
> if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is true=
),
> then after change we need to send break to a new backend too.
>
> Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-conso=
le-on-arm-architecture/23096/3 [1]
> Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.i=
o>
> ---
> v3:
>         - introduced pl011_set_handlers()
>           [ as suggested by Alex Benn=C3=A9e ]
>         - introduced pl011_set_break()
>           [ as suggested by Philippe Mathieu-Daud=C3=A9 ]
> v2:
>         - fixed a typo in commit author name
>           [ I did `git format-patch` and copied this patch from my Raspbe=
rry PI
>             dev/test machine and it turns out that I have a stupid typo i=
n my
>             `git config get user.name` on that machine. ]
>         - added RWB tag from Alex Benn=C3=A9e
>         - adjusted a commit message

I have one review suggestion here:

> +static inline int pl011_set_break(PL011State *s, uint64_t lcr)
> +{
> +    int break_enable =3D lcr & LCR_BRK;
> +
> +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK, &break_enable=
);
> +
> +    return break_enable;
> +}

I think this would be better with a similar API to
pl011_loopback_break(): make it take a bool brk_enable,
and return void. (pl011_loopback_break() takes an int,
but we shouldn't copy that: it uses it as a bool, so it
ought to take a bool.)

>  static void pl011_write(void *opaque, hwaddr offset,
>                          uint64_t value, unsigned size)
>  {
> @@ -462,9 +471,7 @@ static void pl011_write(void *opaque, hwaddr offset,
>              pl011_reset_tx_fifo(s);
>          }
>          if ((s->lcr ^ value) & LCR_BRK) {
> -            int break_enable =3D value & LCR_BRK;
> -            qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
> -                              &break_enable);
> +            int break_enable =3D pl011_set_break(s, value);
>              pl011_loopback_break(s, break_enable);

Then this code becomes something like
    bool break_enable =3D value & LCR_BRK;
    pl011_set_break(s, break_enable);
    pl011_loopback_break(s, break_enable);

which is more straightforward than passing the raw LCR value
to pl011_set_break and relying on it returning the "is BRK set?"
information that we then pass to pl011_loopback_break().

> +static int pl011_be_change(void *opaque);

> +static inline void pl011_set_handlers(PL011State *s)
> +{
> +    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
> +                             pl011_event, pl011_be_change, s, NULL, true=
);
> +}
> +
> +static int pl011_be_change(void *opaque)
> +{
> +    PL011State *s =3D opaque;
> +
> +    pl011_set_handlers(s);
> +    pl011_set_break(s, s->lcr);

and here we would then pass in s->lcr & LCR_BRK.

> +
> +    return 0;
> +}

thanks
-- PMM

