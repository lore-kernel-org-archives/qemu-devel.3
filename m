Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B088C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Fod-0003u3-76; Fri, 25 Apr 2025 05:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Foa-0003se-3W
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:57:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8FoY-0002QZ-CL
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:57:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so14369695e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745575064; x=1746179864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9CBYES/TQdgD4AD2jofFLpQ1DEqU4oUjs9Z1wTIW/Gg=;
 b=sOG8Gxi84dMaa9vLuCO/DzgC/BbB/j1telO3hPLg8R5n4eUDYjnYhqTXnEBTVwVu7x
 6r21BZANxvoDBhUDr7v6AIjHrvfaLjeJJt78vpi7yuRlL86Bp3ucfax+5p8Yauxpk+Mg
 5PWjmyQ5dujnPlvGOyPrJ4Mvy00iYEqKMDdwY4ZA+ehKwMKuMhXGgt45FssVaXVLQK9f
 Z3HZDT/RdRq6VBNwLCz0Xd9QozcInr68txa9HehpCHK2TgxOfevfi71tTab4gIdM0zZR
 aWsjjVhcun943e3ZctFVgPPRQhfA1zeOoBh2cZx2P4YJMWypeX0Z1gXoDNvpFvB28Ujy
 JIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745575064; x=1746179864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9CBYES/TQdgD4AD2jofFLpQ1DEqU4oUjs9Z1wTIW/Gg=;
 b=dJoAbauPrMIAm+lowUTxm1RdkVr7pL1wUarwDJBYyKsatNvWrjOQdGm7nnt99J9IkH
 xneWtXBoHDI9OZfTA7y0Fx6Q4hsHg9ZX7pDktC1XhZiA6iG7i8vL65xxSHlS0Q3CfZwU
 ti6Pc8/KKhcZa9vNvwP+ntHe9JpwsvU8kcQnuHJ4MADLappbQWj+7k2/cPNcgKf1oPlb
 80aC/QFvMtOPoMvldxdu3IyMi1Anqifxgg8pkhb+ZZbqp9VJs2dq7GOr3QNuLHR/Eo49
 TWsRD7smFQOxDpQa+GxovJ/11HuwJUN6poSUqPUIgrBwuqqG0i+eLgPmOrT6wa7vREHR
 WSIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdoU1yZiMuwe3Dk52W67jA7WlQDOB1eRESeFEev/vHEhk0fC4GCrdqoYn8G793/pUMOupzAJy0TB3L@nongnu.org
X-Gm-Message-State: AOJu0YznCpNNZ3FbmWPxigpVA70HMpwEzPiW0XtWqmLifusyV9dqxKaP
 bup4wrxqpCua7XNQw98dZpJqyTRwwDcMi/pcTf041IWUp7P2c9eoNSBSEFLPlfofH8OhYlj7xSu
 t
X-Gm-Gg: ASbGnctC7MmZLNFmYn1hnb8HVm70QCsaMliWBsG7SO7iNxsI+L/Rs5MJdGnuf6cZcJl
 VJG1+20uqXyPa9kYBXR7JMB7OMmQZdM2nSliC37MFSWP6QRuQyjO4kopUj+ufT16i4ifLt8KVLZ
 zMubiafzpA+Ktm1Y3dKN04OZ9XC/HW54N6Y7LQB0HzMBoMojEL9ghEtH5Q4Lr5xpfiz1u+pXjlv
 uF2N8Q0gS/j1ZuHKzoieA7yMqT/V+d+59/Vh0oSLEXfI4PheuajF+Wh3S7+pJi3xn6BomCN5Y84
 jEm81yPcbEUcHYgJstomeTzCrEBGuQK1fq0zHNJWXi0DS3knLfDy7liFH6w3A2oR/NFkO6WN6QI
 3sc2Z/xI7KayyDg==
X-Google-Smtp-Source: AGHT+IHHH4xPdtw41jIgYjPb7B0vRg52nB2Ft+C3qgS1y1Uygam5YCoWkNj51So3I5CCfLqbDNWl+A==
X-Received: by 2002:a05:600c:1395:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-440a65ed5e6mr15924525e9.13.1745575063924; 
 Fri, 25 Apr 2025 02:57:43 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5303c15sm19118325e9.11.2025.04.25.02.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:57:43 -0700 (PDT)
Message-ID: <b1ac7812-ac9b-4bcc-a04e-93dd43fbec51@linaro.org>
Date: Fri, 25 Apr 2025 11:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] hw/intc/loongarch_pch: Set version information
 at initial stage
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-5-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250324093730.3683378-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/3/25 10:37, Bibo Mao wrote:
> Register PCH_PIC_INT_ID constains version and supported irq number
> information, and it is read only register. The detailed value can
> be set at initial stage, rather than read callback.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c            | 17 ++++++++++-------
>   include/hw/intc/loongarch_pic_common.h | 17 +++++++++++++++--
>   2 files changed, 25 insertions(+), 9 deletions(-)


> diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
> index ef6edc15bf..fb848da4b8 100644
> --- a/include/hw/intc/loongarch_pic_common.h
> +++ b/include/hw/intc/loongarch_pic_common.h
> @@ -10,9 +10,9 @@
>   #include "hw/pci-host/ls7a.h"
>   #include "hw/sysbus.h"
>   
> -#define PCH_PIC_INT_ID_VAL              0x7000000UL
> -#define PCH_PIC_INT_ID_VER              0x1UL
>   #define PCH_PIC_INT_ID                  0x00
> +#define  PCH_PIC_INT_ID_VAL             0x7
> +#define  PCH_PIC_INT_ID_VER             0x1
>   #define PCH_PIC_INT_MASK                0x20
>   #define PCH_PIC_HTMSI_EN                0x40
>   #define PCH_PIC_INT_EDGE                0x60
> @@ -30,10 +30,23 @@
>   OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
>                       LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
>   
> +union LoongArchPIC_ID {
> +    struct {
> +        uint64_t _reserved_0:24;
> +        uint64_t id:8;

Why not use:

            uint8_t _reserved_0[3];
            uint8_t id;

Otherwise see commit ecbf3567e21 ("docs/devel/style: add a section about
bitfield, and disallow them for packed structures"), this might give
troubles on Windows or big-endian hosts such s390x.

> +        uint64_t version:8;
> +        uint64_t _reserved_1:8;
> +        uint64_t irq_num:8;
> +        uint64_t _reserved_2:8;
 > +    } QEMU_PACKED desc;> +    uint64_t data;
> +};


