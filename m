Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8925FC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 07:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u38zz-0004Hw-78; Fri, 11 Apr 2025 03:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u38zw-0004Ee-RW
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:40:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u38zv-0001Rh-02
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:40:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2241053582dso23341295ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744357221; x=1744962021; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUMB+ZH5oDWFMhg6uQqjmGlXZQijyg8f7jJDwU1Bj0U=;
 b=T62mfjVZx2ZP8e3VrPAkGCmOlunaX0kllz/nxNNAWArHN16f6BqmaWgPJLVsY8Yy3S
 23xuqGCYEdpCt793PWj59wM0LPWBWAz6KR7zlNspfmQTIFG/4V5xz/xrLOlWCchT9YcL
 pz9SA5RE9LjjhdmhpyOOrD2aIwIw5V7QPSHmziLRzzTktdq102jXJacvFzyZun4C46zi
 cgdwFkvb1KW3MKtJ9QCcxxURlqz5lRJcBrs5vETGv/sEa9XhNwFI/Yq+ucosREpnvq/L
 uflUteAT1xplQ5efGFi5MPlYC6pFzs7bidOScG5waCm/FdqS8AStjQEbbyhSIZoL6idP
 qRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744357221; x=1744962021;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SUMB+ZH5oDWFMhg6uQqjmGlXZQijyg8f7jJDwU1Bj0U=;
 b=swaKkDZ9diEVxOjEXp2swLgjR44OoBrxsXSFx8DDw4/yvQA5Le+80fvYB5jvtYLQAc
 Bqp0DAjXxqktTYCkTVZPcjkk8oM/+lHALmGZ8KeOLptY4kYYftVYpqs3fX/r1FAlQj/9
 GW3ABVyGrNkK+tNIYL9ZkiM5aFwKsIddg1db2LbKn8A5iVLSZ5hXxKWNn0qm3zlVGIn+
 7iRcb1iWErPSKspoiTlbyv2waVUUj3zjihNawj2SYu6kk6bMkLFCz5MAzESCMaDgMBPe
 tjclvFkYP+aGfRROrN1DwZ99pDBYCWN7lCfM3lIMCqdCuzcfYa2hN5hNVjEDjkCPHkzb
 afxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb07FdeAnbNBQX/abWcuMQMN0jipFG4OdfVWaBhQoPJEGy4SNiKF0VB/EvMtDbylShYzidv20XuD+B@nongnu.org
X-Gm-Message-State: AOJu0YzePUUoaUJTK8FJcqPz1WAYk87MMXrjgK94F3hrethEr4L93gd4
 13E7dptjf8oBJVoi0gphqE18cKqtiUuzQOqg3EAEnv0Mv68DeVuGFaVBKQ==
X-Gm-Gg: ASbGnctvsobvs1rkRj2mIJJvMZqBwQTH/+mtOGK6LhDgH1h7G3rZL1tinwOIUWAjR9g
 robA05Q69qsfAM/T7ZOc40joXqj4rV9X89r5s4MCCxVL2l+qhlujca52CYdkRFDIxGNweHVW44Z
 wXKOfWKC0XH8yCYGg9clWTLMw11d9z+FXA+rPdQB3R0f62Sgpvn8ZVPixo46lt3OMBi2iUE9pmx
 /8td2xDbHSaa9obVXwn+3GYqCL1Ono90UnptwhtOaAEMLyD0l9jf2mFQ99EKw7EST/hM+xVzVkP
 78sjaAkoLl32+zIZMXXfJzIKh3G3i+vD4w==
X-Google-Smtp-Source: AGHT+IG5lzAzb+jmeRyHRfE0fDRpHo3PpweKkrIozYAUojtfVCk9J7sdvC3e3c8S7LvjPUz7beLUhA==
X-Received: by 2002:a17:903:1b08:b0:220:cb6c:2e30 with SMTP id
 d9443c01a7336-22bea50be25mr29380445ad.49.1744357221246; 
 Fri, 11 Apr 2025 00:40:21 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccb58asm42739125ad.231.2025.04.11.00.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 00:40:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 17:40:16 +1000
Message-Id: <D93N0YH6FKHH.3JBGQVVKLFXSY@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, <qemu-devel@nongnu.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Bernhard Beschow" <shentey@gmail.com>,
 "Guenter Roeck" <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] hw: usb: xhci: Add property to support writing
 ERSTBA in high-low order
X-Mailer: aerc 0.19.0
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <20250405140002.3537411-2-linux@roeck-us.net>
In-Reply-To: <20250405140002.3537411-2-linux@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun Apr 6, 2025 at 12:00 AM AEST, Guenter Roeck wrote:
> According to the XHCI specification, ERSTBA should be written in Low-High
> order. The Linux kernel writes the high word first. This results in an
> initialization failure.

This should probably be reworded, it's not so much that Linux does it,
this kind of implies a Linux bug. It is that the hardware requires it
and Linux works around such quirk.

  According to the XHCI specification, ERSTBA should be written in Low-High
  order, however some controllers have a quirk that requires the low
  word to be written last.

>
> The following information is found in the Linux kernel commit log.
>
> [Synopsys]- The host controller was design to support ERST setting
> during the RUN state. But since there is a limitation in controller
> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> It is supported when the ERSTBA is programmed in 64bit,
> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>
> [Synopsys]- The internal initialization of event ring fetches
> the "Event Ring Segment Table Entry" based on the indication of
> ERSTBA_LO written.

Could you include a reference to the commit in the normal form?

The following information is found in the changelog for Linux kernel
commit sha ("blah").

>
> Add property to support writing the high word first.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/usb/hcd-xhci.c | 8 +++++++-
>  hw/usb/hcd-xhci.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 64c3a23b9b..8c0ba569c8 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3107,10 +3107,15 @@ static void xhci_runtime_write(void *ptr, hwaddr =
reg,
>          } else {
>              intr->erstba_low =3D val & 0xffffffc0;
>          }
> +        if (xhci->erstba_hi_lo) {
> +            xhci_er_reset(xhci, v);
> +        }
>          break;
>      case 0x14: /* ERSTBA high */
>          intr->erstba_high =3D val;
> -        xhci_er_reset(xhci, v);
> +        if (!xhci->erstba_hi_lo) {
> +            xhci_er_reset(xhci, v);
> +        }
>          break;
>      case 0x18: /* ERDP low */
>          if (val & ERDP_EHB) {
> @@ -3636,6 +3641,7 @@ static const Property xhci_properties[] =3D {
>      DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
>      DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
>                       DeviceState *),
> +    DEFINE_PROP_BOOL("erstba-hi-lo", XHCIState, erstba_hi_lo, false),
>  };
> =20
>  static void xhci_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 9c3974f148..cf3f074261 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -189,6 +189,7 @@ typedef struct XHCIState {
>      uint32_t numports_3;
>      uint32_t numintrs;
>      uint32_t numslots;
> +    bool erstba_hi_lo;

Could you use the "quirk" prefix for the device and property name?

With those changes,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

With your patch, if the target does do a 64-bit write to the address,
what happens? I wonder if that's something the device is supposed to
cope with but doesn't work or just works by luck today... I would say
that's a separate problem though, if you can get Linux working okay
with this approach.

Thanks,
Nick

>      uint32_t flags;
>      uint32_t max_pstreams_mask;
>      void (*intr_update)(XHCIState *s, int n, bool enable);


