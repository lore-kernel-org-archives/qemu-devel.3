Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0D5C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Let-00021Z-VI; Fri, 25 Apr 2025 12:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8Lep-0001zD-HG; Fri, 25 Apr 2025 12:12:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8Lem-0001Pn-63; Fri, 25 Apr 2025 12:12:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso16721045e9.2; 
 Fri, 25 Apr 2025 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745597521; x=1746202321; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2yxYooqwSIKdZmqLMKmhuHuJKrRsfSGikBSIrzpd9kw=;
 b=IQzrv/cn0v1yXuHfhktynBwSjwYCAR2HU0jpd4OkzQbaJrgZA40+Wjb3OmeADXTgon
 d8r1Mh7xzWhg/cUCMAPYT4rHYxL1RxKEdu75/WMjfEL7QsqVvat5bkkbGAr18Ln1i0+V
 PGgqQTSXjukiKrEsElGGxyVOVKuVQdPoNGPX96JuLtX7NhYVr7RL4++65mgW8FvbaTyf
 uZpB98a5/al2K8xSiKILj0YPMb4WpnSIJ4rzlVn/cm3xO7Xvuj+DsrMMfguyT353r9UC
 mzFnCWvXvH/4sWlBn1SIRsgb2qwigUsjgUoyCzzHY7ZiuUaKm/at7arUl/eytP51D2cj
 vvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745597521; x=1746202321;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yxYooqwSIKdZmqLMKmhuHuJKrRsfSGikBSIrzpd9kw=;
 b=i1B08Ng9nMkNBbrNwndzTzJ/EGQPjN3QzuhXSblG/UD/YGortED3JJoHLbI2BUzVaP
 dNngC2ds8xShjw7FnTDYoOpEsCC79XapQNo5d65G3z62+p6ZTdDi+W13Dyp6OsNdspdF
 EMNDgs2XVgxcQBQfC56I1DEsp1m/Y7f9Ip9byc316iSCn8xE1zgQSKjDJjHLwiaYQiVN
 HU/cRy8rKfBeYzmjZ9svVLT2nJyCat2qWGUoxTDzFOh1w/HlRXfEuaTU8Z548v9QJmE2
 V3hrKyGagY5FA+umvuYed2FfYeqE8kXJaZexKDZh8bCRFP9/7vGlctijneAMPXn4VIVU
 utXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+uMKz019VbYLUEpJDvFTbG49sXzRDiWuTq+CemPAnQDcWtFpK3B4oSYT5Lih2+qgtI8ZYKNpREA==@nongnu.org
X-Gm-Message-State: AOJu0YyegtckmefVp0WmJqlSIrOgkarJkwYpmunWYV7ctYuXdUdMzaxs
 S28kC8o2elLvwlMEFWy69VKVtHXxKiWJVIMDIaeDcssXoUDU9Lhx
X-Gm-Gg: ASbGnctw1T4FmU9QOib8f9JsmtWdEk6G4bkkDPzqnTe0Z7LwcrdcG4PkHmXDzDJzgPD
 uokjOZPVrnfsUrk+Llfgbz1VYEtYvoq8Lssq4LdLb2bAmieOGw3dFfK0PmDEaN0dJ+RD4d/rm1g
 ueH+ZrsXzfwJgyU9ZoJKylOxp4h8PvApmx0gPSlQZ1XU6jOevOnt/XVfGLiYouF/f0bkPSque0d
 NZu5iEeXwYhjXfvJcGAMNo9uX0EP+KhTpnOIqgqrYkyHKEE2ShE9mW4xJyTjJebpXXxkCrBH6Kq
 uRq5AgcpeooEVjWcvOvbu+ATJPuoXlS0nDy5U5UtIwonhDPEf1YnUhwkBjTwWX5gh5zm+TaQLD9
 4AOHARbXQ1fGB
X-Google-Smtp-Source: AGHT+IHhHaVuI+XKc6SY2fR4C3WK4ye3FpEUMZyNtOEzzaIajO+D4J20anE5b59zPhCrxJQlpVC7mA==
X-Received: by 2002:a05:600c:314a:b0:43b:b756:f0a9 with SMTP id
 5b1f17b1804b1-440a65e41f5mr21240935e9.11.1745597520963; 
 Fri, 25 Apr 2025 09:12:00 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d60asm2838796f8f.18.2025.04.25.09.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:12:00 -0700 (PDT)
