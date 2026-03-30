Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EC51061B20
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7KNO-00044Y-Nk; Mon, 30 Mar 2026 17:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7KNN-00044L-LC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:42:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7KNM-0007kl-44
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:42:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fe655187so65048245e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774906942; x=1775511742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zCVneCbJODfdck4Im0qpnSJfY8H8uZI6wtgYAqDGvZg=;
 b=k7Ng75TLWSQ/XmMWrrl44Ry4L3zm6SjK+Z/K+e2UdEFcvFKZHhUuMc4McHNEMvZspf
 BZ02GCtJiqQoFz3Lbr76DQWoGjpU38y4jD9t1nfvb7u4oVaLkGqEX0XcVousYvA3aEms
 Eg23dsuFpftihH34TDQbHDDING8KyIJPz40g21S3Fw/+yIpfmdvntJCgbI6HX2hP9aEF
 9vNWA9MIm79rFk4utbZzDJjyPMCeM62u2kVpAANwATEox7T7g+6VSA9CgIw/I8yIOjUs
 yXBKcbizimVEPRNry3Y90l1QoUgnkU1c7UiOyHhP7ziftGz9Bqj7+3MJJkQWU554+rzU
 A5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774906942; x=1775511742;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zCVneCbJODfdck4Im0qpnSJfY8H8uZI6wtgYAqDGvZg=;
 b=h5eyMmenELZkOa2tWVx3Bj95AJrIZ30jmDqA80n842L2ThpJIqc4cTMUOHpyKtqUmt
 62YXBZ+B0Yh9qMRTw5vj27mXTAPgGYQ1BAqSzcBPvggP2OIzB0TI76ToxKsVS1t3xsXe
 XoV3qgQ2HuahWOezAozNs6Ap0sWxMtvIj81TgZMK6HOnFUVp1/SWhAOKCGvH4QvKqLhC
 ZLM2X3p3nk00LnR+eB298HBKtdS8VfOpkIdSP5yut8OBKRh3360z3VWJk7GOBfOgV/Wy
 sdl/GY4IFswCRXeJWDd4c9yYpd9JLXoJk1NyB6cqRGPq/Tva9ZqLwGpoK0wR0Iq0Xcw+
 5GLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbmnDoMt90+9o+wHr0f8/XYfFZr9XpWRUggNeI6/oryFweVzDD7HCLK/y00eMLy8lAeWCIsQpx+AHj@nongnu.org
X-Gm-Message-State: AOJu0YyFlmi9Ktxlw2E1oSEzHP2qHuUhtZ6hYI/uScSJ4ZfMM5uD6xJD
 F8pXoHpgqi72zFsbr/78atAoLOwRcEsoAorkPfSoa0pkNM8daES+Jw3bFexT1lHsLEY=
X-Gm-Gg: ATEYQzyKbPe2K6/XOUWV7S+IcBn2RKp0q5o7pUWBSDytIEL6gMatc3CUZ4tv1Zsnw/R
 nNv8776RWKomKYe7olm8qsY0yNMrGE7G55W/OnR9+L6uGpYYdEdT8Wc7kqkT8rUgCkklbWT7NTe
 lC/amCIXTb53rZiP1Mq9bwXeT/d5pC8zHYkCgRnpDcEqFLs2Qm0b/iWMrBeYB+pOWklRsEoqa9N
 Bv+PsnZO1TOphI57yfg9ypN51Hi8Kh8KAgqK63FLZ+r4zpUTiAZIlI9WxadceucDM0klMSpigo3
 mS+31fiIlmlFhUJ3apMZXT24LvTXPKnzQlwf1Xgi34GDqIhmekPvPzyaygtacS8836jdB4eaOcH
 J3kNLBZr/d++4l61veq5UX3LYE5zWI6PN2gg5S8AQwB7zyw+W/hN4p8rkC2EqFAvyyeB5DgJNus
 qnOGZyJj0QuF9rk5bC7gLM5Fd3k2xr4n6EE7DOSIvw5vGX/K+uB+ouwsTeLFMBlAWR9PeHxJw=
X-Received: by 2002:a05:600c:4e15:b0:485:2ce2:4c87 with SMTP id
 5b1f17b1804b1-48727d45881mr242541315e9.4.1774906942264; 
 Mon, 30 Mar 2026 14:42:22 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e3602sm22449308f8f.4.2026.03.30.14.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 14:42:21 -0700 (PDT)
Message-ID: <04942b9e-ed2f-4553-b4c7-73d5499f342a@linaro.org>
Date: Mon, 30 Mar 2026 23:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/hppa: Disable Artist graphics card on 64-bit
 machines
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-3-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330211859.19317-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/3/26 23:18, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The original Artist graphics used the GSC bus, was often installed in old
> 32-bit machines (e.g. 715) and can not be used on 64-bit machines.
> This is why this patch makes the artist driver dependend on the Lasi chip,
> which was never used in a 64-bit machine.
> 
> Note that there exists a variant of Artist for the PCI-bus (Visualize-EG PCI).
> It has quite some differences in the registers, and would require that we write
> a PCI ROM for it, so that Linux and HP-UX would be able to use it.
> 
> Instead, for now, users can simply use a standard VGA or ATI PCI graphics card
> on Linux.  This can be enabled on the command line with "-device ati-vga" or
> "-device VGA".  If the "-nographic" option is omitted, a PCI OCHI controller
> with USB keyboard and USB mouse will be added automatically.
> 
> This fixes graphics support on 64-bit hppa machines and allows us to boot up a
> 64-bit Linux installation with VGA graphics.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 3663bac53b..58e76bee2e 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -384,7 +384,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       SysBusDevice *s;
>   
>       /* Graphics setup. */
> -    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
> +    if (lasi_dev && machine->enable_graphics &&
> +        vga_interface_type != VGA_NONE) {

Pre-existing, 'lasi_dev' being a static variable isn't really helpful.

Back to this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Although a distinct descriptive boolean variable could be used
instead for clarity, rather than testing LASI presence.

