Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0570BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlUT-0006TQ-2f; Sun, 17 May 2026 20:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlUC-0006SV-Bi
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:05:35 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlU6-000344-V2
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:05:30 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso4156379a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779062724; cv=none;
 d=google.com; s=arc-20240605;
 b=QDJ3ArjoKkZ7ynG947PLCA+rScgaH2MkF2DbtONxXD0ACGoSQyUrMCZlO7zfpxyVv3
 v+Q8Jf/QX+xxoY33WyAJ2oL7kWtoSPry5zJr0TekOaK4p2Qyu36j1EOtyw2ne85YkqLB
 Wn1fEMR4qrpEJPRbK6oKgEevuixaboFltPV9ZzSGnocoestBvl5/QzdIi0lFh3iI54lK
 JPvOMaAtdW9Bwe8rVfF8+dSaA9UEOJSa7osSPtcadDkAhaS7GrYDduhl8QgwL3JIaVUS
 0ej7zE7MA3E1jcErJ8WfRr3xiVKEnHnR08sRTpmMEn1r6wYYBdC3MTX3tI0bUv3t0Lo5
 GglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kudALb8CfM7RD//r77QAgGduABr7gcgOIUW3f+y996Q=;
 fh=xUPK3WmcXSXmYUNRz6cyBi7fUwKP4bpURxe/wNyWmQo=;
 b=OUKTxjxWbJ9X8/3oeAPYyDMHYbbkqb+B5FV48QLhZWfB/9LYE+YDTznio/0mhhAM2v
 hwWTGguFGRy8aK1K0dxNJ+UAemM7j67EsNR/SYfFsA/NQDElzrM43YximAk3yTDrzuTb
 c3EjIvcs29UH/4jG3T+4S1a6v3e8eKZJAuDU6/oZAvVXRgbDn0Zft8byAhllIw6vDmE4
 x/FBVlvprOKT1VwYnhnzxwbx1K8AC7qt0OzOibHS16YL+mDvt8wksWFAWpLRHt+KKOe5
 ltHpTNZ3n8MJiqkMfTxGXUeTUzpLRAaKRMjBJMASFk3QnXlWGEKt/Ev0oYg4orIlXaCl
 n0jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779062724; x=1779667524; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kudALb8CfM7RD//r77QAgGduABr7gcgOIUW3f+y996Q=;
 b=DC/KdzKUS9MpvoYXKMGT7EbZnHfA2tuc+PHXsQni5lUPtW2D4VasHuGkc/rgebLt4e
 IxnC6DiJVHR+psu8wKYb0o8/HDhj2v6K0iegQ59m2Mu5s/oK1FxAEoZ6Ee86oosXCz6/
 jGgHQPeevIWniXR4t7IjrvgE5Rva7m06eUNLNKJYWrytPlJUBjPB7AiY4VNambCx+J7S
 jSXTKfGFJ2CxV0aF1GmWC+ju60rOqJIXTsnhlGQorcy57/Iw/W27Js6Ryu4ieA7fR3nK
 idfnlG5lgOeJkSc8/8TKKh2VyfDC13mB0WTCGHGOg/CXbqNo+XXGn4lUCUtLlwiaTxNJ
 qU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062724; x=1779667524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kudALb8CfM7RD//r77QAgGduABr7gcgOIUW3f+y996Q=;
 b=SDSAUMerDIDpPwfr7vPieogvJXH1Ud+C3GzydzfzQ9sei88iElEw+ly9CxlOuX2QF/
 rdvYnoef5WF4DELH5xBCOi/oa0llqdclJtO2pkZ8csL+oWdqCHyjU9l4njEpHiXmapOx
 qTGLlkn5P+VHnTCrwtUuZbi1vcpqXX26/YfVJ4jiFMXN4ufALQVwjR7jj/k3ZOBDVSmi
 nwFjzDSvqg7rEVHUUyogkLKSil4ZBtgj3+oF3L236DLuxBrH5xNHaAZcSrj4oyN6b0YQ
 AOWniXItdGI45YeNWj+F2X8Md4wQupp0uWJ+rSxh7Vr1RLlZfry4rD5VVKRTQaxXiMrw
 FZXg==
X-Gm-Message-State: AOJu0Yy5DsewbXlaqNpjnezLSVGhFN+2oAUfxU0mO2z7KtSfJayb4jzL
 oRPruYWRnThSVP2Ujm0mW0/t0bnQZqbMgUGR/o3qtxMY8IcA60x+0SvVvNaCazSeVLJ/tj6jnbB
 Asg8kQPZnBm/4Ok/wCWNyav/0nl0aVrc=
X-Gm-Gg: Acq92OEeRuKoosQhGAaWv3Oji3rGpABd9WczG3zMMNpbaI2jzPSYKTDq6456VlztITO
 mleDhAKF1ix3yNWpxf8gFJ2O3OPo3tWzScRImrqFFFWFNyiIVDtQo+uVTt62IcHWtL2dond9kjK
 MMI28WS5KsHFTPXuixQ0TOUR3j9B6/Iu/EL8U/Wk1QOIL0WHgM/t/R7EamVvY+kDz7rPTqwDrJz
 KYT/DTbXgcr36GOV0sAvnzH76wyaK/IE3R35IQkAYCwEA7FKJQJLg8wgWEsAWkf/uWynl76Uh3l
 0pQsHY7/OudyNjBd433mSfG/O+jtqD2T7N83wg==
X-Received: by 2002:a17:907:84a:b0:bd5:18e2:4c5 with SMTP id
 a640c23a62f3a-bd518e20645mr661353066b.47.1779062723331; Sun, 17 May 2026
 17:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260513030503.3665414-1-frank.chang@sifive.com>
In-Reply-To: <20260513030503.3665414-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:04:56 +1000
X-Gm-Features: AVHnY4IGZeigxqKSB-math3WU0WMla3K52KTMWUA6Lr2bvmkBT9RIgh4wyCi49E
Message-ID: <CAKmqyKN2RfQ3LKh=n4f=Nio=XejwAv5Pyrm5Vjf7cxKJdq-vaQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char: Check interrupt after txctrl register is written
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, May 13, 2026 at 1:06=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> It's possible that the transmit watermark level (txctrl.txcnt) is
> updated when the user writes to txctrl register, which may decrease the
> transmit watermark level to less than the number of entries in the
> transmit FIFO. In such a case, the interrupt should be raised so we need =
to
> call sifive_uart_update_irq() to check and update interrupt when txctrl
> register is written. Otherwise, the interrupt will have to be delayed
> until next TX FIFO transmission is processed.
>
> Suggested-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/sifive_uart.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index b4de662d616..b9bbaaef595 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -213,6 +213,7 @@ sifive_uart_write(void *opaque, hwaddr addr,
>          if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo))=
 {
>              sifive_uart_trigger_tx_fifo(s);
>          }
> +        sifive_uart_update_irq(s);
>          return;
>      case SIFIVE_UART_RXCTRL:
>          s->rxctrl =3D val64;
> --
> 2.43.0
>
>