Date: Fri, 25 Apr 2025 18:11:59 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/21] hw/dma/zynq: Notify devcfg on FPGA reset via SLCR
 control
Message-ID: <aAu0T_XTt2uwermj@zapote>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
 <20250318130817.119636-6-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318130817.119636-6-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x332.google.com
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

On Tue, Mar 18, 2025 at 02:07:56PM +0100, Corvin Kˆhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> When the FPGA_RST_CTRL register in the SLCR (System Level Control
> Register) is written to, the devcfg (Device Configuration) should
> indicate the finished reset.
> 
> Problems occure when Loaders trigger a reset via SLCR and poll for
> the done flag in devcfg. Since the flag will never be set, this can
> result in an endless loop.
> 
> A callback function `slcr_reset_handler` is added to the
> `XlnxZynqDevcfg` structure. The `slcr_reset` function sets the
> `PCFG_DONE` flag when triggered by an FPGA reset in the SLCR.
> The SLCR write handler calls the `slcr_reset` function when the
> FPGA reset control register (`R_FPGA_RST_CTRL`) is written with
> the reset value.

Could you please refer to the specs where this is described?
I couldn't find it...



> 
> Signed-off-by: Yannick Voﬂen <y.vossen@beckhoff.com>
> ---
>  hw/dma/xlnx-zynq-devcfg.c         |  7 +++++++
>  hw/misc/zynq_slcr.c               | 16 ++++++++++++++++
>  include/hw/dma/xlnx-zynq-devcfg.h |  1 +
>  3 files changed, 24 insertions(+)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index 03b5280228..611a57b4d4 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -138,6 +138,11 @@ static void xlnx_zynq_devcfg_update_ixr(XlnxZynqDevcfg *s)
>      qemu_set_irq(s->irq, ~s->regs[R_INT_MASK] & s->regs[R_INT_STS]);
>  }
>  
> +static void slcr_reset (DeviceState *dev) {
> +    XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(dev);
> +    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
> +}
> +
>  static void xlnx_zynq_devcfg_reset(DeviceState *dev)
>  {
>      XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(dev);
> @@ -374,6 +379,8 @@ static void xlnx_zynq_devcfg_init(Object *obj)
>      XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(obj);
>      RegisterInfoArray *reg_array;
>  
> +    s->slcr_reset_handler = slcr_reset;
> +
>      sysbus_init_irq(sbd, &s->irq);
>  
>      memory_region_init(&s->iomem, obj, "devcfg", XLNX_ZYNQ_DEVCFG_R_MAX * 4);
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index a766bab182..9b3220f354 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -26,6 +26,7 @@
>  #include "qom/object.h"
>  #include "hw/qdev-properties.h"
>  #include "qapi/error.h"
> +#include "hw/dma/xlnx-zynq-devcfg.h"
>  
>  #ifndef ZYNQ_SLCR_ERR_DEBUG
>  #define ZYNQ_SLCR_ERR_DEBUG 0
> @@ -576,6 +577,21 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
>          zynq_slcr_compute_clocks(s);
>          zynq_slcr_propagate_clocks(s);
>          break;
> +    case R_FPGA_RST_CTRL:
> +        if (val == 0) {
> +            Object *devcfgObject =
> +                    object_resolve_type_unambiguous("xlnx.ps7-dev-cfg", NULL);
> +            if (!devcfgObject) {
> +                break;
> +            }
> +            DeviceState *devcfg = OBJECT_CHECK(DeviceState, devcfgObject,
> +                                               "xlnx.ps7-dev-cfg");
> +            XlnxZynqDevcfg *zynqdevcfg = XLNX_ZYNQ_DEVCFG(devcfg);
> +            if (zynqdevcfg) {
> +                zynqdevcfg->slcr_reset_handler(devcfg);
> +            }
> +        }
> +        break;
>      }
>  }
>  
> diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq-devcfg.h
> index 2ab054e598..f48a630c5a 100644
> --- a/include/hw/dma/xlnx-zynq-devcfg.h
> +++ b/include/hw/dma/xlnx-zynq-devcfg.h
> @@ -56,6 +56,7 @@ struct XlnxZynqDevcfg {
>      uint8_t dma_cmd_fifo_num;
>  
>      bool is_initialized;
> +    void (*slcr_reset_handler) (DeviceState *dev);
>  
>      uint32_t regs[XLNX_ZYNQ_DEVCFG_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQ_DEVCFG_R_MAX];
> -- 
> 2.49.0
> 

