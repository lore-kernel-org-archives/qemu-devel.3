Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA779CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ52w-0007gO-U0; Wed, 12 Nov 2025 02:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ52u-0007aG-6n
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:13:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ52s-0005YF-Ed
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:13:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so264528f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 23:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762931613; x=1763536413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SToKNFNxWpGdZztA7IEd8LMdQOrB7lsXcR+gQX37vnY=;
 b=eNzjzS1vH8B3m/eMPui0XbUwPJAZgRAdQEnzXMfML8r0o9cpo+Bd3fZW5cS52AbD0f
 pCbrVZF/wb/uD7pYXP1bPLjxFTflzy5oAnQGNc+iQiOkVDHCXfoR/VTWD1ruz4l1zmaA
 tGWfT7b8T0KJEvaBpqSQI+ymjnOwmnRWHhBTIxULt5qmma5uQaLrBqgXDwFd6fQugGC4
 ybyQ0kbAX9JD9NSGYksayT36NkgzO+aqiS2VZaQLla/kdDePXLsxkWUze+S56as0sHez
 AQ7sFvX5rV74hD2WVENVixx1KQCzXG4jrF8Pr2eYUGtdiXH56WQUiILIn6p65m4j1qrA
 aqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762931613; x=1763536413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SToKNFNxWpGdZztA7IEd8LMdQOrB7lsXcR+gQX37vnY=;
 b=FTqJIB8A5DYpFKgA4VHcEh/AGJ7OcFyo5C9wuIx3zpFRPMWZNPTOk1Lpt9BYkUlm46
 aGLcaW9F6cyxwj9XfcfkiA33CLIR4OHQNB5kF7jBchI5+FJcCzxRnnX4OdkpRyAY8YYn
 31A9FW/ELKCoSegdtGiCjWiY6n2fBeQbPPIz80Nv0q0hzlNkUhQjTx7gkpi9HPJFu9Pb
 Q3UKVBrEr2yY6sdbvGqm1v2RZGsAZbsL1nyszboCQ/nKp5R83lBDzF0K2DmvXBTvBWyw
 SUXRt2fcYqwUBjBHKQY5AgX3Arsfayc3E50GsHkzkhm4961/5WEsOrocX0KfHo/1cldX
 95GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw2C4G6Jxgvcc4QYsF1hL0xGo19k215WPeqjnCassuDNmfw+8lO/NqVhP+o8ZysYKw915B0hFolXnC@nongnu.org
X-Gm-Message-State: AOJu0Yz2/Q7UxGOhYjcn6e5MW8TR/IqkMB/QmC+37Vv3u6js/XqueJRx
 IyxMo5NzamhYw3dVchdvjdGq7MZXC0A+P5JB4py/EBzgPl/CdEOhA3zfgkYgUUcMos0=
X-Gm-Gg: ASbGncsYrHXnSJXAigOiPIchvApXH7CfvBiVEljw/o7dnZZyHkMXzUJBb2ZHMtnXLkf
 opqESpjEQVvRbBx7gQpqE3loWwovWbr32U9H8lgKtFmmcZHMlgPxdqC+KHPqNNMSfJrXE5RtcqJ
 QbRqtrjzZeWylQgwFlVt4L74Vl/FiN0DlnPxJTYdc1n7xnqf8uPOvRQwn4mxUVQxXkItBxS2JPN
 p/zaP287Mc8K+KWatIlS1zu9PhL7KZM2cJDrO3kqhcMdkv7xo0kua361fosZtDNxNOVlVyIU5FR
 A8P/fGf0pEGlv1nxOkSN5VdLcPe0wDFpLxmCRkWvLJUTcoOfODGuplEpJYTUX8uPDShrX5HMkfx
 SJuphNmrcioPgrNVfFa1gfj6CwYSj3Geh0L7/4drnNxo9aOB7LSppUnUQXoS7JuqbEmdlmndZj+
 LdaCdybgZRKsKc5gl4GUZmsC4OI3R+VI1FMK6C+UXvl+76lsIr
X-Google-Smtp-Source: AGHT+IGxDHKQTRT9FMW1fL8Epb47f/j9HtWLL6HZNCrAHpLNNJ3o1D8l+NtCkzBAAozMAvLrijWMhA==
X-Received: by 2002:a05:6000:250c:b0:429:cc1c:c42 with SMTP id
 ffacd0b85a97d-42b4bdae90fmr1535776f8f.61.1762931612692; 
 Tue, 11 Nov 2025 23:13:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2e9644fbsm24417511f8f.25.2025.11.11.23.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 23:13:32 -0800 (PST)
Message-ID: <4b2862d9-0912-4a73-bcf6-29bdfd681b0e@linaro.org>
Date: Wed, 12 Nov 2025 08:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-4-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111182944.2895892-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

Hi Fei, Daniel,

On 11/11/25 19:29, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
> 
> We do not have all the required extensions in QEMU: we're missing
> 'sdext'. In theory we shouldn't go ahead with this work, but the
> emulation as is now is proving to be useful for development and testing
> of other parts of the SW stack (firmware, kernel) and we would like to
> make it broadly available to everyone. We're contributing it as
> 'experimental', hopefully making it clear that the board does NOT
> complies 100% with [1].
> 
> The main features included in this emulation are:
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

Too big to my taste to review and/or look back in future.

(Don't bother splitting if someone is willing to review the patch).

>   4 files changed, 1292 insertions(+)
>   create mode 100644 hw/riscv/server_platform_ref.c

