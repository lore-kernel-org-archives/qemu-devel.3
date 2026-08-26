Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25B0C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzF0g-0003cr-7g; Wed, 26 Aug 2026 10:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzF0e-0003cF-BR
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:53:48 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzF0b-0008AT-Qo
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:53:48 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-836cb2fa1bcso15366497b3.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 07:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787756024; cv=none;
 d=google.com; s=arc-20260327;
 b=kAhlelJNWwb8IgNDbmJh6pzpK+BMo+E1NVyTyN4SVjqJpLGZP5pPAoYBkvrSMEDxnr
 45+nWC7oAF8tTTbVnsgFeGtgJ/Ya8hg0/CkPHPbj6WP1V4W0arBE2nPzFZgcBQO/3nyT
 BasxblImtoYsbG2DL31tJZch5Xf826+Tc9rRR/XmMaZpP59OQSBjTMW2E7/eEgZ9ciAY
 y/kjv4rhZ5f4edzKVdIN4slMGDfTe9gRHh4cfqp+b1KRV+xJqeQPawoSiYkE9r6u8KdM
 3Tgt59oRya4AP8lh9iCbpNgqxg/FA8lfmfrOdy6jjif4voqsDMdkUNEH5ojhmybJ6uUI
 i72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hc16r7tXsZNKAaOX2hV1JeHhZOQ74MMgxV1jAOkO/WA=;
 fh=4syABB0wR8Yj5BNn2XrxmjPiQY757nOVelF71OKeELE=;
 b=XnDlnife5MW+Qt9PsizVupZNyGFqxQt97ur/2C9DoQbhJPJH9VJ6oBV/qBe13+3rL1
 koy4MsQHODyPGvmQ3TuIZBbDPmfCdhA0nstYuIiiMNe86nPl5B/zzz0pxiIZiT7yhGD7
 76uYuwPw2jvNErM8srhRCbd3kQWZzVxkMRDHtjh5sK+rIBMpv1bXu+aEYo3rRRhu+aQB
 Qxtrj6FZ3ktge9Z3o7hL8f0DTlJQAES/bKO8wAAmrKmzqEE6k5GN8H0kF+VwiroQAcGy
 kgv0DQBkkpTYV96WRhUucP7eq96PxUl7fZiCqPYHDxrUHng98h3arTHKevgY158S0g5Z
 SWaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787756024; x=1788360824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hc16r7tXsZNKAaOX2hV1JeHhZOQ74MMgxV1jAOkO/WA=;
 b=B0ZbnTEX7jIYTJv57s2JU5CZhAv4q5EJ4fPdENQEq8P2jCsAX1O8xUG/TN8QXUPd/t
 oNwai7e1HaYz6pTHsSVKOwNSpB8C0zfHX0POo1jwdZiyWs97rRFkzUkSzkMvzwF+oxkJ
 VE5Pvg2Rk9aRknqb+ZWDGOTqcnF/j7jw6ipF0KkI1aHWrlDYSHI8A1/S1OqePExbC6r2
 4IrxTj8y/4gcyS833XPr7QXpPIAKy96UoLXOZDovdu+6tlMM2PPKnzJZwwTTW6jRmX19
 6bi3+jApldBeia6rHaJ+pDgs++m5ZL8odW4wMpx0uUYVbG94t1u3GpC7TJP8mICYqAch
 m0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787756024; x=1788360824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hc16r7tXsZNKAaOX2hV1JeHhZOQ74MMgxV1jAOkO/WA=;
 b=V1q+2pDB/LEkWhGR0MSL7xYG2pLxEgcpcQ2V2KyuWeyj0DDk3j/QfST48uy98i8UnW
 c5ThxxKMxEXwpjzfAS5dOcKgTRQB3ilLxENccocBx1W5uDHnERrZmQIHmOEsg6w8mmsL
 07JAwtyH9Uy3ASSBeHrWCQm7AvblTap8bRKkMj7/InKnIasP/wOU6x8HbGohT8IkROMP
 G/XbNShJbqqjfurwBOXTPSckRIujxJ+Huxnm7w4rt0awxxzCgiduEl9IMkTBNqe7X+qI
 SAQAS6mkiRSs/YbEjmedYNCeluckDCVZz2z6cKZOUe/DouWDbeJwokxkUhHHxz/i/CA6
 XOIA==
