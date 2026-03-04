Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74761EDEBF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 00:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxZrN-00082a-Q5; Tue, 03 Mar 2026 19:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxZrL-00082K-Jo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 19:13:03 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxZrI-0007aO-PW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 19:13:03 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65f980cea07so9133161a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 16:13:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772583179; cv=none;
 d=google.com; s=arc-20240605;
 b=b3dWlNnkmAbr7rbZhiXsJuEfHqz2DgImAlH1Bvm/gzb1ERuE8m1BYfYZtfVnlwfXJb
 MCvniaEFPPDUvinG+bWwVq+rMNGfcNuc9kkDKCyrEb4mDXKYxPHm5QOPJV1bfbPmxkz0
 vmiDo6oppP65ewWK1Fa3MlqfGlaGUhmHFO7iOMDjisys02hGIku7V0m3nBvPR0gW9KAY
 uiNuvoz+nC3Px6nA7qfvZG1VVGqXImciuXNKgqjKI8QKHAf5pi9ts2zNukKjNDuJvFaN
 ErWG5XkugeEVsybP6UtgZu5LXwZrDLkEkkR/ZIXwU5/K4cmf8dOCgwdfQTs5IRRpqV9f
 pbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N3B7mOdFJr2uoi+HUat2oCaARVzoRK4Yg6coFkprYbc=;
 fh=vs0FEKFvkLszxoagLOegSdcICLH/wdkLYp1JQdQZTgE=;
 b=JX0ZJ3B0pRbz3Chjo2ftAyAwoS+L7VF1R+GsjxgCbPm0SS7H9WPAKzIxfdiSCtMN6B
 4GmmlIEj18i2SI/Pflp6j9JJvtCpmLi4Uqop4Ee9NqHhamZalvwBAlkybS9YdS04coNg
 K9jdrJae48FMB/mkW48AFXi0tLk1PycA7X13Qjfq4CdWPgvqpL0KUPN8vu6cTo5Ojukf
 nM/VWb2Qtd3nRVp+q0Gxwx2sXIyf0ll44QAZvrQh3CJssVOVTcigne0qErwkioKO1mPW
 GZ0CUfQm3lETJY42MpagYr2BrQg+kM9UZNXj0wjJwvzJCIx8kED2vKrMwdYEQYNb0RqQ
 7Vyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772583179; x=1773187979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3B7mOdFJr2uoi+HUat2oCaARVzoRK4Yg6coFkprYbc=;
 b=OD2+dZK9lS4ZydbL/Im5DPxiILxu1/QEuwrijJcLmSeE9rzjCOCA9b3akOisSe6mdf
 B6jZ7mtdWomA3p2nxSHmL3FGO+YnbKdwKclDUIe32+rlUi3iXjg1lAzCpldLyIPQySS7
 F10LuRi9F8ivDq8wAIVJgB06YQX4lx43vbZKg7+rDM2zJWNHbpxaQTzJJG18t20lCYx1
 NmXdHVzUsOIMZmCIeh7nn5TFOSLiDhgSvEd7fn2pMcR5/5ipFybuQlCqqUgLQLrtFgox
 gVbZHhg+HkbWWrsN8K0lW2Fxz5dnWZYZpEs32uEEpKeaEMMo2/osyFWTyiyoc06YWGeQ
 50oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772583179; x=1773187979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N3B7mOdFJr2uoi+HUat2oCaARVzoRK4Yg6coFkprYbc=;
 b=A+cWCQao+8Rrxu7AMXWeh9Fn9ZTfAB+EjS6WPgQMUiE3XdlwlhbvZCZFhNpY7e5ChH
 L4odmmvoOkyfUc4SORdNIrIpH4FmiUOqqE3QT2cp25JBYcm/gj1abc3TMUieTTMxmpzh
 XfSv+BRSmr5Dby+w0cNnymtN9lvHR47vaxFCFLeoJAHZ7SqpMQeibKX1ZgyT5qC0Y8vV
 DNwxqx3JElgz6NIy9G2mm6bMWIqNELkJklkbspDCXEDnCKB1fSH1YlRSSdHNsS9hnG1R
 PbTD2wtgv+VmOnodpum/zIjt/s9XoEYWvsyruRo1sKDqR0VbWneIzib6m4xM+CXIrvaH
 qQXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXnVRG9MxIvdwt1QQKCphoSjJ2bnNNYmzt2oJVjlARREx0nsgrfufCmlZ1TRlWL0mVG7gGxGWM4a2K@nongnu.org
