Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA8ECCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 22:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEb7T-0008AO-D6; Thu, 30 Oct 2025 18:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEb7P-0008A9-US
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:27:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEb7C-00071T-HJ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 18:27:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so16947525e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761863241; x=1762468041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gxLjKN0lbav4jnfxCxb91jwbCn/1h6n49kAXth6KNbU=;
 b=D5le9BLM3NBoogjb8Qm32L5BZYOYOm57ilYm9rqfcuKfzKtFwwO1ebu5sNUJCDZQcw
 X9qHyHAqxk0Kt1rj1jvO2eYZM7VQrnW0Ct+YL+KoENqzdy83MYb0sI93T9wx54JsKm7n
 JjxU1PEa6TPVPtuiznQZeiaRwE6t1fqW6iQO0WtyPScteaIUcGdkIju3xc3/PRKs3Pm7
 OLpjpwRZ4BTbR1US1m4sX+tFbkAFJVsUD+QixYkzGAMwDhPhgy4kjdbfQtn+mzacogIU
 51l70KGV/FLvOzQhIR6TEu+FK+ITG4QYarVa5GJ1Ro5gQaDyraLK2sMUVA46JxNWo0SG
 60Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761863241; x=1762468041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gxLjKN0lbav4jnfxCxb91jwbCn/1h6n49kAXth6KNbU=;
 b=pN6nfVmVFwTo9Mtt9B+uckJMEWfO/jGr4okOyrExdSJ2uNQwlQ62bTcM+iMi64LLt+
 uNtJ8emRwPs3olZvtv7tIqzS/gwdWfoNHHlkfsoKI1wXDT8mO9iTt3sKm3dNplPOH+L+
 ZzTyt6YXNSg8NqKmP58CkODwt3d3/p1Q/qPjr9eR6Qg9juPlH5Q6UYn4fa5v1TaGsn0S
 8HqcH6Uchr0uZyJ9lj71fQJFH4NXTIJFcp/FwGu10CGstc8/Df8NzlxdRS29oMPGR8+I
 TB2H8V8w29W2RqS+PWVyYQ6RxY/QZJcn30moMFzDYfm0LxzYOp9lGwDJOMN4A4f99IwC
 HGew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEnAUAPH7sroy7oX0+9I12TnG6KdfZ3bup63zynRvqwZLCHlgE92r0U4wT9PrcwDk8PFRguA+Jav1v@nongnu.org
X-Gm-Message-State: AOJu0YyJ6Wq4C/y9xcFSv+m2gOwcCJRPd+FnnpJWFto3PX3DBnHpFVDm
 tjWbUQQk7N3af19nxWcjY7CwnJfIXxrlI35cxKbbfrJTHApwcxEYETD5tE3jRCNog8Q=
X-Gm-Gg: ASbGncsmEqWTP7kUg+QXGuMSJCaxVkhU29dedcCojX2xISrQOMFLEci2eY8Y2SLwyzM
 wIIjLxRGO11cOiBunfTb3fhQPTX+gFE89JUWBO915qmoasDIpH5Luo/YxTWOmGQhWrL0wQQDrP9
 +K7l6OIT+ZVE+rr6Sf+aEt6FuIRJj/28ibsRViB6qPh4UvtQkxmWo3vDr3Lvj1WyjtY4F6iJyOm
 QGf/7LHFKQMnvJTSfuGowvfATC7OdiFrKBytXb+hla+QOFdzfuH/xXscBvK9riXcDpSBmgD+mV9
 Jd4gj7iHFDFKpQEbPv2Uj7ILf0U6CkDGadeRn/KaYYqYizQDMTJA2M6RNKaRbiMtq1zo+Js8tmM
 +vlRRhd87/4qx1iDCZ/57TKZLk6UHm3XK/nH9jtibzrr/uoLQAlIbL1RsaWweySH/Z1ANmGfKM3
 FLXzEa/OBgwAz0QJRmPgs55MNgUSDc1Zk2ezMCH7TNCQR37X0mS4yvWQY=
X-Google-Smtp-Source: AGHT+IEfxRvZbpJwMDYxoyrvEtuAaXU132HvEY4NKhOsB9844OXuaDaeH65JIKCm1iJ8wu63Ucu4oQ==
X-Received: by 2002:a05:600c:1f91:b0:477:e70:592b with SMTP id
 5b1f17b1804b1-477305a7cddmr12453745e9.2.1761863240627; 
 Thu, 30 Oct 2025 15:27:20 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de5f9sm34420762f8f.38.2025.10.30.15.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 15:27:20 -0700 (PDT)
Message-ID: <6bbb2e59-9e6d-4f65-a604-c5e0c69bb9f1@linaro.org>
Date: Thu, 30 Oct 2025 23:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/riscv: Add server platform reference machine
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, ajones@ventanamicro.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
 <20250528200129.1548259-4-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250528200129.1548259-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 28/5/25 22:01, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The RISC-V Server Platform specification[1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
> 
> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> short) machine type is added to provide a environment for firmware/OS
> development and testing. The main features included in rvsp-ref are:
> 
>   - Based on riscv virt machine type
>   - A new memory map as close as virt machine as possible
>   - A new virt CPU type rvsp-ref-cpu for server platform compliance
>   - AIA
>   - PCIe AHCI
>   - PCIe NIC
>   - No virtio device
>   - No fw_cfg device
>   - No ACPI table provided
>   - Only minimal device tree nodes
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform
> 
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   configs/devices/riscv64-softmmu/default.mak |    1 +
>   hw/riscv/Kconfig                            |   14 +
>   hw/riscv/meson.build                        |    1 +
>   hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
>   4 files changed, 1292 insertions(+)
>   create mode 100644 hw/riscv/server_platform_ref.c
> 
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
> index 39ed3a0061..0c4893b708 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -9,5 +9,6 @@
>   # CONFIG_SIFIVE_E=n
>   # CONFIG_SIFIVE_U=n
>   # CONFIG_RISCV_VIRT=n
> +# CONFIG_SERVER_PLATFORM_REF=n
>   # CONFIG_MICROCHIP_PFSOC=n
>   # CONFIG_SHAKTI_C=n
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..f626774c52 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -69,6 +69,20 @@ config RISCV_VIRT
>       select ACPI
>       select ACPI_PCI
>   
> +config SERVER_PLATFORM_REF
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_NUMA
> +    select GOLDFISH_RTC
> +    select PCI

PCI is already selected by PCI_EXPRESS_GENERIC_BRIDGE.

> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select SERIAL
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC

