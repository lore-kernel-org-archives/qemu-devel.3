Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C594C106FD65
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0rKB-0008VT-It; Thu, 12 Mar 2026 21:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rKA-0008VD-9G
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:28:22 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rK8-0000VO-Ms
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:28:22 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-663a6bb0fa1so1176201a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 18:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773365298; cv=none;
 d=google.com; s=arc-20240605;
 b=QYDnep31ZmghiK1tTToXjNCbRlLR2BPA8FbyxT+Pk4+MRf2rZfc+yC3jtbVnoMh5ou
 RosasAxVhT8pgGsasvjyjf/b0G8Jlq91n8s9W0s2Vhmm1TxXe3GBhizYeGHy+kmcUuw8
 1efouFFmQXoODutl3fqvklA9vBbtPzsngbIzfr0PJDmbrgQ6+tDhjSvpHIef2re2Gnr2
 oCKm3uXEJ/1NCO6iFeMUMiJNCgqVfUtdgcmKeTL6cu5UstvHrVeY5O9dyWT9AuAwMEys
 GR03FYDqwgjTjDGq5pKVxJKbX28BlYcjEp+rvID9aNPpXn2whJ8XaKb8AmrjYT6IjCeX
 bFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uvQvYaYWv851EkJoPz/haAyACBLzCoH9L1cPW1ALjJ8=;
 fh=Yugyz5SJJub7nbOEKVoR++9O2Yndc4n+VrwAcNFbVYM=;
 b=LFyxFV9Af9T4C33h/SVSH1IjWue7HIMopR0FT2EWFGaqjLCqZBa1FsXiEHtZDF3Kmx
 0txygfzqrO2rCjyqBgysekFOW0O2NhBU7UOKPjJYWE6o4U7tbHGZU9oPj8oMEUDGpcI8
 gmBL068tT7WL4UYXGJaMAqCLeyqcVEcxnqbwqOUXLrOT/gpGnBEGqNih2xLufULQc+e9
 p717adYiDOvDBEo6N9SBC7iPKecR3HKNqtzoWd78vKXhKZMd4rIRJZmSdoQNgmokmHeU
 mcCUB0pI9WZxgez+ME4lJLzk6d+2cg14uclpu3KEhLGNLLoM0WnofWa2fKDctRTQtNi5
 W4cA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773365298; x=1773970098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvQvYaYWv851EkJoPz/haAyACBLzCoH9L1cPW1ALjJ8=;
 b=dT70lD/PSCzVGJzC+C9okZJ+YriTtsuZAcL9ZVAHoEYFv+xH5cDxKA2Gzny8cIAh+E
 ZQQvFmM3mDHxvilSeQrCTCn8WoHapZtFFGdB60fSTjlBvrAmpeKFZrnWkGpH7WUHkhSl
 zAThF97voVmPIhO5EojC4mdlcampV5CH5jmmcPN7Q4WkSvZ/8PPTSvgLt4CA333vbruJ
 RrnYPxOne0YlFKkQy1eDLufqKD7DqlrVzY7KhP2gx6F1Nl/S+lKq3xqR5CQB8apa0I4I
 uf13gppW5ga/KRQNb0PwEKtsWYnGqKhFz3bYs2Z66NfgS1I2xvfd4+s5ldklMFvngVaZ
 XmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773365298; x=1773970098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uvQvYaYWv851EkJoPz/haAyACBLzCoH9L1cPW1ALjJ8=;
 b=NLrdr7RpklNO3dk4fLFzxJ3CdtkjNdQPghmDalUMwLT7b6q7r9lt0anc+dHsVW9E+j
 QhezeUR/IHU6uHt0CiVgM93mUhz46kvmxcBt8VUjY+T1fzxmFpckpC/0RRYjrq8CVXZF
 XGUkt0WUY5Kby8Ajl/QJ7Zk1BFD/AanURIsVUWew2QJhkSNO5Zc8aAYVM1FvNbOrrjSH
 b77yyK6qUVdy7I5sRxbLu02hLkhkeTYeVxirHnN/b/eXTJPT+EPysP6AQPG+8n72QoBl
 Zu3AtO/Jk+WDbG53J3XNOiUBNBFRnhawv0dVztkDYUk2vBnA83B57J7N7UKVcAqW2am7
 QNLg==
X-Gm-Message-State: AOJu0Yx9wqlYYVoAlO3a/LOBSYf5ZShEGwTimtA1A2YkTr/taCR+2Zqr
 L4phUoxVvtzir+84uTENpTGonQyIO8neQEGWhNhRN+3uhEJl4HxR+ja7mLoS4fN0v/oNaIlASe8
 wXdpEjvpFIK6aydYUAnt/gXN3VRCn4Xs=
X-Gm-Gg: ATEYQzwyB0eB2cSBrKvA3wJD9lGDTFI0ccRoN7ZUXiBrpx8NBXFw/VDhtXXjUyVvEY7
 L6H02z6jv750z5XUP4BYdeSSm7ArnvCDerPwoDcWEWp+3/WMJJMsTNlcoyTHZxMeq80Xvtut7l+
 /fIgVBGxzGe/RpfgGk+DKLP5/AAAUJF6WYc85MyqtFpLCKQrRgOk/qKb0WNhiQwj6yschfw6i01
 kCltecGjcWbyD4H6FVqE9yHShjl29he/cVRi5TFyF0zuGroN/KTmaIZc6EIknE+P3KHLJ1OMr88
 uzU0mwutlt7/elEoj7xvsaRgiosz+70o0fXkNg==
X-Received: by 2002:a05:6402:13ce:b0:663:56c4:2dc6 with SMTP id
 4fb4d7f45d1cf-663ba0e960amr861062a12.3.1773365298497; Thu, 12 Mar 2026
 18:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-4-frank.chang@sifive.com>
In-Reply-To: <20260312033201.1619554-4-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 11:27:52 +1000
X-Gm-Features: AaiRm51cuYHXxOLcrgxffYXgdyOdy4Qy1T6Gc74lF8OZZF-bEuuCiRfwUmCcdJU
Message-ID: <CAKmqyKM4UWfS-NhEOeu9gs1j1P6t5XgjA2F+ooZAgY=OWahHNA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] hw/char: sifive_uart: Update IRQ when rxctrl is
 written
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Mar 12, 2026 at 1:33=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> When rxctl is updated, we also need to check whether the IRQ should be
> raised, as the user may activate the Rx channel or change the Rx FIFO
> watermark level.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index ae71a15a2a4..f255cca960d 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -216,6 +216,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
>          return;
>      case SIFIVE_UART_RXCTRL:
>          s->rxctrl =3D val64;
> +        sifive_uart_update_irq(s);
>          return;
>      case SIFIVE_UART_DIV:
>          s->div =3D val64;
> --
> 2.43.0
>
>

