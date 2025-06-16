Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9038C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6kg-0007A2-Bn; Mon, 16 Jun 2025 06:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR6kb-00079M-Lk
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:07:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR6kU-0004A0-9l
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:07:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2416041f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750068448; x=1750673248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GuIDEvpuD6ITox1vc9gw+CQH+88GMmxDeOMHy3uegLs=;
 b=v+m9sNoeIhHTrECwxhw+Fr7HoVd2Rdcd5cNiasyT9D7ZPbcnxTxg9XfitB8wvaFriH
 lwHArreAoPHdC4bQ0J3CVcR7WR6w3JRSYz+rfZ8ukMkji2qwIkLpE80l9tHOimGWpcR9
 cFCQbdm3zPW7x4LLHGTuQSxUTNVZ4nUtM6TRNf9FLKTCftAv+oqiet1obnEykIbIbfIz
 xGRQvVLLkags+LI3PLtVbyrL/6snvZq6OHTSvo76DKeX0cym18wyBHRWc4zcir/FHXxN
 vBruoANMuOz48xE+48fPiHOhHtVQ/cY9wdpZyumJ3YGSZrIuSC2Sh1m2yeLTZwXAUjhy
 iKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750068448; x=1750673248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GuIDEvpuD6ITox1vc9gw+CQH+88GMmxDeOMHy3uegLs=;
 b=KQVZLPoxla19IUc8BRHZlHjaaVdZl0UQU3e1+wodc1s1+O2DJJ/qLKzr1Pf6CcaL29
 re561d2kQpGC4cjTWt6/7SeZOvZ0fY/Ff8ho5D/cOESfuLX95MEi6ztWWF1sAWs8Lx3T
 QPxdKaiCoTXi0uBKnvI8oNwfJP0ocpIgJ12+ADIAn48up6+ImDGe3xUBDlgB5dShc6an
 B+99/0Ze3nJCw3Xhjwd9WBAZwcx9APTYy0Kh0GmCuldoXu7WJ3injDGFhai2/CFzwrGl
 jjL9o/x4Trfj1g1f9FmtFPjKRgZf+KNz10inPUx66u+iczn5HfzdziDD2XThf/UTrMhQ
 LswQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURVtkAvU3v2NjRnRoGHfceejIki3cBpThMQeoaqBg0s3ZAJ21oG+71hxgYwlSGypImQVTpuSUgCSPY@nongnu.org
X-Gm-Message-State: AOJu0YyUd9yTjELghvGdwyT2NFVIFYEVJD3pm7nT6YxdBUfyBp7w61MK
 poe9KK4PKz4XteW1y+riz+PlxN7mPnLmZcQfRdvs7vFOAzBf5iLx9gOD933ixleCADccE5UgyOJ
 wF2jFH2o=
X-Gm-Gg: ASbGnctu6V7I+Nu7YHH073O414BLeEmQ1Bu1h+C87ZBs8GVa6r7xnz0hr98QNaevGOk
 bBVzeVnNP/WxOJW4OiM/9AcvjgKCRjl/ewH4cgFGEijakMD1tGqLFmvH59FIPRgaAuuIi9U9tVF
 HcfL62D6C+kZdzfheHkkMee/OlNzld8NJva62vpZmDq/MwQC6/eZZqkCKZGxT93GS6O9qVJ8+tZ
 LZBMF1NyrTALE/rt5j4dKNtPQD9MZyq/mnaj8WLPNSdUTB2pvvszrwmrKgOksAiQdzkH6Vbv9UV
 Xw0ajyCCgx45wEzm+pNZaC242aufByBqRy6pmQ9m9HutnUtBRr1SSByG8+q/dwja0HVU9NgzCi+
 cULKRLXB9TBNBPheDfjmdh12cqGC82C9ClUiumqny
X-Google-Smtp-Source: AGHT+IFTWSQkaB493SSD+KZeQLwpi2MPTYTkoc1j6MGU5FBWPUdyFNmSxzb/xNZGq1dIuWRzy6eIQA==
X-Received: by 2002:a5d:64e3:0:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a572384056mr9024026f8f.1.1750068447749; 
 Mon, 16 Jun 2025 03:07:27 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a633ddsm10556066f8f.26.2025.06.16.03.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 03:07:26 -0700 (PDT)
Message-ID: <42af58ad-4e19-4d44-85d8-b78634af8cef@linaro.org>
Date: Mon, 16 Jun 2025 12:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 70/72] ppc/amigaone: Add kernel and initrd support
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20250311125815.903177-1-npiggin@gmail.com>
 <20250311125815.903177-71-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250311125815.903177-71-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 11/3/25 13:58, Nicholas Piggin wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Add support for -kernel, -initrd and -append command line options.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Message-ID: <489b1be5d95d5153e924c95b0691b8b53f9ffb9e.1740673173.git.balaton@eik.bme.hu>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/amigaone.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 1c6f2a944d..359f5fa125 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c


> @@ -301,6 +362,56 @@ static void amigaone_init(MachineState *machine)
>       }
>       pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "ide")));
>       pci_vga_init(pci_bus);
> +
> +    if (!machine->kernel_filename) {
> +        return;
> +    }
> +
> +    /* handle -kernel, -initrd, -append options and emulate U-Boot */
> +    bi = g_new0(struct boot_info, 1);
> +    cpu->env.load_info = bi;
> +
> +    loadaddr = MIN(machine->ram_size, 256 * MiB);
> +    bi->bd_info = loadaddr - 8 * MiB;
> +    create_bd_info(bi->bd_info, machine->ram_size);
> +    bi->stack = bi->bd_info - 64 * KiB - 8;
> +
> +    if (machine->kernel_cmdline && machine->kernel_cmdline[0]) {
> +        size_t len = strlen(machine->kernel_cmdline);
> +
> +        loadaddr = bi->bd_info + 1 * MiB;
> +        cpu_physical_memory_write(loadaddr, machine->kernel_cmdline, len + 1);

This patch introduces a call to a legacy API (documented since at least
2017 in commit b7ecba0f6f6: "docs/devel/loads-stores.rst: Document our
various load and store APIs"). Can we load via &address_space_memory
instead?

> +        bi->cmdline_start = loadaddr;
> +        bi->cmdline_end = loadaddr + len + 1; /* including terminating '\0' */
> +    }
> +
> +    sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
> +                  &bi->entry, &loadaddr, NULL, NULL,
> +                  ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
> +    if (sz <= 0) {
> +        sz = load_uimage(machine->kernel_filename, &bi->entry, &loadaddr,
> +                         NULL, NULL, NULL);
> +    }
> +    if (sz <= 0) {
> +        error_report("Could not load kernel '%s'",
> +                     machine->kernel_filename);
> +        exit(1);
> +    }
> +    loadaddr += sz;
> +
> +    if (machine->initrd_filename) {
> +        loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
> +        loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
> +        sz = load_image_targphys(machine->initrd_filename, loadaddr,
> +                                 bi->bd_info - loadaddr);
> +        if (sz <= 0) {
> +            error_report("Could not load initrd '%s'",
> +                         machine->initrd_filename);
> +            exit(1);
> +        }
> +        bi->initrd_start = loadaddr;
> +        bi->initrd_end = loadaddr + sz;
> +    }
>   }
>   
>   static void amigaone_machine_init(MachineClass *mc)


