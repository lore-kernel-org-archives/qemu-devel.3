Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B179FD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09KB-0002PL-JS; Tue, 10 Mar 2026 22:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09Jg-0002HP-5D
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09Jd-0003y8-Lc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:55 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-662bf05f7a4so2505559a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773196118; cv=none;
 d=google.com; s=arc-20240605;
 b=UUGJg5lGSRFxTtU2f1ZbR2fEYwVkjpogm00R2z/YAdj+zkrJeQ6gUAWyqNBov7xyQi
 u3Y+CvgMVRUvBw621Q5LuUfrB7q6fXs47uq9zCdO/t9MIM40/jxuAfOnQkXR5iabgui7
 slB1SE6cXvZ8Gbiivw5kAjTYSb0jcjrXlMzAx/I/LAVWYrOmi4gFq2gdHDy0w1t9Qahx
 PQhhQku4zXrw2tZLTYWsQyE41PGmQRLFC1Gh68OqnJ4Z0K/fTBQQ5kIG5nF8YRM9/3mU
 XNw53FT+Lhjr+Y0HC/oV2FWT4waTVWH3f+I8HAV1FtdbshAePhQX/3l2DRpxPI7ENFKT
 eYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2PywI1npjVw8CIZhO7uwzsJnw8ecWqiaaLidatsyk5o=;
 fh=oP/9QI21LCU/DRwoSKb7f5DjNQL7Ft0NgPbpQymbh3w=;
 b=OyTJfSB+RjrFmMXYzOFcW308Hve2Vl6d8dfXxVljW3wQNmgbwCa1BkciMeJEAHpE3k
 dYhhRZJDYdcAxTYCnPxRdfgkZyM2n27FcJnxRPz7Bwn0004ny6sqpl3QqBCSqJCEHwF8
 5Shww5rMb00BrItQBGD3y9qZWtjw7xIdLJSFX72LUuS0iEwNa0lwu51ZzRnGqiOx6Cxa
 6DaBPiKGNFXDIlB/giACDL5qc0XOsUjLcbCGh2rYSISQojB7qfQDFmlux00rpl291dkK
 z6LafLui6jREKotG9QBZtpSDNnj6uOFEN6ApLNl3g2zuVvp03+2b8+ZYQG0FIMtcLi2e
 x7Bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773196118; x=1773800918; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2PywI1npjVw8CIZhO7uwzsJnw8ecWqiaaLidatsyk5o=;
 b=aLQ9nb3T3AU/U1kYUu6ysWw5ltAlAzaDRpCFgX6S2XQziEnOLnEvHwHcXbkCwbl3RA
 Qae/vFrQsCJgOLH1+oxdixsPn9uiuiFVmkqbLHdRFxHvuYrk2l8FxlikkEdu6idsAQpk
 KlvGX6ZabUEqSOzLOJXkwNXMPzklWmnACZxfXHmW9TH66Fk+uOS061aUQcWqhA9I3RTg
 QBjNG5AozGsQrAys4fDrtAANWDMftBF2lOWMHtGey1odtcsBhWYSw3b+bRuzEbd6/SKU
 6SOX6q0/oCqG2S8TbQscFoSgMoZ8RwIMjQOWbIvraNnfYv7EN/7wIuqRFuihWgXhALUj
 RQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196118; x=1773800918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PywI1npjVw8CIZhO7uwzsJnw8ecWqiaaLidatsyk5o=;
 b=J0GjChicY6JoUJ0LsYP220TLq6OTXCPDxSTFD1OAyHA5q1RwTtyPxU8QBF0NBik4PE
 5ABHbZ83ECaa1mFYLHnMzHQsgL9+e8kT93y01hhfJHrl3USebGNxIHQ0uClrr89izuRG
 zJon0QDvARzwq27XTKzOaWsvFPvpSRycM4Z4ezfqRCA7Y9hC1j6P/tXOzY/qj+bOiJK/
 SyjV1fWoi1S4tn0uGx3U5xpRRvcNcjbsboXP9MMRdihGeY7JWszRf4D43SaiopgiJAQ6
 v13ecm+88U36EIMAla1ZQUcxGl2lysFHbZ4UkfLJXmIdQAHP7km2y2/ojISSqdDQOed3
 MaVw==
X-Gm-Message-State: AOJu0YwhZMUeufCrtMVUTOwFV7DT3B1H5b3hrF9LwXZ98AfAjxl1SSZM
 lx7rFeWxFsN5/LBdrasW2hsJuStgrzpS8ZuQ8dTBz2V3sNEoJGF6h/W6/rZ34oa9aSMhM8WWEkn
 ZY7i+9yrsfpBvNOUgMCAEVhE1uaXLhkYOsfZYId/XisoPFBH8xdS8mfjWKA==
