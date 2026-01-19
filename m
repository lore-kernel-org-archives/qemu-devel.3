Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75E3CA6003
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 08:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhkOh-0002I3-Ks; Mon, 19 Jan 2026 03:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vhkOW-0002Ff-DA
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:13:52 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vhkOU-0000gY-DI
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:13:52 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b874c00a39fso707878466b.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 00:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768810428; x=1769415228; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4kpEFkxghOueDZ3KM/KAw88Y9eVRIyA/kjigmail7dg=;
 b=ivTvwybqKj4NoMy4OAh5G5/NxdGZZn//++Nixg9C7RZ+L+jHp+SOtWuwwOR4Esb3QW
 +rwFE1iFwKxbUBKw3fmmW01y/KAixkYi2VgeX53C/abaNln2wGktTvj/Guk1V4pAjWrW
 QsgDb4KT/BzcBO9lQmTA+h4Fy+BaOooA1fnlojEPBroiRrR5aBhP6fmzZuOPVpAEAmFM
 t1HYYvK4xKzbqgKYDzupSK0VJdtlTSQe6PQB+doOdQjsRFeT5BZBLD0pRD+y7CHPAQQN
 VAybpmXnLs6KNKeYVVxfvJvXXX9pS40Ubga/Hk77l4bUx0dd99Y44pjU7PTTyr45GfcW
 LYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768810428; x=1769415228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kpEFkxghOueDZ3KM/KAw88Y9eVRIyA/kjigmail7dg=;
 b=AhFzW2SDJCv4YgrTzrOLUbP14ql+APvZSoF+3l2Vnz2XU9wl5GvhAn6YuqCDVd2FZH
 lcsyyai+iF1SOjpISFlmOZJk+SfmIJycQBnA2zQwZwMt+FLtAOUVATiVhDCFkljApneE
 UVvXPVbbUSq7YiGqkiVotvOBp1jlS8cv1DRw7Hj5r1Xzu0hW1yxHMV8344eOtvrE3fOP
 qes4LFOpZlg8XItBRjJmieE0qy4exih+Obz+McN63iTjzxC0AwgtrXV0SkGXm1c5TQLY
 tCg435W4QhQAJ93ru2HzeIIuZITWtBd6Q8w0pIh8/HcG9wJgIAmytQfDXicf+qNto276
 51vQ==
X-Gm-Message-State: AOJu0YxzGC8tndRNyUiOXvf40ytZVsC18TpSf7pWZhflwcVtgmq2jqkU
 NRwqnYMNy293/9Q6p4XgXoZeyeB5NrsPmPbJRzc5Q2hXVLcwTIugQj5DcaVuiYdGpDELc+8/WX9
 895BT0FM+c4/lPZwxY5uB6eyCNMNmgtxQ96dSbIsWzISd65fXVRXh4WPbsw==
X-Gm-Gg: AY/fxX5GzcfG3WP1UPEmeyrIAKAoGhgT9jTPyQ9k/B1FaFaYECUb235EVrRY0z6Ag8k
 1KXLtroQd3Adjus7Yr9EWPI56DJlBNAjHinZdk4NDaJ6/X8Z/hm7Dphf3Q6LTt3Y/D+ZiiA7Y8J
 Xi38QmzJt6Q+qyhTbxiIo+7k0a9CfnDNYjp7p5qaY191+KuiDK7kbkXOuBiuQ+yFw2FhPsJVX+D
 GLUlCRlIaM9ieullFPR4YuJfC03yqGQfPmjj+m9FWpBUkqFlghZkDQNPURH7PTkTCxdebpc
X-Received: by 2002:a17:907:9694:b0:b87:191f:4fab with SMTP id
 a640c23a62f3a-b8793a23490mr957156766b.26.1768810428098; Mon, 19 Jan 2026
 00:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20251209160117.1239596-1-frank.chang@sifive.com>
In-Reply-To: <20251209160117.1239596-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 19 Jan 2026 16:13:37 +0800
X-Gm-Features: AZwV_QjzSxluB76Ui8TsFWg0Bdr6CTJE6dCGzgYrNB-yvxqowlPhqObDqF_gTEc
Message-ID: <CAE_xrPjvVPqamRqsaqtuvPj930endqTcxRwknY-0_L8FQ_O9bQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix SiFive UART spurious IRQ issue and misc updates
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000003dfb6e0648b945c7"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000003dfb6e0648b945c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, the title should be: "[PATCH v2 0/4] Fix SiFive UART spurious IRQ
issue and misc updates" instead.