X-Gm-Message-State: AFuF++mtdmdyzRgpfPGwLGDcG6HofVXXO6c8bizUW5MaFtijqkB04GoV
 C3ggkFSeYcDlBfRXqgB6oc8nt6cQwAzALqpTImnxVk/iAH5sOZ6kVgE6j+sEypaF1WeDAY+3pte
 g+rK720/nwnj1tfcY0x4M+TSFQ6fY4XdEIe/0uMT4aw==
X-Gm-Gg: AR+sD113Q8KWmy5hc0nH5LPbzJl4iOUts5sLQ2jQK13hQVKQEKOnX4g9cVU7Nqmmpww
 0Kv3W7Eoa8Iypoxdn1GvRUcsi5Ty+rjrIgx7jLigsNbGTCN3hvW622/kS5QkTdFEBSC24j6/M3B
 YhSRUytxqBVWWAgorr3jqQxnTrYBsoAI3DYVX5vOl/ISbmN1jZ53H0lJ0G6cHxkE3gTNVAWkkoE
 zUbEj2KUkVhFXg8kAqQVQ5ajEFko7tGElsfaPQQvtLr+uAzzc7aWFJTTQbw0TVdSpyKkLNboVOc
 HCzXDtAo+XRBsgUvbVmU5XoOWPacI9pxcR1YaQ0ki3XZXHr1mmvbhDF265J5b4OZmoS8aFzNp8o
 =
X-Received: by 2002:a05:690c:5805:b0:80d:a249:4854 with SMTP id
 00721157ae682-857477a3fb3mr26241607b3.17.1787756023981; Wed, 26 Aug 2026
 07:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
 <20260825212326.1907-9-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260825212326.1907-9-daniel.barboza@oss.qualcomm.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 26 Aug 2026 09:53:32 -0500
X-Gm-Features: AcwNN1WhnBunGvND0aWLVyi0Wn_SoUe4nlBvtFW5I7tnt5C1Z6pOW_OzhdsXsdI
Message-ID: <CAEev2e8fbPt04kcKh5a+ohXYtWPzC5-cD58gcMFS-NV3QQKwSw@mail.gmail.com>
Subject: Re: [PATCH 08/13] hw/riscv/fdt-common, virt.c,
 tt_atlantis.c: add create_fdt_uart()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On Tue, Aug 25, 2026 at 4:24=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add a common uart FDT helper to be used by 'virt' and 'tt-atlantis'.
>
> To accomodate both boards the helper is doing the following:
> - an 'additional_reg_props' flag is used to control whether we want
>   'reg-shift' and 'reg-io-width' elements added.  OpenSBI won't boot
>   with the tt-atlantis board without them, but 'virt' can't deal with
>   them being added unconditionally either.
> - an 'is_serial0' flag is added to control whether we need to set
>   additional properties related to the first serial.  This is required
>   because the 'virt' board adds two uarts in the FDT.
>
> No FDT changes intended.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  hw/riscv/fdt-common.c         | 39 +++++++++++++++++++++++++++++++
>  hw/riscv/tt_atlantis.c        | 21 +----------------
>  hw/riscv/virt.c               | 44 +++++++----------------------------
>  include/hw/riscv/fdt-common.h |  4 ++++
>  4 files changed, 52 insertions(+), 56 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index f31cc9d3cc..b3f3af3762 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -791,3 +791,42 @@ void create_fdt_socket_aclint(void *fdt, ACLINTFdtPr=
ops *props,
>          g_free(name);
>      }
>  }
> +
> +void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
> +                     int uart_irq, int aia_type,
> +                     bool additional_reg_props, bool is_serial0,
> +                     uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name =3D NULL;
> +
> +    name =3D g_strdup_printf("/soc/serial@%"HWADDR_PRIx, uart_mem->base)=
;
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, uart_mem->base,
> +                                 2, uart_mem->size);
> +
> +    /*
> +     * The tt-atlantis board requires these extra props in the
> +     * DT, but adding them unconditionally will break OpenSBI
> +     * for 'virt'.
> +     */
> +    if (additional_reg_props) {
> +        qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
> +        qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
> +    }

I think the issue is that atlantis uses a uart that has 32 bit
register spacing (0x0, 0x4, 0x8, 0xc....) rather than 8 bit spacing
(0x0, 0x1, 0x2...). So rather than "additional_reg_props", would a
name like "word_addressing" or "32_bit_spacing" make sense?

Regards
Anirudh Srinivasan