X-Gm-Gg: ATEYQzz78l7pAjAOrHjEdNZTQl4zt5hmbyfIrYvLPppwvMJqbPIp26L2LhdxrnU3PU9
 uZSINdJb+yvvq7B3uyakUJV/NHqaw4uykUgYrt/DWJCvmF/FvTGhncPgb4JPpbpyTYP1kFCu5f+
 yJcKouq7yFOqwUWVwCDWPKzWTYsSpBsNzzrghE3t366VZCagohFuV3SjqFEywB/D/cl/Y/a+Rkw
 efO5NOmaDKhnXEtSxRp35XPV18fQsSP0hQqdmptyZqVKncdkNR5LrW/PINWWjB4MVpWri+2lrl8
 pMtwEkTcIg==
X-Received: by 2002:a05:6402:84e:b0:663:4c4:e63c with SMTP id
 4fb4d7f45d1cf-6631a5e4b58mr284380a12.25.1773196118592; Tue, 10 Mar 2026
 19:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251209160117.1239596-1-frank.chang@sifive.com>
 <CAE_xrPjvVPqamRqsaqtuvPj930endqTcxRwknY-0_L8FQ_O9bQ@mail.gmail.com>
In-Reply-To: <CAE_xrPjvVPqamRqsaqtuvPj930endqTcxRwknY-0_L8FQ_O9bQ@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 11 Mar 2026 10:28:27 +0800
X-Gm-Features: AaiRm50x47tU4gFIzpLXbcx19ho71drUDsNzvDSYO_kvICuHmRhOFcM6jqAoHgA
Message-ID: <CAE_xrPiutr4Px6yTvf51Rn19-jSFnpBs4sQiKG0OjG+72Xj4qg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix SiFive UART spurious IRQ issue and misc updates
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c42074064cb6642d"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000c42074064cb6642d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

Thanks~

On Mon, Jan 19, 2026 at 4:13=E2=80=AFPM Frank Chang <frank.chang@sifive.com=
> wrote:

> Sorry, the title should be: "[PATCH v2 0/4] Fix SiFive UART spurious IRQ
> issue and misc updates" instead.
>
> ping
>
> Regards,
> Frank Chang
>
> On Wed, Dec 10, 2025 at 12:01=E2=80=AFAM <frank.chang@sifive.com> wrote:
>
>> From: Frank Chang <frank.chang@sifive.com>
>>
>> This patch series fixes the spurious IRQ issue in the SiFive UART on Lin=
ux
>> introduced after commit [1], which changed character transmission from
>> synchronous to asynchronous.
>>
>> Currently, the txwm interrupt pending status is only updated when the
>> asynchronous transmit handler runs. This can cause the txwm interrupt
>> state to become unsynchronized between the SiFive UART and the interrupt
>> controller.
>>
>> This issue has been observed on resource-constrained systems, where
>> Linux reports spurious IRQ errors. In these cases, the asynchronous
>> transmit handler is unable to drain the TX FIFO quickly enough to update
>> the txwm pending status before software reads the IP register, which
>> derives the txwm pending state directly from the actual number of
>> characters in the TX FIFO.
>>
>> The remaining patches contain miscellaneous updates, including
>> implementing txctrl.txen and rxctrl.rxen, update IRQ when rxctrl is
>> written and remove the unused ip variable.
>>
>> [1] 53c1557b230986ab6320a58e1b2c26216ecd86d5
>>
>> Frank Chang (4):
>>   hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
>>   hw/char: sifive_uart: Sync txwm interrupt pending status after TX FIFO
>>     enqueue
>>   hw/char: sifive_uart: Update IRQ when rxctrl is written
>>   hw/char: sifive_uart: Remove ip variable
>>
>>  hw/char/sifive_uart.c         | 46 ++++++++++++++++++++++++++++-------
>>  include/hw/char/sifive_uart.h |  3 ++-
>>  2 files changed, 39 insertions(+), 10 deletions(-)
>>
>> --
>> 2.43.0
>>
>>

--000000000000c42074064cb6642d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gentle ping.<div><br></div><div>Thanks~</div></div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Jan 19, 2026 at 4:13=E2=80=AFPM Frank Chang &lt;<a href=3D=
"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Sorr=
y, the title should be: &quot;[PATCH v2 0/4] Fix SiFive UART spurious IRQ i=
ssue and misc updates&quot; instead.<div><br></div><div>ping</div><div><br>=
</div><div>Regards,</div><div>Frank Chang</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 10, 2025 at 12:0=
1=E2=80=AFAM &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank=
">frank.chang@sifive.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">From: Frank Chang &lt;<a href=3D"mailto:frank.chang=
@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
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
</blockquote></div>

--000000000000c42074064cb6642d--

