Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE76CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjrT-0004YV-D4; Wed, 20 May 2026 12:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPjrR-0004Y8-Tw
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:33:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPjrP-0004Ar-Mw
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:33:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so2033084f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779294810; x=1779899610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVgzQLWUSczJqkhziMmrUUsOjwRavGXj4utoM7mCPFE=;
 b=aXKqabPfQVnnwlAGzpn1/x4mLlm2x13Ion3W6/Fy7NaM6U0wXlYtoACm27f+Zlaq9U
 PsCZlWZj7cUbYfEhHrXfjVynJynSWhnm78mnjN5b/6dhj0Se14RJcF4/HulROFGpBunC
 znW+KkvmS3CzNA4kK13CziAuwWm1p+HjHcPepsvhNO5dlM07CE521cH7EJpd66/2fmey
 YTjmhM/1p7xTUuGNnDDvO2lP4XG7WSsRdJrVVP8YBh+PWt3pNAsGwV1D3fjnACNvgJy6
 PlfU8MhhF04kj0FtMzijXZXJ524tp0TQ1+vrvjoRhbot2Oi0pkSEkU1Ho2+OPbVXcdeK
 DCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294810; x=1779899610;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVgzQLWUSczJqkhziMmrUUsOjwRavGXj4utoM7mCPFE=;
 b=M+G2fs6N1GF+4rcP2BglMdMPo34/2sh1s8BKzGkGFSjcIZ2uC3ikkY5PwR2YNIStAb
 ZKDz7hNAqJcnTDzUYEnGlEa9bL73n3omWJYc0spXMofsnBsNeFjgkqJHLYBV9/Uk3k/8
 caC40kwqkpQ7L/3nBQTBdlNWReM6ghPDZE1chDCprG30FuPDVi18Vz4eDsQt3JD8AFcN
 QyW7kWTqUeF72DzKO8CPOteNePIQF27Q0oo3OnvnM9r6ZF2bFZNrm4JbFm4zk2r4d176
 7yxV1Xt6reY2gJCM0dJK5L/RItW0RmGPrx64obPRfcgpxVFIHnWiT/YK0LlwgxY+Bs1y
 WMjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xSJ4agOH2QjSRchv7nOuTq29oB5esFBSiOQoZDgTuigp9KuYYQzvt5QkreulY9nmjUGlFVVkDktik@nongnu.org
X-Gm-Message-State: AOJu0Yz0rWG8G4AzA5jBs0L0XTfPbt3NihLr4bWhRGT2fDHyDanNvXuP
 cLoq4EphOxIb3R8SZ+esVSxsM2O+QoEvgp0xXT8fDfKu7uCXnpDAtPNJdfOwTdBSXwc=
X-Gm-Gg: Acq92OFHCkX64FuqxeyP9AQBgClOKC9EVUbeUIJCDfUP9yht4C0+7JaNu9Gf3TqsgIY
 SjTeur/E5oYUHL/gbLwe7VZl09BLt4PZoqeqNb/AJWbcBHQ4oh52wK+w71j0zZd72E/zmbonQRT
 7L0GQ8U9rc9QLnX4jkUOOb8TP5e6KeaqBr9dDjAGB1FeAN7UC3DgaxhP2txbCoXvsRkTHyoPNnR
 S4QtFGphIE1B+Y5pE6xjvypZSMD+l8f1Bg9x9DMOXkd9Fp00wCnJwH8km764DybMhzb5P9jjMVY
 ATflzDH3BKHoX630NoqNR/eZuXj5+2vfXpdt8ECAemGiZHhddvqxdKg7qyZO/PlPbpOaWOihwsE
 b+DUddI7WR1hK6y/fsa7onTV2x8bPwAyyrku8Vn/iiCsd7Fl5BeGQXZBmX1R7UCK4PGhAGRDtXC
 4vO9Uamykq7nzauM3if1mOErCU+0Z4HYS9voMsrOFLxY2we0s6pEf77DO3itsu+wG0qz6DhZuut
 ODikzF38w==
X-Received: by 2002:a05:6000:2087:b0:43d:a37f:8d5c with SMTP id
 ffacd0b85a97d-45e5c367850mr39458483f8f.17.1779294809530; 
 Wed, 20 May 2026 09:33:29 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a178adsm58431129f8f.18.2026.05.20.09.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 09:33:28 -0700 (PDT)
Message-ID: <574480d1-49db-4ee9-981c-580d4c2db3b1@linaro.org>
Date: Wed, 20 May 2026 18:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 39/63] hw/display: Add i.MX6UL LCDIF device model
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260427124738.966578-1-peter.maydell@linaro.org>
 <20260427124738.966578-40-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Yucai Liu <1486344514@qq.com>
In-Reply-To: <20260427124738.966578-40-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Yucai,

On 27/4/26 14:47, Peter Maydell wrote:
> From: Yucai Liu <1486344514@qq.com>
> 
> Implement a basic i.MX6UL LCDIF controller model with MMIO registers,
> frame-done interrupt behavior, and framebuffer-backed display updates
> for RGB565 and XRGB8888 input formats.
> 
> Place the LCDIF device under hw/display and build it via a dedicated
> CONFIG_IMX6UL_LCDIF symbol. Model register fields with
> registerfields.h helpers and provide migration support via vmstate.
> 
> Signed-off-by: Yucai Liu <1486344514@qq.com>
> Message-id: 20260412110240.93116-2-yangyanglan718@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                       |   2 +
>   hw/display/Kconfig                |   4 +
>   hw/display/imx6ul_lcdif.c         | 453 ++++++++++++++++++++++++++++++
>   hw/display/meson.build            |   1 +
>   include/hw/display/imx6ul_lcdif.h |  37 +++
>   5 files changed, 497 insertions(+)
>   create mode 100644 hw/display/imx6ul_lcdif.c
>   create mode 100644 include/hw/display/imx6ul_lcdif.h

> diff --git a/hw/display/imx6ul_lcdif.c b/hw/display/imx6ul_lcdif.c


> +static void imx6ul_lcdif_reset(DeviceState *dev)
> +{
> +    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    s->regs[IMX6UL_LCDIF_REG_CTRL1] = LCDIF_RESET_CTRL1;
> +    s->fb_base = 0;
> +    s->src_width = 0;
> +    s->rows = 0;
> +    s->src_bpp = 0;
> +    s->invalidate = true;
> +    timer_del(s->frame_timer);
> +    imx6ul_lcdif_update_irq(s);
> +}

> +static void imx6ul_lcdif_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = imx6ul_lcdif_realize;
> +    dc->unrealize = imx6ul_lcdif_unrealize;
> +    dc->vmsd = &vmstate_imx6ul_lcdif;
> +    device_class_set_legacy_reset(dc, imx6ul_lcdif_reset);

Please do not use the legacy API. See for example this commit
to convert to the newer API:
https://gitlab.com/qemu-project/qemu/-/commit/ce788d3740f

> +    dc->desc = "i.MX6UL LCDIF";
> +}

