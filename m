Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19941C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESHn-00063r-JP; Mon, 12 May 2025 08:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESHk-000634-Eq
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:29:32 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESHi-0003Ix-5G
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:29:31 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7091d7244e8so40153477b3.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747052968; x=1747657768; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rc5aqZVJ1dbV+f/PX0aQe93seM+jTXytGDa2A2cI/oE=;
 b=n4/UzpSF5rPcOC4p2lELYtRuaBD1XvC4+Yrw6YpP2Dbae0Z0q1YkcDAoDXcH1baQha
 t/4v6O7fiUfVES5rNfM+j3KZX4P/hxWkWIvJTDGwbF22ZlnBLnI6sR8plnQeB1ULr/7t
 sVzfnR7z+PXntBEUq7H3npmHOC3EuFRLDtNnvoGcYC0R7PIvtb6K/KX36HK37pgJhqWc
 tSXRmGwcfGnqTu8nLQE/AwHxjn/7DOiqekMw+uC2FTyk2GW6WbwHXNG9IRDZeafBGpDF
 HD8iF3JYrxHs+fQar0hUtSaWrYD6SFXbG6IMMWhAL9W/lUXRSTEnZ00j/DCqAbuxq5qo
 Dq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747052968; x=1747657768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rc5aqZVJ1dbV+f/PX0aQe93seM+jTXytGDa2A2cI/oE=;
 b=vJQkgK+k4wN1cPVXzOvLpHh1Ae8IvSMfp71uV1rumQA/Zjp7W5PkGJzEOKmdyFGG9m
 FWi7nuFSOts8BsJXQ3KELJUm0myft1rO7Cgg8Gxs0w5vN1Z73Gi6K0RwNrbJsrW2QamF
 sX+D0t+qvn+76JCteZ/+ahqTkpwBFnIPOrR/yUqDg2NBNXt8ITkgElyqA9dlKsSQuklx
 KpyelxajFU/gY3SOoY/eQx1VqzM880g2yyEbutfeNG7wjcBomIl5QlNSx5EnLZ0Bz4Jo
 n/uQhZ9E7eHfsef6twFnhpGdYMFFHR1IpO7nyTijLZ0tBs7cnLE71PKZCPJZXUWiA4S2
 wVGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2WYUxrcQurqgDxTCW4zK1y14mCx8yC/dOqIyFlfOU95P7vB9FTpM4A6T5PmF1+f/VTs/9jlpaNFtF@nongnu.org
X-Gm-Message-State: AOJu0Yxhubm6uAB5ajzKo5A8A4nsNoSZS74Nn+d91ziURTWvxjar8d77
 bw6CrL4dQMQ0aoVdB61KB7cLq6ZTTnAjKOJ68Hqh1tTZVLQh8sTZNrR2tZmtDEgqFrme/bkeB7p
 BhX7FEG82Boq2xGjEzcYImmvkeG/tpJ/RgG8Fsg==
X-Gm-Gg: ASbGncu5kJkUP7VGeVnu00IUAAHz5c2FnX46pYZuGJIeeVN7CBvABFr5qv46Z+hzBvV
 q019RHL1cuYencKXpiLwv0pf070dH5Vz4h90ImXB4E8zfDMcFxk31p88DcCTQmHNHMsjXis1B1J
 iT+z1IsBxu50Qwf/6yf6tR0cZfnIsregHEyw==
X-Google-Smtp-Source: AGHT+IHu2pM4WLStbE15bdfn2Y2wcKQD2cbixPqldRTn8IH+5nPRgnf09h2wzCnIdGWpvzdVUYPk6G9V3uN4QvOVYsA=
X-Received: by 2002:a05:690c:650a:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-70a3fa44b87mr169775577b3.20.1747052967696; Mon, 12 May 2025
 05:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-3-npiggin@gmail.com>
In-Reply-To: <20250502033047.102465-3-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 13:29:16 +0100
X-Gm-Features: AX0GCFs6MTJIE_F7ixalF6zoGmFnsmVsVeryxhj8ss182Kny6hPUw6z72EI8gaI
Message-ID: <CAFEAcA9Pfk4Fg_VVJ3SYtXtpeH3+Bs+E1gwbFxiQAgKsXOdjzQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/22] hw/usb/xhci: Rename and move HCD register region
 constants to header
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 2 May 2025 at 04:34, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> This also adds some missing constants rather than open-coding
> offsets and sizes.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/usb/hcd-xhci.h | 16 ++++++++++++++++
>  hw/usb/hcd-xhci.c | 48 ++++++++++++++++++++++-------------------------
>  2 files changed, 38 insertions(+), 26 deletions(-)
>
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index ee364efd0ab..20059fcf66c 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -115,6 +115,22 @@ typedef enum TRBCCode {
>      CC_SPLIT_TRANSACTION_ERROR
>  } TRBCCode;
>
> +/* Register regions */
> +#define XHCI_REGS_LENGTH_CAP         0x40
> +#define XHCI_REGS_LENGTH_OPER        0x400

Old code defines LEN_OPER as
(0x400 + XHCI_PORT_PR_SZ * XHCI_MAXPORTS), not just 0x400.

If this is fixing a bug, please keep the bug fixes in
their own commits, not mixed in with renaming or moving
constant definitions.

> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index abd2002d2c0..c12b72cb9d8 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -46,22 +46,14 @@
>  #define COMMAND_LIMIT   256
>  #define TRANSFER_LIMIT  256
>
> -#define LEN_CAP         0x40
> -#define LEN_OPER        (0x400 + XHCI_PORT_PR_SZ * XHCI_MAXPORTS)
> -#define LEN_RUNTIME     ((XHCI_MAXINTRS + 1) * XHCI_INTR_IR_SZ)
> -#define LEN_DOORBELL    ((XHCI_MAXSLOTS + 1) * 0x20)



>      for (i = 0; i < xhci->numports; i++) {
>          XHCIPort *port = &xhci->ports[i];
> -        uint32_t offset = OFF_OPER + 0x400 + XHCI_PORT_PR_SZ * i;
> +        uint32_t offset = XHCI_REGS_OFFSET_PORT + XHCI_PORT_PR_SZ * i;

Old code uses OPER offset, new code is using PORT offset.


>          port->xhci = xhci;
>          memory_region_init_io(&port->mem, OBJECT(dev), &xhci_port_ops, port,
>                                port->name, XHCI_PORT_PR_SZ);
> --
> 2.47.1

thanks
-- PMM

