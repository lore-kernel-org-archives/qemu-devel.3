Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F49C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7rpN-0001TQ-Db; Thu, 24 Apr 2025 04:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7rpK-0001Su-1b
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:20:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u7rpG-0001n8-T6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:20:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394a823036so6668765e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745482851; x=1746087651; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ytGDBpv1pt6SUN7d+5+FAkGcFAfGT6omdrFsqWjZC+U=;
 b=HO1Y8pUAuZIlefLu3lW1YJ+kwOnNtgBQyXkZJdwEOnlYmR6bZPp2HiWuq6/n/b9BtT
 KLYClBMiS48543gQrhM+wtLahm1GfO6ymMaM5NrG1qwPay+u5GvBaovfRggylwd4JAPf
 lR8uqzKVLir2G8FLBZ/mh0c8+X4+dVLXWVsqboRcTxT4YMcveJ+CiQtZ5YSnEugmiVpN
 yfGFOASKoV7tMpGHeAfdF3esHa9/ybL8iXOxnGtXHUQswrj463qiyEVoG3F9xalfoHzu
 911FZJPCBK44ZWbib/ulZDetrN1wR+OOTAOZgOuuxiZN4n1qJVWgqnDJXJLrCWHNTX3F
 4u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745482851; x=1746087651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytGDBpv1pt6SUN7d+5+FAkGcFAfGT6omdrFsqWjZC+U=;
 b=B+50aIya2Hm0Fko++mv13wNr5NzdbR+huF+T0KHvmnwCEUOriOQ1I0e/ZMLfbXCkbQ
 YgBPuVI2u59MV3N969v+j9H/S6KeHdskLuuZF0vo1uyNeOe2wYUJT1+2k8lDwS3a4rpQ
 KYn54cNHKZyiGXFoUVzc9abLjWPX9Lbj6gRzJ27Mv9/EgcF3G4gl+wHWRpT/hgnzOqCQ
 v37Jb+zQ06M1o9QmKht64itHDcJqI6NhVwA3+FhBZNyFYZQjkyIs+MAUVkt2uPLTm130
 QNzJFp2kRFac2AHIibyrEGPz5mnOyWA69KAL3Va6N+XtqPgBTXVBo6nF7gHzGewFxUSE
 R7oA==
X-Gm-Message-State: AOJu0YwalCt/m1275nKw7m6Tdqy5REcxHEFEpdQ6rcoUy4YMY0frpoCq
 QE8++GnkgODYsRkRkHb0oluWtrO6kzYuX8vK9jgacAnzR6GKxbMR8g9YrWsgZos=
X-Gm-Gg: ASbGncuVWUlfCOnXM3PsfFyZdDzM+f06O8jTYlfz6y9U1kXT6q+mLI8hZsin5vgnJaK
 5mSdRvN3M+4YAQBZYwQkSoYVCZJgIyfzXztARa3822e/R7RhagjQ+x7FtIiz7CDKC+8qa+ueGg4
 SLkh3i9Cmof4MkOtC9SEP6Hcx5Bvu6X+WjvJOuCqEg2ftOHCFXXRU0/PO3Q5hOS1YjR1feTvbJl
 W8bwG5HxK+FJN9z9IrGDBe3sV/7S+Ty3p9XUuSRu/x5BiiRm+eQy3BuH4O0B73jItm7u132VCbR
 s5VWze7UzBrmF91S2hYZFosiLvNc
X-Google-Smtp-Source: AGHT+IFlEpPyy0nmcW6ED6vjaCCnHKIbcWbPwHBz63xcqFQAViW/rhuZ6OVSiG/QeWdySasLr4x2Yw==
X-Received: by 2002:a05:600c:4e07:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-4409bcfa390mr16332575e9.3.1745482851025; 
 Thu, 24 Apr 2025 01:20:51 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2d88cdsm10638865e9.25.2025.04.24.01.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 01:20:50 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:20:49 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: change default CPU to 'max'
Message-ID: <20250424-6351b8780f6887b09c2c655f@orel>
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
 <20250404152750.332791-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404152750.332791-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
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

On Fri, Apr 04, 2025 at 12:27:50PM -0300, Daniel Henrique Barboza wrote:
> In [1], minute 44, we have a hint from a Canonical kernel developer that
> the next Ubuntu LTS will be RVA23 compliant. If this really comes to
> pass, the 'virt' CPU won't run it by default - we'll need to either use
> 'rva23s64' or 'max' CPUs instead because rv64 is not RVA23 compliant.
> Other distros will follow suit eventually, given that RISC-V profiles
> provides the most stable ABI to build a distro in the RISC-V land.
> 
> This exposes a long standing issue with the current rv64 CPU: it doesn't
> represent anything in particular. Extensions were added in it as time
> went by and we ended up with a CPU that has a random set of extensions.
> 
> Changing the default 'virt' CPU to 'max' gives users a guarantee that
> the board will always run with the latest features/profile available in
> QEMU, which is the intention of most regular users. Using 'max' as
> default CPU is done by other QEMU archs like aarch64 so we'll be more
> compatible with everyone else.
> 
> Note that this change does not affect existing scripts that are using
> the rv64 CPU, e.g. a command line like "-cpu rv64,v=true" will work the
> same after this patch.
> 
> [1] https://fosdem.org/2025/schedule/event/fosdem-2025-6031-risc-v-hardware-where-are-we-/
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c9d255d8a8..ff7a122bef 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1920,7 +1920,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->desc = "RISC-V VirtIO board";
>      mc->init = virt_machine_init;
>      mc->max_cpus = VIRT_CPUS_MAX;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_MAX;
>      mc->block_default_type = IF_VIRTIO;
>      mc->no_cdrom = 1;
>      mc->pci_allow_0_address = true;
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

