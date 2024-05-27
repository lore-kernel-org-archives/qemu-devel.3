Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F760C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXL1-0000tP-GF; Mon, 27 May 2024 06:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXL0-0000so-4N
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:12:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXKy-0003Ad-Ge
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:12:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35507e3a5deso1595969f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716804735; x=1717409535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hejdxdT776/YXS6vd7fdFoEy259e/wrDau3iwUXTDU8=;
 b=AA9rp+913GFa4aMmYTGmfAgf3chrNzIJTjzmFrcKiho2BGrm+wux+T+uw/JcnLIwHs
 6mHPuxW/VB5HeXXVEwQk13w0mIQa9Y8Y447rPMrjXLCgwUh+x2xrTazqYGGZZrbD0vXJ
 l3DSw4QJLpGOxQLl5fL7Sv3K6/YRY5B9bi0oWPoRxkA3kOrFxFYXV6QLDrLWm+qIsxc+
 Z6NVGch8GDbXR7oKLiUIqF594iHhh5gyZ/mRHIiTrC6jHyLXdFZ0TY0KoW4j7drMQ57U
 m7VbjDAhLeZMHbZSCdz/w1gfzae/0IwuztKPSjKNEseqdyZDJ32fwlaQYr9Rb9/g4f8d
 G05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716804735; x=1717409535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hejdxdT776/YXS6vd7fdFoEy259e/wrDau3iwUXTDU8=;
 b=Zf0rqo+8zsw6tmb73jVXXHfSJJuumTICh0GWKxB5OSUdrLDaUK+iDznaTmIjyB2iYm
 QuE8JoVE265cftbPE2V9omhJxMYiGBi9JHBB8bMMpnbbjrtMsGTVGP2NcmPA93DQPCOe
 /Dx/r/NS3XMkZVpLPa3gbujuLSg7Y9HAo/u7L3+rJpXetUPXDh3t3E3IsmVMWOJ2dSbb
 DUSxyTTdKZwRheMG/p8udWy+IWgTa5uD2pXlH57mstqM4F2h2SUjdDRx2o+Hr/DV3YMD
 cyqsnHXkrU9TjOBfiIi2AFtyUbVHytQYuV7ag5xRDpUvU12ZBw7B7BCRE+29Bpu6g6xb
 jx1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3d6Bvg2nEYDBw75UN/4Ou1jAsvhWtMN753httOtCTn8ozg/VR5uBmQXJ7gW2X763MjshZJOqaHMWJEMUNP/nnaZFyb3s=
X-Gm-Message-State: AOJu0YwtU1xk9xOboMZcE/FZdSlHEqfur1qd1tJHOsqEQtzbWypJaasC
 1f+vw8js16FQRGIIGEfgPc6gaANDyvxtE7QwsoAm+iCZjFQSGHcE74FjiUbYGO0=
X-Google-Smtp-Source: AGHT+IEdaIdDS/9O4rNxD8V9/HhXLgYxs06Dsg/AtvR8o/qCmCzDuFQ02qQBlUoX3xJz3GijLsRpKA==
X-Received: by 2002:a05:6000:11cf:b0:351:debf:a39e with SMTP id
 ffacd0b85a97d-354f757d1a5mr10775266f8f.27.1716804734715; 
 Mon, 27 May 2024 03:12:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35586a15f7csm8663904f8f.94.2024.05.27.03.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:12:14 -0700 (PDT)
Message-ID: <27cef750-262a-402a-97fe-c4a55700a376@linaro.org>
Date: Mon, 27 May 2024 12:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] tests/data/acpi/virt: Move ACPI tables under
 aarch64
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1 Xu
 <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-7-sunilvl@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240524061411.341599-7-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Sunil,

On 24/5/24 08:14, Sunil V L wrote:
> Since virt is a common machine name across architectures like ARM64 and
> RISC-V, move existing ARM64 ACPI tables under aarch64 folder so that
> RISC-V tables can be added under riscv64 folder in future.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   tests/data/acpi/virt/{ => aarch64}/APIC             | Bin

The usual pattern is {target}/{machine}, so instead of:

   microvm/
   pc/
   q35/
   virt/aarch64/
   virt/riscv64/

(which is odd because q35 is the x86 'virt'), I'd rather see:

   x86/microvm/
   x86/pc/
   x86/q35/
   aarch64/virt/
   riscv64/virt/

Anyhow just my 2 cents, up to the ACPI maintainers :)

Regards,

Phil.

