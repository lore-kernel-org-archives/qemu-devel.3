Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86999CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 15:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSzWD-0003RL-AB; Fri, 29 May 2026 11:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSzWA-0003QE-V3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:53:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSzW9-0000bs-CV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:53:02 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7ddd3d67084so12518717b3.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 08:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780069980; cv=none;
 d=google.com; s=arc-20240605;
 b=OwOcjpWzprtA12lz21atNymoy+xXcbH0o/LZ9caRCvb6YwaJgPStdU1ArKlgQ/9F30
 H+UPOJFHop6Y93Oc0IQLBYUgxILKFFX1JIpwU0i8GKc11DL4rtUPFKXgDM4wuWny2Foo
 zpK344TU+MY5wwFnxccQ85Z7eqHNBux9iSOhdFSR7ODiFyi8EckzSRn/tWD8QWFi1g+X
 jUYd38RM9rwuxBTVnzDcCYwgZg80bHhZ4CEa7TyCd+OoPYsnGIu+kzv3Ob+kPY69TUkx
 dv0jFvgZhUd/t+CZpYnqnWHq46v2URIszBiTzjk7uwEXIPtDBkchJRvdppyUYgK6CCbz
 /fBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=57StnsCKBoSeLVKaEyop0wRsybMM1RQpT6t9R/ontsM=;
 fh=ZyoILRHiPr4hqTxE3AF2idGuSMcNkhskJBR81qg8LQM=;
 b=P2EgCBNT6wa0VJTohry9bFS9trBgSz68h/ULi8MHjmjurtp3V6zbYsOo0MR+HwgnFc
 Cdtgs9R3fUXLRFV7K4di4MPKyDWJOTL2MNi4LBrEjey+Ps9uSF7AXF4QNvwXgCnJNLYY
 RK6w2xeIA4lRa1nMHJD8zRyBjX2PK5HYoGZ6n1k/WZSut+U6C2lkDlTPvGwrfvdyYUQv
 lmdoTGV0xMdcqpG+L978LgQ5Ezb8Gav0kamJiS0WyflBr2+v7i/d1If4uoKWbBqdaYAm
 uOcJ9/8blavStghMKKRIEuLBip0rlJ04jbdbTX7gVf1pXZI3645xVvzBrWGzHVZgPqJQ
 Ipjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780069980; x=1780674780; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=57StnsCKBoSeLVKaEyop0wRsybMM1RQpT6t9R/ontsM=;
 b=IFemQnGwRb5XjhNz5mK9+nXiS6EnXBnKXeztc76YdBfUqH0vFdXGCdG2oNFjwSuv/l
 DcpTGNyzs8UJBXWHNvourPkyqF93BCb97Lu3b+ay4Bkg4EJznUQLt0daE/HBKgUaEY6Y
 5wzcsw8zYKVEMbDGZ1HtnnFg6MHka9rA9o8YUxONUa/FtMlIocyIGse5RIQbTg1bGZG+
 +IQpU6aVnq5z4JsSwtIFcQznCDUgzysie4Mvt5fzv956XUOwESIR8Z0CfHGXFb0BVTjJ
 LrW61vGby6m9xCBvkrKsNAw0cGbev7AmNfQV740HFpDJ3NQEQ/6q/x64zEu4pxtvCYLC
 g2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069980; x=1780674780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57StnsCKBoSeLVKaEyop0wRsybMM1RQpT6t9R/ontsM=;
 b=l0vgIqlfdOvp2UKxbzrL2ndizZYCdOqgrCfDK9ujdbuYQUxzN3m2F8EQRsR8MnG6mK
 Tuy3qatb09aPlmlM9lhIbDobRmhBltArShMnS7UbvqRO39iY7NmTzI/oXDH761YEB0oI
 0MW7Kni9/xoPqC/XOgk/+FtdNcBscQ8+aqezQDhvCUAv5Tmq1R0kp56nogJucH8KVS32
 m6kSVXKA6iIzv1xnyfH4RTmJgbJY+py20wahi/f2IXqvX8tEb38MfL6Jx3eUiZ5xqZmA
 sxsCygR6xT+x5zz5PfMSzCBWkzEN7VCUpHOtb+PR8X80wrwTMZKLzIrdDR9cz8CJC9Qp
 REOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Tzv4P5hgiZFNRtWi9NLro/zewNWHDqI52/YrONik60+UNWga//78/g3sRPWYt3xjNgbMmI5ZHzDRl@nongnu.org
