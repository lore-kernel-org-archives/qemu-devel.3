Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09FCC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQdf-0002FN-LO; Thu, 16 Jan 2025 09:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tYQdd-0002Eh-TH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:14:25 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tYQdc-0003qg-3C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:14:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso1599800a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737036862; x=1737641662; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G5dLEsE6a910Nin+b2qYS2OLOG+LROAH/M4+LTy/tHc=;
 b=HOnMgLgVAeG0SZEHkyHXSnpSU0gNW87lh3BIvLo8b34iOQ9iu8Po79byAdutpoIfOU
 lNI9OXq8VepzvS4CgZr6XLTeYE2qmQD8hlAiRvAnmzFROVt42HZNs5iv5extxS6NZMfY
 SM2EVQ39mGxy6EtaZ4u7hjjAXLhUNXsk5MHmsSF0caX6t3lBsNyrsvyL1Uim8/kXb05Q
 ERrRFa/4ATRMKic2kwTgTh/CJpGYl7yon+nGRt7ERT30ujyZxU73/p6mkPI40qLx/Ffk
 b4pe3rCbCibOSxmqjfEHeHvkT6QcYO9RVJ2thjVR+Kvg8D4QoRSrXTsCT1LDHTmd8Sv3
 h1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737036862; x=1737641662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5dLEsE6a910Nin+b2qYS2OLOG+LROAH/M4+LTy/tHc=;
 b=VnUlpgyEzP+3Cvt0NAMjJPwes+qvS6yE76Kj8yQmRfa2cYtf6/wfm/5Ray5jtePBPb
 1aDJ9E1cAG32znH218cIMU14aoRc1+5qa+8T7nXMhL7rF5aCPnCe6lVQB5WWbgWIsiCT
 7yY+0Z5tUfpVsrHvNQIoOqqiL4wym7xV3AdxsLdOsHv9jGkvOm6qgPaAuGF3LOinUxo+
 kPcLXlajTIKm5xexL5PzL0Hy0Byz5sfirOQkhICx6uVyf5jHTWdgW97gbxpqFPkm+/Qn
 PVBCZbTCsDcXuZbFXp82X4nmmEfTMn2VIWf9HRK2tX7fWBqssyA3Kv5dXcu9vTubCYFr
 0sUQ==
X-Gm-Message-State: AOJu0YyaeoCN5GOq7uo0jntAz38puK07fdZ2VYNveTg4Vb52Rw8KReyG
 PQRh3yuZ/+m9QNDlyJ3Dj1PLtJgiuQQxfRydIYnt+oLxsUjbtUZJKszQF/yZ2BE=
X-Gm-Gg: ASbGncvfxZdo4DCvEDwrWNcHN+zJkGI/BDgR2yuX4VTvxdPqY2DCrYfUwDgtbgvI19R
 IbavMC0tE1iGR0fLxo0jXwbhBa+PL81IjStyV6imXENOslXhYGbUyAw5y/NuIS4N1XjLE9KwRcL
 Eu6o5rYCGUTbIGKjETo9zFYad2TQx2Pn7q06sU6R8bqqzJsAZWAr9NKghrKCjIClnpCZC+F0Gh3
 XRxmZ/Ay67cA9HoWHBNM3wv1iUO4ewcKlFWRAo/8glKnxBXMqnvd8S/1vkpDd4O8hSPyCHrP6Vc
 k/Jw+8CBqJn1gH8KV0FooQFf8+8zTWxoZXldRatv2w==
X-Google-Smtp-Source: AGHT+IE/FKLcP+pLxMqPbAkirIchKyESncUBxoruRo/z9rPIutDInIWE8XAYIdn+HLL9IdqZujMOAQ==
X-Received: by 2002:a05:6402:1ed5:b0:5da:d76:7b3f with SMTP id
 4fb4d7f45d1cf-5da0d767d22mr6423160a12.0.1737036862030; 
 Thu, 16 Jan 2025 06:14:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c355fsm9364562a12.49.2025.01.16.06.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 06:14:21 -0800 (PST)
Date: Thu, 16 Jan 2025 15:14:20 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, jason.chien@sifive.com, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 philmd@linaro.org
Subject: Re: [PATCH v2] hw/riscv/virt: Add serial alias in DTB
Message-ID: <20250116-8505c4ae89140866f42b15ee@orel>
References: <20250116133927.37227-1-vliaskovitis@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116133927.37227-1-vliaskovitis@suse.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x531.google.com
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

On Thu, Jan 16, 2025 at 02:39:27PM +0100, Vasilis Liaskovitis wrote:
> This patch adds an "aliases" node with a "serial0" entry for the

s/This patch adds/Add/

> single UART in the riscv64 virt machine.

s/riscv64/riscv/

> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2774
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>  hw/riscv/virt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2bc5a9dd98..fb1928cebf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -971,6 +971,7 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
>      }
>  
>      qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>  }
>  
>  static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
> @@ -1180,6 +1181,8 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
>      qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
>                       rng_seed, sizeof(rng_seed));
>  
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +
>      create_fdt_flash(s, memmap);
>      create_fdt_fw_cfg(s, memmap);
>      create_fdt_pmu(s);
> -- 
> 2.46.0
>

Only fix the minor commit message issues if you need to respin for other
reasons.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