ping

Regards,
Frank Chang

On Wed, Dec 10, 2025 at 12:01=E2=80=AFAM <frank.chang@sifive.com> wrote:

> From: Frank Chang <frank.chang@sifive.com>
>
> This patch series fixes the spurious IRQ issue in the SiFive UART on Linu=
x
> introduced after commit [1], which changed character transmission from
> synchronous to asynchronous.
>
> Currently, the txwm interrupt pending status is only updated when the
> asynchronous transmit handler runs. This can cause the txwm interrupt
> state to become unsynchronized between the SiFive UART and the interrupt
> controller.
>
> This issue has been observed on resource-constrained systems, where
> Linux reports spurious IRQ errors. In these cases, the asynchronous
> transmit handler is unable to drain the TX FIFO quickly enough to update
> the txwm pending status before software reads the IP register, which
> derives the txwm pending state directly from the actual number of
> characters in the TX FIFO.
>
> The remaining patches contain miscellaneous updates, including
> implementing txctrl.txen and rxctrl.rxen, update IRQ when rxctrl is
> written and remove the unused ip variable.
>
> [1] 53c1557b230986ab6320a58e1b2c26216ecd86d5
>
> Frank Chang (4):
>   hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
>   hw/char: sifive_uart: Sync txwm interrupt pending status after TX FIFO
>     enqueue
>   hw/char: sifive_uart: Update IRQ when rxctrl is written
>   hw/char: sifive_uart: Remove ip variable
>
>  hw/char/sifive_uart.c         | 46 ++++++++++++++++++++++++++++-------
>  include/hw/char/sifive_uart.h |  3 ++-
>  2 files changed, 39 insertions(+), 10 deletions(-)
>
> --
> 2.43.0
>
>

--0000000000003dfb6e0648b945c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, the title should be: &quot;[PATCH v2 0/4] Fix SiFiv=
e UART spurious IRQ issue and misc updates&quot; instead.<div><br></div><di=
v>ping</div><div><br></div><div>Regards,</div><div>Frank Chang</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Dec 10, 2025 at 12:01=E2=80=AFAM &lt;<a href=3D"mai=
lto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">From: Frank Chang &lt;<a =
href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive=
.com</a>&gt;<br>
<br>
This patch series fixes the spurious IRQ issue in the SiFive UART on Linux<=
br>
introduced after commit [1], which changed character transmission from<br>
synchronous to asynchronous.<br>
<br>
Currently, the txwm interrupt pending status is only updated when the<br>
asynchronous transmit handler runs. This can cause the txwm interrupt<br>
state to become unsynchronized between the SiFive UART and the interrupt<br=
>
controller.<br>
<br>
This issue has been observed on resource-constrained systems, where<br>
Linux reports spurious IRQ errors. In these cases, the asynchronous<br>
transmit handler is unable to drain the TX FIFO quickly enough to update<br=
>
the txwm pending status before software reads the IP register, which<br>
derives the txwm pending state directly from the actual number of<br>
characters in the TX FIFO.<br>
<br>
The remaining patches contain miscellaneous updates, including<br>
implementing txctrl.txen and rxctrl.rxen, update IRQ when rxctrl is<br>
written and remove the unused ip variable.<br>
<br>
[1] 53c1557b230986ab6320a58e1b2c26216ecd86d5<br>
<br>
Frank Chang (4):<br>
=C2=A0 hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen<br>
=C2=A0 hw/char: sifive_uart: Sync txwm interrupt pending status after TX FI=
FO<br>
=C2=A0 =C2=A0 enqueue<br>
=C2=A0 hw/char: sifive_uart: Update IRQ when rxctrl is written<br>
=C2=A0 hw/char: sifive_uart: Remove ip variable<br>
<br>
=C2=A0hw/char/sifive_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 46 +++++++++=
+++++++++++++++++++-------<br>
=C2=A0include/hw/char/sifive_uart.h |=C2=A0 3 ++-<br>
=C2=A02 files changed, 39 insertions(+), 10 deletions(-)<br>
<br>
--<br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000003dfb6e0648b945c7--