X-Gm-Message-State: AOJu0YxyKTmLP2SYzZfqS8qgK9hlpnwl9aRYncwngpR30eVst4sjy9KS
 KVlwb53jyGuXAyGyamfTItpA78JSBf0IbDAAdzoZzHQpub0SeXI/OMIJFed8XGEDqzd65CVL0Sf
 mRv4QAc4KhztwlyzwcHBETd8XsVUFXr8FLnfcWjaJgw==
X-Gm-Gg: Acq92OECtDmUY3EyfepxQO1kk132Jzt03lSZkyGmAuIDE9GNIwmwNSJ4V54m0DSKcI6
 UQlUoOFtVkhY14fxRuRkbipy6dFXh61YW2m4WgufThidq/aUV30Fc010iRBIQ7awo8h60T+1ibY
 dY1f4rDgR1iaBlzPKGcjL8SF1I8sVvJ3E1OacUkZpNk0gsZrG47arhYa6nUnCxF37VypqrcO/Kz
 lcAjnf/sVyysXUVEWsPxywUljwjNlW7RWyFRLE7DPuOtJM1hXQFfe3+9Jn+3raVMDbg7ts1SUW0
 zltiz1rzJlwWP8IttTPVvUb7eDBqrdH07KsVr3KQA8UmFjDttmrnKC+EqwrS4/WEkrZfjpUMo4e
 TiQ==
X-Received: by 2002:a05:690c:660d:b0:7bf:ff7:ea6e with SMTP id
 00721157ae682-7de47281fa1mr30969627b3.4.1780069979857; Fri, 29 May 2026
 08:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260529140559.1775511-1-chenhuacai@loongson.cn>
In-Reply-To: <20260529140559.1775511-1-chenhuacai@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 16:52:47 +0100
X-Gm-Features: AVHnY4LSrZZZJMFoZaqPSIwMqmLiHzbsxYoMg4uqG_L5elx4hfTYE6ALISWkCME
Message-ID: <CAFEAcA_Li+07XNfE+GpvZOzwJReqbG=x8nz=kMrQy5vqkReEUQ@mail.gmail.com>
Subject: Re: [PATCH] fw_cfg: Add support for LoongArch architecture
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Gabriel Somlo <somlo@cmu.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, 
 qemu-devel@nongnu.org, loongarch@lists.linux.dev, 
 Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 29 May 2026 at 15:42, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Qemu fw_cfg support was missing for LoongArch, which made some functions
> unusable in virtual machines. So add the missing LoongArch defines.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/firmware/Kconfig       | 2 +-
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index bbd2155d8483..9ec747716389 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -121,7 +121,7 @@ config RASPBERRYPI_FIRMWARE
>
>  config FW_CFG_SYSFS
>         tristate "QEMU fw_cfg device support in sysfs"
> -       depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
> +       depends on SYSFS && (ARM || ARM64 || LOONGARCH || PARISC || PPC_PMAC || RISCV || SPARC || X86)
>         depends on HAS_IOPORT_MAP
>         default n
>         help
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 87a5421bc7d5..0c51a9df589f 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
>
>  /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
>  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
> +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH) || defined(CONFIG_RISCV))
>  #  define FW_CFG_CTRL_OFF 0x08
>  #  define FW_CFG_DATA_OFF 0x00
>  #  define FW_CFG_DMA_OFF 0x10

On the QEMU specification side we could probably nail this down
to "x86, sun, ppc, parisc have funny register layouts for
legacy reasons and all others have the 8-bytes-apart layout",
which might help to avoid having all this architecture-specific
ifdeffery changing for each new architecture, if that's
something people care about.

-- PMM

