Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4654C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 10:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbepJ-0002lN-Cu; Sun, 18 Feb 2024 05:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbepH-0002lC-7N
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:55:15 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbepF-0005Zv-BS
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:55:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso2527320f8f.0
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 02:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708253707; x=1708858507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ipmxV3nOdx3h3F+O2aehFEDYqn1bKUDQSXjhDvzGmQ=;
 b=m2/DbTyx0IFknL5Oy5DAwddkhdT/zl3mpbwWI1WpOHxkS0lB268Lg7QJTzS0Z4Ve2L
 w02uVkrTm1X5BM+zB0Cg5rXrsRVneuNQvGoGxlMwe+I3xB+EgBXlIm6x3Jp8FGpo48Px
 wg6iLU2kZxIlGuKPJP96MAirKvtNcrhilrtnIte8knJHN7T7qjpXktGriQR/n+bA5rzT
 kbxtWBYjY7lavbckNDveRmGX5Pkji1oT9US3G0CIWzCfQHuzkoOTtHvFHyG09Uv5XU6y
 +rCX/ToPkXf4oQ6a/At8ILINSP5/oYD7RhXJeSsLdqWuOiPL0ZrU3OD53dAmP3ZSpU80
 hfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708253707; x=1708858507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ipmxV3nOdx3h3F+O2aehFEDYqn1bKUDQSXjhDvzGmQ=;
 b=mOlUhEwqPnsQU+guByzyo6dir0Mypw9QF0EU17fxkweMNl02WtoiWLXYKnMJxb2n/k
 cfqPxTwK9pJFENVjfa7nQETL7VUyth7aFb7YnaT/f3HNwaLaJn7Sln0Wuwpfwu40k4A4
 jw062PBu9bdcFVUChzjjTlUjLZ1FPadaLp9CgHwSRNUzn+Xyw3MtV3ZhycvZzNZYbtLT
 lXXcgtaid3X/Cf4ywyjWXo71v1329uKbmro1dvshe2OSM2n4Ioos5Ek9XwE+sjVCd/cx
 Nq4QHbWJVOILCOGQy3Uf8+QJD6YWsJFmpCInC3HI+v5huqG46Z4DHhDo6G1mpBpFUE29
 kggQ==
X-Gm-Message-State: AOJu0YwtXvUAExkAM3dw4Jf/TMQbNxge2Kvooc8vrMgPZ41vVZkmsu0s
 kL4bCr3ATQ+7Yu4eVPperkEb+4keZDG2taOPOmSnUD+mQY8bFoKizSyLK+UbUS7UnHEQJ/+/J0L
 F
X-Google-Smtp-Source: AGHT+IEas+CP8+InFVGmuhiJckrz36ZDMP2ocbFZYBXqWWlVI4bd/PiPTd+zi5lrzUNPjOUWRSt3kg==
X-Received: by 2002:adf:e448:0:b0:33c:e728:c88b with SMTP id
 t8-20020adfe448000000b0033ce728c88bmr7813308wrm.24.1708253706791; 
 Sun, 18 Feb 2024 02:55:06 -0800 (PST)
Received: from [192.168.69.100] ([176.176.153.199])
 by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm7035765wrp.53.2024.02.18.02.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Feb 2024 02:55:06 -0800 (PST)
Message-ID: <6e82c46c-1523-4902-bf68-f47abe2dfede@linaro.org>
Date: Sun, 18 Feb 2024 11:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sysbus: Inline and remove sysbus_add_io()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240216150441.45681-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240216150441.45681-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 16/2/24 16:04, Philippe Mathieu-Daudé wrote:
> sysbus_add_io(...) is a simple wrapper to
> memory_region_add_subregion(get_system_io(), ...).
> It is used in 3 places; inline it directly.

Rationale here is we want to move to an explicit I/O bus,
rather that an implicit one. Besides in heterogeneous
setup we can have more than one I/O bus.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/sysbus.h | 2 --
>   hw/core/sysbus.c    | 6 ------
>   hw/i386/kvmvapic.c  | 2 +-
>   hw/mips/mipssim.c   | 2 +-
>   hw/nvram/fw_cfg.c   | 5 +++--
>   5 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index 3564b7b6a2..14dbc22d0c 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -83,8 +83,6 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
>   void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
>                                int priority);
>   void sysbus_mmio_unmap(SysBusDevice *dev, int n);
> -void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
> -                   MemoryRegion *mem);
>   MemoryRegion *sysbus_address_space(SysBusDevice *dev);


