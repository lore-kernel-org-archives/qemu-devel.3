Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094071048924
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 01:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw8jb-0002W2-G5; Fri, 27 Feb 2026 20:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vw8jZ-0002VP-9r
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 20:03:05 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vw8jX-0001e1-Lz
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 20:03:05 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so2112180eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 17:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772240581; x=1772845381; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XCPBggat46ICwzgzQGDkliN5ntQA2Z7Z0M0Tun4P7Nk=;
 b=P7Uf/AJDGmksEiROc4idMXH7uiqJdKKXhnvTmyZgEPpkGFmZv0TurFg36ccSxqXfA/
 RoWDkZ7Xwm4BnFRtSh4kYe+SKE7XCcuwA0rQZUyPRxhMLXS8SYRl57OjcQiwOM5wJrH+
 fKcUU5KsMTxLBoR/wzwr3TCOvqU8hxF2iFpHSGktwMJrztyqmNUVgHaC13fgueItxGNP
 esMrwOfgDM0BmOD8TK/zyF+At92oUOxHIbLSrXZH/+0MixgkZgGwvNKU4p8tjHPI2GiO
 YK2PPfRKBouc/QSyQDfSUI4+KlTs79HGJ+iD635PNDaeKKVkAuEmtqY6HEN5BJOKJ7eY
 czAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772240581; x=1772845381;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XCPBggat46ICwzgzQGDkliN5ntQA2Z7Z0M0Tun4P7Nk=;
 b=M3Pf4h2f12mlmu7bi+KqunKVLjNJO2FveeW+nACRKAFS9pR+/y3XC82k5NnQ9yE56C
 ttPEzppSB7UP7n5LGHEjco9x4ksRr7bfMIkUW7KAeOJJO5PXMSbq6H5urBbMbeJZFikf
 HHWt8hd96ZZdw9Y+N5LoKsrXgdE0P8krNNM7bW8boH0K7BjEsIGOWJQpIWTlw/01Y1Gf
 HkE0fJR6Vd0vPSYMp5j1M7wwU0fOwlO15O1370Lks80s80DU0geTmTE/Ps5FgQqOCUEY
 eDnNeTpnSll4wBGMoot+a9E9efUfITuIaioYR345VOJ60D3gFX9owBopTNfyZW6X4adN
 UXEg==
X-Gm-Message-State: AOJu0YwSCTJXqgtAhAbe9Dfo9Dsr9PgiMJzwgb5rHNyUYpZBCrfuzrIQ
 W6RUTNnWVv2z9hPPbAUR1yE5gUGWk679g7WWoOTnNCY9AbozQB1cNz5v
X-Gm-Gg: ATEYQzwKQr4VBSVUzQmDLC43RUquKBCn9bpfnSlJ6Tf6RUwM4VP+HSbSebm7EcCF5W5
 vxT9MoHwj7SCN937LhJXI/kABBRirFf857ZH1RsfuG/xWMt456O7YVjSFKuveO2jJTfNH6FfCC3
 HUMvE8eevW44VT1nWDuf2t+kYSxDcHkc2TJDRxOz78yohvu+uEHVqKK/0slKa0SNfzpFwya0dSR
 1zJK7QoekTLD7fPjnw656QvWUbP3hzK43VpQnJOQsCSdfwj2vtMHM92jrxsI3QJFqSoC+voVZpI
 8qObS1TnQtrCv6c2huChXjyf21I/xLDRdmxfnihYlU7kIpXg0cSAFofklm+et+EmY3IilJNz4Nc
 5xDYPntPpyGmKcP4HGojGQ5H6tOiVCY0GQDAjvhyeOxYJvYqs1kXMkYGB9IOvrA2baj1e3Uugd8
 QBceLfajnGMav/wr73J5L1Ya9kOEQY4i7U70MkFuhV+huZOFHZxYhhMakwCAkNcpxoBPQ39w+Bp
 Ckn0knBG+//jO6IyyrR05Zj1OHOqCI=
X-Received: by 2002:a05:7300:640b:b0:2b7:32fe:4bbb with SMTP id
 5a478bee46e88-2bde1baf2a6mr1745066eec.11.1772240581141; 
 Fri, 27 Feb 2026 17:03:01 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bded67bd05sm1431860eec.1.2026.02.27.17.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 17:03:00 -0800 (PST)
Date: Sat, 28 Feb 2026 09:02:53 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Conor Dooley <conor@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, 
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] hw/riscv: Remove deprecated 'riscv, delegate'
 device-tree property
Message-ID: <aaI-hhHznsDTqMnP@ZEVORN-PC.localdomain>
References: <20260227232838.23392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227232838.23392-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
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

On Sat, Feb 28, 2026 at 12:28:37AM +0100, Philippe Mathieu-Daudé wrote:
> The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> the AIA APLIC support.  The property changed name during the
> review process in Linux and the correct name ended up being
> "riscv,delegation". The incorrect name was added as alias, and
> deprecated in v9.1 (commit 38facfa8432), so can be removed for
> v11.0.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
> Binary file pc-bios/opensbi-riscv32-generic-fw_dynamic.bin matches
> Binary file pc-bios/opensbi-riscv64-generic-fw_dynamic.bin matches
> ---
>  docs/about/deprecated.rst       | 11 -----------
>  docs/about/removed-features.rst | 11 +++++++++++
>  hw/riscv/virt.c                 |  9 ---------
>  3 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1d5c4f3707c..cc5502e5394 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -494,17 +494,6 @@ versions, aliases will point to newer CPU model versions
>  depending on the machine type, so management software must
>  resolve CPU model aliases before starting a virtual machine.
>  
> -RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> -the AIA APLIC support.  The property changed name during the review
> -process in Linux and the correct name ended up being
> -"riscv,delegation".  Changing the DT property name will break all
> -available firmwares that are using the current (wrong) name.  The
> -property is kept as is in 9.1, together with "riscv,delegation", to
> -give more time for firmware developers to change their code.
> -
>  x86 "isapc" board use of modern x86 CPUs (since 10.2)
>  '''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 41bec8b8e38..0a62e87ee35 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1232,6 +1232,17 @@ converting to using TCG plugins they should contact the qemu-devel
>  mailing list.
>  
>  
> +Firmware, ACPI, Device Tree
> +---------------------------
> +
> +RISC-V "virt" board "riscv,delegate" DT property (removed in 11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> +the AIA APLIC support.  The property changed name during the review
> +process in Linux and the correct name ended up being "riscv,delegation".
> +
> +
>  System emulator devices
>  -----------------------
>  
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bbce2fb6671..a1c323e66df 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -666,15 +666,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
>          qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
>                                 aplic_child_phandle, 0x1,
>                                 VIRT_IRQCHIP_NUM_SOURCES);
> -        /*
> -         * DEPRECATED_9.1: Compat property kept temporarily
> -         * to allow old firmwares to work with AIA. Do *not*
> -         * use 'riscv,delegate' in new code: use
> -         * 'riscv,delegation' instead.
> -         */
> -        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> -                               aplic_child_phandle, 0x1,
> -                               VIRT_IRQCHIP_NUM_SOURCES);
>      }
>  
>      riscv_socket_fdt_write_id(ms, aplic_name, socket);
> -- 
> 2.52.0
> 
> 

