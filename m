Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30A3D462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFHy-0007wD-1Y; Wed, 13 Nov 2024 10:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFHt-0007rq-J1; Wed, 13 Nov 2024 10:28:09 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFHs-0007dz-2g; Wed, 13 Nov 2024 10:28:09 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539fe02c386so805659e87.0; 
 Wed, 13 Nov 2024 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511686; x=1732116486; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cW7Z+hSX7tjlqggj2j1/duDIEGUcr5dU9iH7GQHVG1M=;
 b=OVHgBK5Xv68j7GsMorCCaM/AAy82Qnw2qTAlvrlzb8oT35rm51yj4kVdkEB0Oqz5Eq
 ppa0CLQr6PRw+HyObe/JJCJXS5nRVQvJ4imjK2F4EP/+WRu/lZHkv8noXcksDcWXYw4m
 l7IutlHL13y9k7KDR/7eOnt2n/heehV/2iHElS8+MlP5dv8wLdfk7QaBskwNQ+SG9dVb
 mYF/9jEvn025OyonxUUFAobdEChQumuMN9YX+/baUOdmZ3BUGpHpVUUcx1NBOuFRmZMZ
 Sz9ri3Vohh5pabTlxTZ9FEPlkncAOJrSZ97QYO+HbJv+W7TrsHo9rGnoBjONFt019agy
 qumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511686; x=1732116486;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cW7Z+hSX7tjlqggj2j1/duDIEGUcr5dU9iH7GQHVG1M=;
 b=C5LVejjrM32FERk9O7gb8xYymwAqtSr+PBdovRhLOVMexUztDfQ7gRw5rDZlnJlyVb
 xIgDSpIiH/PRzk4fNbCkckvJMYw4SCTWhvrEZMAeBvbK8z7AQAzyEVzxJ0rUNFNGMJ++
 Etc8+sueFhHazu5tyOaZfzqFcygxeH323GLE14Ze9jCX9Pq0MHWIykHVU3JPMu68LKUf
 MTx4MS4Q0QQ03K2RPUCx9fbh1L7DwQ8fzdyPylUo+D7GmE+fFZuCE5eeepbWhQPnwaOk
 tDv1n7GYsfy+G3pjuPOfZ4At++YEK/ldIQ32YQhEvAAdQy7StOkgBr8xGa2zDak4FHPQ
 Ozng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJNY+lHhS0OlOQqD22fotKQZTe9TgsFT+6p7kopGQyi6BJQkya7fGnlTjjChYkuD9QVdgpRcOYqw==@nongnu.org
X-Gm-Message-State: AOJu0YwrDVQh0u+u57e+WfhjO81FBa/5xV15jE4JVehXf9HNKxnww6x0
 Yg/IbOovcq8jSkXf6bqqAfA1usCeFtIypgyLiVerRIWzMJexfEL0
X-Google-Smtp-Source: AGHT+IG6LlhzE8Qz1xQH+K2urjpPw5KW/iCEd3ZbM2IsuE0p5T63pVol+Nd4bjuT0IUp/PW/xsO0zw==
X-Received: by 2002:a05:6512:3b99:b0:539:fc1b:36d1 with SMTP id
 2adb3069b0e04-53d85ed3b42mr7451519e87.6.1731511685692; 
 Wed, 13 Nov 2024 07:28:05 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826a9d9dsm2175032e87.205.2024.11.13.07.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:28:04 -0800 (PST)
Date: Wed, 13 Nov 2024 16:28:04 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 12/20] hw/net/xilinx_ethlite: Access TX_GIE register for
 each port
Message-ID: <ZzTFhKeCVK4GMx7n@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-13-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
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

On Tue, Nov 12, 2024 at 07:10:36PM +0100, Philippe Mathieu-Daudé wrote:
> Rather than accessing the registers within the mixed RAM/MMIO
> region as indexed register, declare a per-port TX_GIE. This
> will help to map the RAM as RAM (keeping MMIO as MMIO) in few
> commits.
> 
> Previous s->regs[R_TX_GIE0] and s->regs[R_TX_GIE1] are now
> unused. Not a concern, this array will soon disappear.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 605451a522..4cb4781e70 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -62,6 +62,8 @@
>  typedef struct XlnxXpsEthLitePort
>  {
>      struct {
> +        uint32_t tx_gie;
> +
>          uint32_t rx_ctrl;
>      } reg;
>  } XlnxXpsEthLitePort;
> @@ -90,7 +92,7 @@ struct XlnxXpsEthLite
>  static inline void eth_pulse_irq(XlnxXpsEthLite *s)
>  {
>      /* Only the first gie reg is active.  */
> -    if (s->regs[R_TX_GIE0] & GIE_GIE) {
> +    if (s->port[0].reg.tx_gie & GIE_GIE) {
>          qemu_irq_pulse(s->irq);
>      }
>  }
> @@ -126,6 +128,9 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>      switch (addr)
>      {
>          case R_TX_GIE0:
> +            r = s->port[port_index].reg.tx_gie;
> +            break;
> +
>          case R_TX_LEN0:
>          case R_TX_LEN1:
>          case R_TX_CTRL1:
> @@ -189,10 +194,13 @@ eth_write(void *opaque, hwaddr addr,
>  
>          case R_TX_LEN0:
>          case R_TX_LEN1:
> -        case R_TX_GIE0:
>              s->regs[addr] = value;
>              break;
>  
> +        case R_TX_GIE0:
> +            s->port[port_index].reg.tx_gie = value;
> +            break;
> +
>          default:
>              s->regs[addr] = tswap32(value);
>              break;
> -- 
> 2.45.2
> 