X-Gm-Message-State: AOJu0YyUUqkPPNSa1Som7YKEirK3BApv0wkgF39k8b489YT4aI71Mx0B
 vGkgk88HikReqVJ0EzaVSpe0/KnawoEdjfmOwzhVaHVvyiMmE2TGwBzByoZB63d/GA6SW5UiANZ
 gFZ5Ls5p+zfJaiOL2pdAD7EIeQckHTgw=
X-Gm-Gg: ATEYQzzMX/B+XoAHkn086rexl2AUMwybxTEYUtmpsGq5rZHZDGVLlQ6whK9cIHCW5p3
 tZlkNSOe/iD7dD7GKCN5YV6uureLZVt9eVPai+o9sUylrVnahkGr8zcBOVdXAfckPo8/VpABJuX
 Y2YiMb90M5mH4awX9UNNuK5CB7AmXmvmiT3sdXeiKQLErooO/3w3kTQ1BFvisvDXtOKK5S6o2Sc
 HwslXgE7/9pKMMZ7sTfmXensqlwZk41LwT0ibuvjw5sREsa27El9rr4ZE/j8GBEHNdXPbUCrw+C
 HVOhe2FWDaZ0fZOfgcOl3HjvnDJ/fgdjK3oe+g==
X-Received: by 2002:a17:906:4fd3:b0:b87:39d:2bb4 with SMTP id
 a640c23a62f3a-b93765c7448mr1256511866b.59.1772583178342; Tue, 03 Mar 2026
 16:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20260303172718.437015-1-peter.maydell@linaro.org>
In-Reply-To: <20260303172718.437015-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Mar 2026 10:12:31 +1000
X-Gm-Features: AaiRm52txa99YVFzDkQpkcVktZH1QDd9HYCLNlPsLCVfplLNduzG22mTqN9cFok
Message-ID: <CAKmqyKN3G_b0+gVo9HyRjYRs70RVdZ97i_6gzskudpdWbnPUbQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/xilinx_ethlite: Check for oversized TX packets
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, Mar 4, 2026 at 3:29=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> The xilinx_ethlite network device wasn't checking that the TX packet
> size set by the guest was within the size of its dual port RAM, with
> the effect that the guest could get it to read off the end of the RAM
> block.
>
> Check the length.  There is no provision in this very simple device
> for reporting errors, so as with various RX errors we just report via
> tracepoint.
>
> This lack of length check has been present since the device was first
> introduced, though the code implementing the tx path has changed
> somewhat since then.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3317
> Fixes: b43848a1005ce ("xilinx: Add ethlite emulation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/trace-events     |  1 +
>  hw/net/xilinx_ethlite.c | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 23efa91d05..001a20b0e2 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -527,3 +527,4 @@ xen_netdev_rx(int dev, int idx, int status, int flags=
) "vif%u idx %d status %d f
>  # xilinx_ethlite.c
>  ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
>  ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
> +ethlite_pkt_tx_size_too_big(uint64_t size) "size:0x%" PRIx64
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index ba3acd4c77..75e6520569 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -162,9 +162,15 @@ static void port_tx_write(void *opaque, hwaddr addr,=
 uint64_t value,
>          break;
>      case TX_CTRL:
>          if ((value & (CTRL_P | CTRL_S)) =3D=3D CTRL_S) {
> -            qemu_send_packet(qemu_get_queue(s->nic),
> -                             txbuf_ptr(s, port_index),
> -                             s->port[port_index].reg.tx_len);
> +            uint32_t size =3D s->port[port_index].reg.tx_len;
> +
> +            if (size >=3D BUFSZ_MAX) {
> +                trace_ethlite_pkt_tx_size_too_big(size);
> +            } else {
> +                qemu_send_packet(qemu_get_queue(s->nic),
> +                                 txbuf_ptr(s, port_index),
> +                                 size);
> +            }
>              if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
>                  eth_pulse_irq(s);
>              }
> --
> 2.43.0
>
>

