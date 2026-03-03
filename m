Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E96EDEBE1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxU8X-0002BF-QE; Tue, 03 Mar 2026 13:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxU8I-0002AG-GC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:06:12 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxU8F-0000jU-HL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:06:10 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-94dddb3c3f0so1568389241.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772561166; x=1773165966; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9NqhcRpBvzqJTxvlOFYo1l0wkVjO6CCfkHMhTiQEQI=;
 b=DlCgUr9FqjL/g/3ZNatXGVaYFEuaqFsrNcMhcKaEc/528XkzgfmPSJjx2hO5ifvUEd
 arMMj4pw4phbxJ8pgf3eaDYWCTYuLP6rdrKf+FaUwIAChhElseEiZ+udhj0I6G0z/R+I
 759f7/PNQRfKcXdaRJMhURROW7lKLacfQVIOtM5JGFv/1GOsk5QDC/bMSWtGoolqo2K2
 B9nBA+ub17tJyXfAt+nOaFmLU+xMrncu2l1VwmFmtY/LaOt/O9J0/OCf1SbOl+CzoFW0
 p+NmWvNXLU/1L8+rIjsoucZrk7gVxK0tcVIUnxBwTSU2TvQyvWZqVsZilQmuAoJKZQa6
 L5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561166; x=1773165966;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9NqhcRpBvzqJTxvlOFYo1l0wkVjO6CCfkHMhTiQEQI=;
 b=iBER1RRmi7LonuKhS8yMvJ5uNXiGVYjJgG4aAEtgUvNACRZf/3qw0dLqDEC7dXj/1A
 L30Rxx5UIVG1k3eDKgf30CdSsi/7lO7unGfALzNs5oUkmruo329+1yeAi2jDO+YWB52d
 HaVcpr3VWDl8RHpijdufsBi/yOj8QPsvS0rE5631U1uW/4SQ/SdVXNZmITLFErUgfd0N
 Lhr558MdIpNVOss0Z4h/t11VrxTZgY04AlOGJLpDeE7ACZnKMhDP74M4ZT1eNcAJRMMV
 taF1NmD8+ObwofQWluEy2DflX1FCc3mA/6nKew54RLQPTk9xAaf5DdQROihwTcqCbfdT
 9pnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCkm2/MFQiq3bp46i548L6SFML3TZ/zncAhbMmOdOKzwkALhE2u54zzfXddfWoVAPBen+PdVLpvWof@nongnu.org
X-Gm-Message-State: AOJu0YxqZ6yVm6SQYi4y269k4AL4ec+dUWCgRL2w/38blY7IfVM1v4kZ
 iz28vZ7D/nAOz950TZkEgLcp8/gqEAPunf1leMSuAGKjN/L91KQdiX56
X-Gm-Gg: ATEYQzy2eRxD17bLAM1EZkVmOu7IOrhW2w3zG7aW0Cf6MXSeHq0jpg0iMXq114RJaJa
 nq9MJqimMAKdd0YWZNch1YNIV2O2b9XQ+3I+Tsam0WgoZm04GdvkHSMXGcRxhZGn4W4YvOGbWjc
 2kXP2fLmGKtR2ZyhVVlr1vlnzuXDs1OAdGhR/aNa9ZWIiJL1NZjYfbQPxUksIO/OmCqWzLX9IeD
 zSQ8TUFOYXvY8Qh2Xqp2hNX3TMSfX85qrj3YscfwXRUIwC+aTChmRXRk3EjOZxC7Uh4YrI/qzYl
 ldOU1CAyzME8uWIpBrwiWaC8QUAFfeP29APz42LY7dn0Q/OiTUiFyL7dB2kAjahLs0a1SZt5Q3c
 r2Buuj8jUBNhDRzkvIpEvZmmI3ZwRmFtTxjyyguiCKiukNZAww1iRJWO0ccbtJkXydNrupmR9fX
 nPo2z87ghjGrFQiIoUg7YRl37lw7HVXawpVJNTc59nrJTnqsC3Ug6oMVvGSqDoY9VB4S3k
X-Received: by 2002:a05:6102:3e8a:b0:5dd:89af:459b with SMTP id
 ada2fe7eead31-5ff322c4256mr5771101137.7.1772561165701; 
 Tue, 03 Mar 2026 10:06:05 -0800 (PST)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ff1ea15925sm18571467137.8.2026.03.03.10.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:06:04 -0800 (PST)
Date: Tue, 3 Mar 2026 19:06:02 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH] hw/net/xilinx_ethlite: Check for oversized TX packets
Message-ID: <aacjCn2lfpvuEgZY@zapote>
References: <20260303172718.437015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303172718.437015-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2026-01-25)
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Mar 03, 2026 at 05:27:18PM +0000, Peter Maydell wrote:
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/net/trace-events     |  1 +
>  hw/net/xilinx_ethlite.c | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 23efa91d05..001a20b0e2 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -527,3 +527,4 @@ xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d f
>  # xilinx_ethlite.c
>  ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
>  ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
> +ethlite_pkt_tx_size_too_big(uint64_t size) "size:0x%" PRIx64
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index ba3acd4c77..75e6520569 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -162,9 +162,15 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
>          break;
>      case TX_CTRL:
>          if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
> -            qemu_send_packet(qemu_get_queue(s->nic),
> -                             txbuf_ptr(s, port_index),
> -                             s->port[port_index].reg.tx_len);
> +            uint32_t size = s->port[port_index].reg.tx_len;
> +
> +            if (size >= BUFSZ_MAX) {
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

