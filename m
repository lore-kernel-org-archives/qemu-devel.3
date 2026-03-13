Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CFF106FD65
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0rIl-00084D-Or; Thu, 12 Mar 2026 21:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rIj-00083R-Um
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:26:53 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rIi-0000Nf-Dd
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:26:53 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66132b22182so2056778a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 18:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773365210; cv=none;
 d=google.com; s=arc-20240605;
 b=eisBuwuleMK9g0laW1gmXEAPe6rLwH9EKZ3R+JUOasH+0XJHql7KX9eUK2/gbwURhW
 7a054E0VoeVv92LUJB89LH7eoLbotCoGlw+RQSvdlbY1V0p80SSbPhQe8g5FGQdXzfGk
 jHt4hczUof/VAAaiqLqW1oYXsDKoloLqfHfu+xBHKnNG2WkcgQShHIplOTUU+q++TUzi
 Roar2Sq8iOX6703WMR20esT+fhtqYxWNmACU5Arfpjt7xvzlpbqENuQ/ESd7seHCMoDm
 lK0/UijcUj0pS6kqOJkUN5P7ikQ4TnIuU5LN511/wq6vPFfGy+urklTlQwRNVK81vrDi
 UCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B7i9FV/f1TyHwRcYkxAIy8idXoOKa/+BGZmU+lvSR8M=;
 fh=Yugyz5SJJub7nbOEKVoR++9O2Yndc4n+VrwAcNFbVYM=;
 b=ED7Wvhz2qsknjD7SrBfTisJ78Hg6pO+DnrbWF7g1ogaOA//WZ0gJAUZSSoZhivKtiW
 aC+pIo1haIBblm7ouQoFUDP5a6ecWa+tR9Zhtulvv1DNFcm/qpKrCIL9xAzZ2iXLmCa1
 FYzk7WavfducBs5fl3bp6goFzdKPUpmwL9K3S2Yo3u+f51Z6NPdA9OKKqxqtlPo6MLbx
 WVp8r1suTbcJwlnzs3zy01vN3MeOWQULpvZeNyUOTTmaGQFzC2of6TXau1TniIDZcbrn
 9j4HiCME/glBaTy+41fHR3Jd331In5VR23+gI/4+QvZzqtmgweF64xYyIUcVsIdXLS2H
 AT+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773365210; x=1773970010; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7i9FV/f1TyHwRcYkxAIy8idXoOKa/+BGZmU+lvSR8M=;
 b=nbopfTAAzxfulFVga3I4AlZigyblmLEfBMYHlSSfQa9EspI5MaVyljNLsWRF2BzDH3
 TUk4jjRWa1U9h0npKKquw1fEttbx1aVPLPV171w0lxMC1OPqRt/iVWceVWvptpFZmMPl
 RmTSLU/N7KDLjP8ZEna4gCjqKc0jQvMzw8gfuInx4+5eLplhOvRs6zOcAa/d8fu1a9aB
 iDz/CyB9xtWsampqW/m5GkY3e9sapk/+fTavn9Vs97UDQKGMFi4mg7eRylBiEunE5qMJ
 o1R5FyTnMGA2skQ0EkkSTgCQv6IvyAM8rfC4cH7K0DL3MK0ekNDVz9e1E4Oowbuam2QM
 5wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773365210; x=1773970010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B7i9FV/f1TyHwRcYkxAIy8idXoOKa/+BGZmU+lvSR8M=;
 b=V7xRlfEbXXahK/AkoUZKu5zs0D+RVjRCGtIPt/JYxblqnttxhkdYVwJc+eLcNToNwR
 jxO0qC1FowxKsO+SYGGEmUAyzp57Dbm0SM1P0mMBoeshf1fSOonZKrfuYN1SgSiErpKZ
 nLs3lq61mhGxSFf6mbgIPRwG7W/q3mCoHc1uZzlSTidg5NXQ+LJbK/zWKfG5ialXYAn4
 ytFjH39pcUdRc3LejfO3Tn+pZZQLmnfsoFQ70atRpesCfQpc9FPLF9DY7Zt3ms4WORUj
 NmxY994tf8FZpFMhNJOEpR1c6mSS47nWMSRjLqhG8QMbq7ifBXXfh7ZpsgFQoLQUamaw
 eVmg==
