Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67934CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1uh-0000U7-JF; Wed, 29 Oct 2025 04:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1uf-0000Tr-Hq
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:52:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1uc-0001j3-JM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:52:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so28207285e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727925; x=1762332725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haA3cr8PysJy9OkOpiy/+jFZ3ciPbePpeknDrP6kx9Y=;
 b=S317rcHOiMpJm5WryRTSAuHb3Y0Uex0MdCf5MPUHWmVw8wJdfKi4uIemgcIUUuT9vA
 GIBX8gKVKxrGdyMJt12vJ2Z051msCN/9a3zMrBVVhe3mkVtppkdFwm6LoRmUY1mwLQut
 4OQth6SZtMzoZE5CVk3+YuwYt76y+qSRHZZ30JZ4yLOSd7mcJr5snq1BDWoZp+K2cOrO
 UUplzQKiDwBeZYgYEXiBkdY/3pnyZu8pkjKcY+UFwNrDIwpOoN0qU/P0lbtKnTFc4EaN
 6TWojwWhvpDQFP163yvpqyiiU6gKipkrytJLFHZgC/EH4RvBGz6RUiE0mEPvJzWflML9
 4y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727925; x=1762332725;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haA3cr8PysJy9OkOpiy/+jFZ3ciPbePpeknDrP6kx9Y=;
 b=Ia4+E6f8JxaD4T6ARILcXNaya+gSEEnNVOPRxphi/ux03lA3N8a5HKPS29GsA20dWi
 cyumLwMc+eCLuAl/XBuDmkC9IRoVEl/fX5K68MGWNqzqJr6nMJKbnrnYqAqUEeu9Y1ZK
 GdqtjAdooamBUGJSu5J6l0lAFzdgGop4u2cP4AXqAoqC6krGX6ep10x+HR686IyYIeSG
 B79FhFccECOhYTFdlGfx3ZqH7WqJ0X3UEysPReCm5Ejpj913CjHG5od6rZg2RSVmQ72D
 FLKeQIfMZpZU7aHSw9NS0B3XoCCp6o8zsVpaqo8+bJgJo/GXwYfOtBYEBJ0zv8BMFb8+
 qL2w==
X-Gm-Message-State: AOJu0YwMqjdOWxZPrdM5ZoViCOPXksNAg565eyRclM4QBg0mraA0Xl1G
 w362IWS3w/f8meRY0r795307FCUfHxYG0dIRQwVL3HOwI5YEQacE/wBVj1dmowhSGVyMzwVrK4F
 b8mw6ods=
X-Gm-Gg: ASbGnct4itpuLGUrE5+lbyb0N7THC8aoANnFW33uMPAkK+nTS5k3E9D2Qj80sAxM3TE
 COZkgRdhL9Fkgfc2LU6DDGf6oevsm1sGXYvTdJV2llMiNK9FYOuQxykvB0GlKKDqIyT+LvOeug4
 hBQyqQ9UrBCbXDjTWQqFFnvZGgrQTe/yUAioWgVB/ZCZbTjcV2NFpP0sQAcvupJy6fjwTgoYjaO
 mioyiEh7DpxeyGI6gfRbm93qQ6oZN/NG9UhVcRcfEDrIvURYnZkwJIKDlWl1AIJrRl10032nubr
 kYqX1LaOYvGdf6nwA6tPGoQD5RtnCNS6ihCY1JUTimK4TTxhorLBRA7uvzK5E5XpldQulwCiBu7
 HYXdMX5/ljQckeQvXBWFC0ApEwqxcuv7px7jf5DomOIYHqPiqIXEIFuOF0PeYNehLWWxSp8hYya
 tkOLz9GRRK8EFL3gO+
X-Google-Smtp-Source: AGHT+IGNzI8OGPgVgEvc8SpVBs64IgfUAOjlWWop0qfCKH6TjmI8XvMxIkpDzXm/c/XB4eKXFD7zJw==
X-Received: by 2002:a05:600c:4707:b0:475:dd04:128a with SMTP id
 5b1f17b1804b1-4771e1e10b2mr18153375e9.31.1761727924598; 
 Wed, 29 Oct 2025 01:52:04 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3aae1fsm35339935e9.12.2025.10.29.01.52.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:52:04 -0700 (PDT)
Message-ID: <bb7eb8e2-9089-4708-bf93-52afc3243b2e@linaro.org>
Date: Wed, 29 Oct 2025 09:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/25] hw/sysbus: Use memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/sysbus.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

The patch description is incomplete for these changes, but the changes themselves are good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index d33be6b2b52..414b3f806d1 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -257,13 +257,14 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp)
>   static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
>   {
>       SysBusDevice *s = SYS_BUS_DEVICE(dev);
> -    hwaddr size;
> -    int i;
>   
> -    for (i = 0; i < s->num_mmio; i++) {
> -        size = memory_region_size(s->mmio[i].memory);
> -        monitor_printf(mon, "%*smmio " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
> -                       indent, "", s->mmio[i].addr, size);
> +    for (int i = 0; i < s->num_mmio; i++) {
> +        MemoryRegion *mr = sysbus_mmio_get_region(s, i);
> +        hwaddr addr = memory_region_get_address(mr);
> +        uint64_t size = memory_region_size(mr);
> +
> +        monitor_printf(mon, "%*smmio " HWADDR_FMT_plx "/%016" PRIx64 "\n",
> +                       indent, "", addr, size);
>       }
>   }
>   
> @@ -282,8 +283,10 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
>           }
>       }
>       if (s->num_mmio) {
> +        MemoryRegion *mr = sysbus_mmio_get_region(s, 0);
> +
>           return g_strdup_printf("%s@" HWADDR_FMT_plx, qdev_fw_name(dev),
> -                               s->mmio[0].addr);
> +                               memory_region_get_address(mr));
>       }
>       if (s->num_pio) {
>           return g_strdup_printf("%s@i%04x", qdev_fw_name(dev), s->pio[0]);


