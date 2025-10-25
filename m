Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B89CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCh5P-00044J-CW; Sat, 25 Oct 2025 12:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCh5N-0003y9-7Z
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:25:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCh5L-0005Nc-El
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:25:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-427015003eeso2838262f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761409541; x=1762014341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJHF55Ryn+HfYD/CfXb4Tou86e/gd+p9yGggFgDosZM=;
 b=IsE+Q84BfBR/VJQTF/dPsyp/u/cN+FWkwVJEhkDaucmKeSjGduIC9x+GeE3k7vO1EJ
 FrkGqmCYe+Lg2pKa8sdwXj813TAbYlG3Tp+B8C9UNfgDCxIBZ95Qh+Yme64bPj21whUj
 VSdZwza9iGwqh5825pzRMwSeoYw290lMWDWOa0mdry5L/8byIlTccCVTWm60LHWg7mSt
 Z/LfEl+6v6Ywvt0wxaYkzveyzBRQVjkurqzOBoVYy7Jn3QnTDSrPRb9KchwDiVsNyRt0
 XlrNlx0uLarlMnPfsK72/UeS0b9OcCKX/51D3g3lqIX0iquPvTpBisSy+CbxdllVn4rK
 +evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761409541; x=1762014341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJHF55Ryn+HfYD/CfXb4Tou86e/gd+p9yGggFgDosZM=;
 b=w+3ES5TsflSjK4xjwuRLCZvLL5fY3qdVhKEGHIAjsligjGNP2fP+nBNGZzO/UnZk8X
 GSy94dJk8b4esQv9y+yYmQIfvMBKjzaPCZg95TwGPMipmX5H7ZFpIRZu5qDmMnKFaZBO
 vL8VMh1Bpdev/5Xsei0G4s9LWcGaKnYgggUB5X52Rngc2BwFgkAtyAERMNu7fjvrtDnn
 0Q3la5rWSTHwsQF1t11OPFsArV1UnnBhPeRnJU6NgyZK7qiO5Sx91BN3SSvY1vtuOL57
 tgYJ+PaELafQL8O1nx08MCPvguZgGS+2UQae41co+jeTkORNtu9ShXrFqQMoFNOdpSPO
 yf6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULTCkoTdIzn4FgMiDF7miwo1XOTX9W8hHfxX15o+dpG1jGAdrQ/tL0dj3DW3wwFbNZvl+Ri1zcOvjI@nongnu.org
X-Gm-Message-State: AOJu0YziFn7w7Iwx2z3ewL02pMsRpJ08VQZZL1XGDUs8sCUVod3RG2mN
 DTBZeP2tKYtsVGHQrSipvBh1i4n/LYSrORAbrca+zcJt5bCmDk1lg1SUIK8TlWj1dq4=
X-Gm-Gg: ASbGncuAx7GMlIawqAHoFh5Hy6QdLJDTQokFY7wlOYOOWHwCX2BLEsM5cIopQJanNRQ
 b32Y8I02D414sGIQbeAPSgRhBgT2rKXTbfxZbQ8F5tVnhLi+YFmzpf8Ch/5JsKruAH7mGeMpIO/
 1HOW+0KpmJsB/Fu5hrf721d7N8LKu9b3fm2X66iHW75QutMFAV5NnNU4Mey8JtsvXH3/+uEa5Uo
 yG+GyVOyY4vayM7XX5q1tzir/xJG3kn+PaWbLzftErTYkI0LFwdfX7RBbfR4C89KealFyNXWhp5
 SJg80kPeMXtTpyEpmjugoLjNuVkwJ2mwF3zl0VTnDsneYII8iaYd6CYVrek+kehye9LhmszMoJE
 htA6SpuKxDSBVI8fCzJ9GSfnyrnDHFsZeO3L0wiuLpbJhzpVyKJki+KTkUb0LAOvY+/9NwG4LTs
 uhiY3Mex4Z4xlFeqqf6nY3BLt2spF8BFGrKb04UQj1T1g=
X-Google-Smtp-Source: AGHT+IFlct/NpBB+6T7T/kTVKr6VDaembQEJYpBOJRZNySep06Bzv5FWvrLknNhUAomj8W/n9pQdFQ==
X-Received: by 2002:a05:6000:4313:b0:429:8c31:84c9 with SMTP id
 ffacd0b85a97d-4298c318a9bmr8018424f8f.61.1761409541452; 
 Sat, 25 Oct 2025 09:25:41 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm4332098f8f.28.2025.10.25.09.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 09:25:40 -0700 (PDT)
Message-ID: <a54e8e84-9b69-4144-a02f-1825b9918352@linaro.org>
Date: Sat, 25 Oct 2025 18:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] hw/hppa: Add 715 machine type including NCR710
 SCSI
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251025161901.32710-1-deller@kernel.org>
 <20251025161901.32710-12-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251025161901.32710-12-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 25/10/25 18:19, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add a new emulation for a 715/64 machine.
> This machines has no PCI bus, and has the majority of the devices (SCSI,
> network, serial ports, ...) provided by a LASI multi-function I/O chip.
> 
> v2: based on feedback from Richard
> - Fix indenting and use assert() to check ncr710 device availability
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/machine.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 81ed050b5e..7b130a0db0 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -30,6 +30,8 @@
>   #include "hw/pci-host/astro.h"
>   #include "hw/pci-host/dino.h"
>   #include "hw/misc/lasi.h"
> +#include "hw/scsi/ncr53c710.h"
> +#include "hw/scsi/lasi_ncr710.h"
>   #include "hppa_hardware.h"
>   #include "qemu/units.h"
>   #include "qapi/error.h"
> @@ -363,8 +365,17 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>   
>       /* SCSI disk setup. */
>       if (drive_get_max_bus(IF_SCSI) >= 0) {
> -        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
> -        lsi53c8xx_handle_legacy_cmdline(dev);
> +        if (pci_bus) {
> +            dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
> +            lsi53c8xx_handle_legacy_cmdline(dev);
> +        } else {
> +            dev = lasi_ncr710_init(addr_space,
> +                                   translate(NULL, LASI_HPA_715 + 0x6000),
> +                                   qdev_get_gpio_in(lasi_dev,
> +                                                    LASI_IRQ_SCSI_HPA));
> +            assert(dev);
> +            lasi_ncr710_handle_legacy_cmdline(dev);
> +        }
>       }

Can we move this code in the callers to keep the rest really common?

