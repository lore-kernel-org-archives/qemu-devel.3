Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9432D106FD60
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0rUx-0002cG-5Y; Thu, 12 Mar 2026 21:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rUv-0002bT-4k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:39:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0rUs-0003FK-J5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:39:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6615c766e60so2730520a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 18:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773365964; cv=none;
 d=google.com; s=arc-20240605;
 b=OZWkot1ZFYCHfB5ldsRJywOMRhqsBEcDHqoj7NKXvlLfk+AEPZK00tDRt2tqFfQ4gF
 h1FZL4RZ0ZvgZzMTRfbnQWnJQnfuIhzhZkP5FEvDjzn5dOcyhcnWDfq84+S7bvTM79IO
 0w7sj+/3j6ILzYfxlGfmpONlucbfG6okxq6vBWqnvhod+npz+s7048GgRXAQyOUy4TD4
 uloguOCx9zn5JboYAMbkrVwUGVe9h+BoXZIJmjLdM7rx/24hjnXHu3tNtCGwOYR2Rc3N
 RRCDGRoYHV5h3aQXdPo/1CsarWm0IKdAEkvIY7dVjgIxxuDX2ZiVXy5CjU5fIV6BDgdh
 1AwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=heaBMqikCXeZA5G0X3TCPhmAO3+68gdGwwDepmeWnBg=;
 fh=Yugyz5SJJub7nbOEKVoR++9O2Yndc4n+VrwAcNFbVYM=;
 b=d2XvSOe/cYmi25gM0T4RvkoAjAbcdItPYtxK9nPiFKMt2HXXmkLKgsLWQrqNgQP/ut
 yI23H+yXTnLRZ8+Ps0c8qV0ClAlmVda5bkZi+bQFdG1HRw/d6TRZ5nEquWsndQOKi94+
 AMDZK0YGG1gFKgW4M+jU2hl1nunGoQ2sSnNC8beBah3/1/8sOgpQAnj3lv4cUrRS/6kE
 8uJZDjHVX5CNjgx6DjyW72mS3DFbgKonsPEFTP7cybtSFoUl3pcB/6d2hFKZFgt6eKCA
 1ORuUcL68ppxungYhlhoUAeJN/Nu3OEWUVNS/A5e33p7MU7h1Zge2BgCxdBweFOpCASJ
 Bqkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773365964; x=1773970764; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heaBMqikCXeZA5G0X3TCPhmAO3+68gdGwwDepmeWnBg=;
 b=Nx+0oYCshgL7nuAjTgd6+b8iyhs8xBRkI2bwFxtyZtFQgXPDBmpQjZUXzxfG3qXk8v
 DVjVy0oew2BcyPt8o5K9yFbRiT0zIv0RiNZ3Vpfk+DqXk+9kn89nEpVhsHYwgiRv6aBR
 x3fN3FoO/u2t2cfIiJgflHJtfN0+ncegi0aPnuKdBebe85p4xggPHT/0MxQRChtox4Mf
 whqLi+0ZvbJH3NQHYXFmyVRErJcjkRfcNzWR6iUNtjMraCdq4VE+QMvhNKVLkMxarNLl
 2uT7ubReFUxiQe7VXR96YHdfHjgE98FnrJsxcoK1Rcp9zgQcp4gMNc4PrNQy6o/NWQrU
 VTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773365964; x=1773970764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=heaBMqikCXeZA5G0X3TCPhmAO3+68gdGwwDepmeWnBg=;
 b=lpN599iZzTL+mzkHkU5cKjsTXTLx50zRQyOIzOcC+i/qdjaDevF8taf61olZ3M30tY
 Zerh+vISh22vVz1y0AwheGzO0hIEzqrWfDDKh3/2uiT/tUPGszUz3Wp1uvPxJxSUsKYx
 rtnN0WXOIZ59vPody8SHL1tub9di8F01viZyYRwC6Ay9/aRxDeORRGAVdUSJOZLceNM+
 bTS+AJ/2QawAkWiNrY159Mq8SW7gzR3TJVIBfuqRCP+zax9IiIM0PrZa4eREtiMa9sGd
 q+iR36TzQL+gxIgs4OHNukSwEaNHm5Wy3Q3ksxGhinzjIJEfoZx43bXJDTBhpASkz2nq
 YwOg==
X-Gm-Message-State: AOJu0YzoF+A2CE4RNrju0QoMNJp9Zrz3si0qb0xkXOgMnx0/7YhyIHPS
 PFAuA5BOh3AHoLfMLbq6OYL0MFv+MdDSbcHCTqlHuyY0EkiE4z3IesMWU8SyjE6V5g14V45Uug7
 A47uvbiN4B/BN50IL9YZ+ChTiVt3JfNo=
X-Gm-Gg: ATEYQzwSkWzCB1jkGSjoKrDIyrHzdX11+4xbAJLMMtnRmzHpsZNY71caOZvG8cwtCmZ
 pRsHOLCGzK1Tx4AcfUJO9ysA06tMapn6GwWRq+KMz6cMIuqhO9Y6PN4VsG4z8h0cyOiPC1m1jx3
 PaYA6L9bTiBx+AGziUUlJv058mJeuviAwMw42VzsmYhWiSULU+xxmOlg7rVcXbF2XuIgE3O9mL0
 H5Ui++A93QbA9pCVZK6im4xR+/gS8iQvXovh3yhf7gHKduw1vC8aSrBYVIcAcH4EMOZ5g2z/ruE
 JfpbFvmBXRCLCt0ucyc6an/XBlm2jW1NdJi/kg==
X-Received: by 2002:a50:9e64:0:b0:663:d74e:9253 with SMTP id
 4fb4d7f45d1cf-663d74e94femr266104a12.30.1773365964344; Thu, 12 Mar 2026
 18:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260312033201.1619554-1-frank.chang@sifive.com>
In-Reply-To: <20260312033201.1619554-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 11:38:58 +1000
X-Gm-Features: AaiRm52eVxVqeHlkiEaIj8fcfIcQ9X_Bqj92H4qS-mK4PIKLVOf_uenMbxxc0_w
Message-ID: <CAKmqyKMg_W5g9i_Kf99v8SagZL7xEKbVHP767GnCnXeAPjPS5g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix SiFive UART spurious IRQ issue and misc updates
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
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

On Thu, Mar 12, 2026 at 1:33=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
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
> Changelog:
>   v3:
>     * Rebase to the latest master branch.
>   v2:
>     * Include txctrl.txen and rxctrl.rxen.
>
> Frank Chang (4):
>   hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
>   hw/char: sifive_uart: Sync txwm interrupt pending status after TX FIFO
>     enqueue
>   hw/char: sifive_uart: Update IRQ when rxctrl is written
>   hw/char: sifive_uart: Remove ip variable

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/char/sifive_uart.c         | 46 ++++++++++++++++++++++++++++-------
>  include/hw/char/sifive_uart.h |  3 ++-
>  2 files changed, 39 insertions(+), 10 deletions(-)
>
> --
> 2.43.0
>
>