X-Gm-Message-State: AOJu0YzIS05vO9kQQim3Qj041R5KHfper1Nh5y1PQIMfMFK8vYj6hm8e
 D73UqApdHAQ+x3bqTty24ca7tg5ryUb8LdZ4zhh160v6YLiuWtVowfHFZQ1fV1ZRmE4cXYTA3In
 f/orVSTMAxUxBElkB5IozZywNSyD3b4E=
X-Gm-Gg: ATEYQzyUqGngVNGPk74qoXxAVYOa8DAXnWIp5+bCxMl1GIGx0LmHAlLMkTZ6i5lbdCX
 AHWTNkjbEk0N5bSAVK3CNintqp0d0/84PPOwWRIwVm4Sx5XWwkp2yHvGS7PL48Yd9wlpPblTg7m
 KeQIwwSvdRbl9pbAoOmlxkOOSagd+9HmkpqGBTSu5pwOoV8q9NFFu9bl2ze40ypuM5gci10rh7y
 fcJ/VhGwAMIoK94KM2kzjaywzWQNgo1sUsf0THHejQ/LAvFf5Inen6wEsqFamJhPz5ZQ22PMN0O
 ttD4pkWlfS0P83AXT3lACSUCWfKdE0FMlL4QnEtlB8T4VpkZ
X-Received: by 2002:a05:6402:3649:b0:663:9001:cf6d with SMTP id
 4fb4d7f45d1cf-663bac18c53mr564038a12.32.1773365210449; Thu, 12 Mar 2026
 18:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-3-frank.chang@sifive.com>
In-Reply-To: <20260312033201.1619554-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 11:26:24 +1000
X-Gm-Features: AaiRm51cyY7HpU5Dxui8LH-NkdqU2x0rHApBEnIpwxQ6QjBbJcfZtLYEY6ACinE
Message-ID: <CAKmqyKPfuCHGq-TE6p+mwCtwBQxx_bpAh=D1gUZ=t8EO+Z12Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] hw/char: sifive_uart: Sync txwm interrupt pending
 status after TX FIFO enqueue
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Thu, Mar 12, 2026 at 1:32=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Currently, the txwm interrupt pending status is only updated when the
> asynchronous transmit handler runs. This can cause the txwm interrupt
> state to become unsynchronized between the SiFive UART and the
> interrupt controller.
>
> For example, when a txwm interrupt is raised, the corresponding APLIC
> pending bit is also set. However, if software later enqueues additional
> characters into the TX FIFO exceeding the transmit watermark, the
> APLIC pending bit may remain set because the txwm interrupt pending
> status is not updated at enqueue time.
>
> This issue has been observed on resource-constrained machines, where
> Linux reports spurious IRQ errors. In these cases, the asynchronous
> transmit handler is unable to drain the TX FIFO quickly enough to update
> the txwm pending status before software reads the ip register, which
> derives the txwm pending state directly from the actual number of
> characters in the TX FIFO.
>
> This commit fixes the issue by updating the txwm interrupt pending
> status immediately after enqueuing data into the TX FIFO, ensuring that
> the interrupt pending status between the SiFive UART and the interrupt
> controller remains synchronized.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index 3ce6a4ee76a..ae71a15a2a4 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -124,12 +124,20 @@ static void sifive_uart_trigger_tx_fifo(SiFiveUARTS=
tate *s)
>  static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t =
*buf,
>                                        int size)
>  {
> +    uint32_t txcnt =3D SIFIVE_UART_GET_TXCNT(s->txctrl);
> +    bool update_irq =3D false;
> +
>      if (size > fifo8_num_free(&s->tx_fifo)) {
>          size =3D fifo8_num_free(&s->tx_fifo);
>          qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n=
");
>      }
>
>      if (size > 0) {
> +        if (fifo8_num_used(&s->tx_fifo) < txcnt &&
> +            (fifo8_num_used(&s->tx_fifo) + size) >=3D txcnt) {
> +            update_irq =3D true;
> +        }
> +
>          fifo8_push_all(&s->tx_fifo, buf, size);
>      }
>
> @@ -137,6 +145,14 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTStat=
e *s, const uint8_t *buf,
>          s->txfifo |=3D SIFIVE_UART_TXFIFO_FULL;
>      }
>
> +    /*
> +     * Update txwm interrupt pending status when the number of entries
> +     * in the transmit FIFO crosses or reaches the watermark.
> +     */
> +    if (update_irq) {
> +        sifive_uart_update_irq(s);
> +    }
> +
>      sifive_uart_trigger_tx_fifo(s);
>  }
>
> --
> 2.43.0
>
>

