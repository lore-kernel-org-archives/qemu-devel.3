Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9B710706E7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 16:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Rim-0004Cd-73; Sat, 14 Mar 2026 12:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rij-0004BX-Lu
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:20:10 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w1Rii-0007es-4F
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 12:20:09 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso1609152c88.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773505207; x=1774110007; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iQ0rmR2989IpUXTFB5a9gIe9AeBEcBjnxW2q7WB7/Vs=;
 b=MHvQN0Q9QlRDseRB08rHf7/t0VXrz/jQms1qcgDp+bn5rLCKE6LPl6JExki8Q9siRb
 9o2/P+zB8VM9zPW664e/KpHehfkr9h0rxPMUnqzg8H0qI4koICwS5aBFeTCm0pcakaB2
 7w0kZg1nMxhyRjJVEuGtkFmbC/7J/1kH8uW64HYr7V0ZlPLTzLa9ABjm7k/gLv9yzfDS
 Gb/dFj+2f5hkd+R2bZSO/ITN1pDLioqr7HVoewq9xI0d4VlouMVxlQ8+RXOGoJhcaIkQ
 dxTGmCI4xD+bkWyjLnZzlZWFu3swdIfUuhnUqhNzhWcHcy52xNi0C5pRFgZ+s6voS2Cj
 5zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773505207; x=1774110007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQ0rmR2989IpUXTFB5a9gIe9AeBEcBjnxW2q7WB7/Vs=;
 b=oF4lNBVNYHTEuhU+6owjy2Zy+LbF22QgVy92DaXODwtfjFTXUM3/zw6mqipy4DL18N
 pn9ANgsQGb7kHUDqWFXjRZz1wXgIJf3LPV8WgyIPoCravh6CkQaztzsMlpBcAc0eKstf
 pbfurGHn94AwMEmZD+dioZ0DpIWos7rExKZJsl+25Z0+vDcC23xqIrAExoer4qtBzBBX
 5VRli2jIMdrb2kgc8vvvPDQ40G2z9fFach7OzxQlzcFuQ9rMa0zpcNsEmEyH8kO5DSSW
 +nE4Oixqvf2Sab3DFJofFvrZVi8QOqfjHd2H47JTrvszj9G79tYd/y4WA7e/yCfqW1pt
 +CwQ==
X-Gm-Message-State: AOJu0YyAsWQwn/t2TnKFK+jR+IAtl2ewMSY2SiJM0bt/5Jj8223h5cPA
 NB8q7TJvWPsLx782sTASONIet5ZF5hLAkMC2Y0J7AhDCBieLZ/4CcpXS
X-Gm-Gg: ATEYQzzrRLrCB55GfI1ZYfydRaSOxSB3AakC4nK/re4/RQv9amOqjGcpnZsdw110w9q
 5sMQ+P7iwxK7ZVPjQmudAReDwDsAE8cMwdyzwGgojZtejc6kVuv2CLQ5flLjlIMPyGzyNwuFzmD
 jCgxHTrHqhqBIS7Ycutod8DiP0rouyAPotrRtUVPZeGq6XDyG6NUd87WFBMZV/kaSvPqKhtDpjd
 csPBXgNY0ODf8V6LbL1sg9BZzxZIqWc0FcrozIbZSyq9VzKkuz4+MI1J526WKXkrOtiynWZgrFl
 E+/lmO4ugo+0ZgRne8GN3XAzHack2RhapK9Lq69uchjg4DxHcAEpTdKruUot39d8A+KMZp3AM4o
 DpUAf1PzMBOwy8uRN8oIsSYH+i73CwEdU1jxiduSPtyqJkeaFGmYGzMb66y75IUDk7m+SLSNO5K
 mXVRgQQXGClNe1rIoI9G+aM6KSsKCFwDNIKgXjxDo0ah8Hfu84GjzTOaKsKfGBp4pjzBQV/xX6z
 2+Rh538jVKFIz0R3KWls0W82or6vTo=
X-Received: by 2002:a05:7022:4a1:b0:128:bb45:35b2 with SMTP id
 a92af1059eb24-128f3d24df3mr3840773c88.12.1773505206568; 
 Sat, 14 Mar 2026 09:20:06 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f6295ebfsm6085540c88.4.2026.03.14.09.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 09:20:06 -0700 (PDT)
Date: Sun, 15 Mar 2026 00:20:03 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3 4/4] hw/char: sifive_uart: Remove ip variable
Message-ID: <abWKo_dU_7PxecZ7@ZEVORN-PC.localdomain>
References: <20260312033201.1619554-1-frank.chang@sifive.com>
 <20260312033201.1619554-5-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312033201.1619554-5-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Mar 12, 2026 at 11:32:01AM +0800, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> The ip variable is no longer used in the code. Remove it from the
> codebase.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  hw/char/sifive_uart.c         | 6 ++----
>  include/hw/char/sifive_uart.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index f255cca960d..4c30fbf5685 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -285,7 +285,6 @@ static void sifive_uart_reset_enter(Object *obj, ResetType type)
>  
>      s->txfifo = 0;
>      s->ie = 0;
> -    s->ip = 0;
>      s->txctrl = 0;
>      s->rxctrl = 0;
>      s->div = 0;
> @@ -343,14 +342,13 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
>  
>  static const VMStateDescription vmstate_sifive_uart = {
>      .name = TYPE_SIFIVE_UART,
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
>                              SIFIVE_UART_RX_FIFO_SIZE),
>          VMSTATE_UINT8(rx_fifo_len, SiFiveUARTState),
>          VMSTATE_UINT32(ie, SiFiveUARTState),
> -        VMSTATE_UINT32(ip, SiFiveUARTState),
>          VMSTATE_UINT32(txctrl, SiFiveUARTState),
>          VMSTATE_UINT32(rxctrl, SiFiveUARTState),
>          VMSTATE_UINT32(div, SiFiveUARTState),
> diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
> index c78d9bd1fc6..5f3b1327de0 100644
> --- a/include/hw/char/sifive_uart.h
> +++ b/include/hw/char/sifive_uart.h
> @@ -73,7 +73,6 @@ struct SiFiveUARTState {
>  
>      uint32_t txfifo;
>      uint32_t ie;
> -    uint32_t ip;
>      uint32_t txctrl;
>      uint32_t rxctrl;
>      uint32_t div;
> -- 
> 2.43.0
> 
> 

