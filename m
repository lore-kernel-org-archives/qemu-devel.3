Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139DECF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTw9-0007bx-Ea; Thu, 03 Oct 2024 18:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTw8-0007bc-M8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:04:40 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTw6-0005t5-V0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:04:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-207115e3056so13544645ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993077; x=1728597877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/AWLh8DpbVrqbWuKOyEAhIitSVZCLGR7kgeNMBJDwZo=;
 b=BfsMQekuEfRYEoZr06F6xwPAc++TJXMK5Ol7X9F6tKW/rsiDUxisFMSLjhlA8H0fNq
 RQROoK2dflin7F4RxnxCBPIvgYq7htzHpyrKzXYEcXDXQLZ27HoH+5Aas/5G5R6dVdF+
 PCheDbhR16uToTUl5vRE6DjvmD6Mp87jrStIcs1TppxMXeP/TfMnuX2yPKtVQV5D/5k9
 iPFLyCSgc0stNz2TbmeydcP01Pzdi97xYjfpysoRBdWxZn2gEcxJFCTdXmjJguODVUro
 Z4d/QDKVjqty2BsLIeKkBRNJ92ISPdmUZjGuHo+p7ijQOhv+1ZxRFuCS8xr/kEsDXoNH
 P30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993077; x=1728597877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/AWLh8DpbVrqbWuKOyEAhIitSVZCLGR7kgeNMBJDwZo=;
 b=E2sP+n9fEhCz77zOOpfGrfSIkj35OfH1bOOtSZAKhhA28cCKuYx0WGi7ulTmYFQirO
 kvpd/3MtBuG/h5rXy5ktU0P6AaZnMMQciaiHJlCb7E6DsiJ3jnvG3glG3ZfleLkTpDkF
 r0IJT3UbTlrfik0cB+GLvg0qONVtzcEAg9vf8K6p8Bbaxt7CxmEGZJzFyWlC+NBfn7EU
 1VDaVN1VNcUU5c+eNCzZw48DWwYgG8634gia8zELQqo1rlNoV4CnGv9HG2NPV6Ei9vsJ
 dj7/NTE6fdFvs+1UJRTsguVyXUEPdXMSezFMf4CX7NvxofY8cipfNZ4b5CglS0TkO9w4
 t6jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKPGAjWLXWT/HZuMERBdrdHbiK+Pk3jOaoyHP1KK2uGLIW+AMJy96sCtaNPn5vY5MK16ijETQKBybJ@nongnu.org
X-Gm-Message-State: AOJu0YzDk6bkTr2oItgM5ZHeNDCXIBj21OCvpMiPiYTrcsx5TCeM4XpA
 Cb4bqxPodiYq0e6JcdVHbUHN4iz5lgtJVhNPnVW2041Ei/sHaYEOcD/LNe7qp7E=
X-Google-Smtp-Source: AGHT+IFpIC5jHFpGAlG+G54myKK0r4QOJp4/Lv2CcM5fMnf5vb0BSWEY7gS57DPf75F/wdd6ecE7ew==
X-Received: by 2002:a17:903:8c8:b0:20b:5808:3e29 with SMTP id
 d9443c01a7336-20bff1dc073mr9644565ad.58.1727993077224; 
 Thu, 03 Oct 2024 15:04:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beead4f18sm13506575ad.38.2024.10.03.15.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:04:36 -0700 (PDT)
Message-ID: <eac7b54f-26a3-4881-b889-5fb79f8104fd@linaro.org>
Date: Thu, 3 Oct 2024 15:04:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] hw/pci/pci_device: Introduce ld/st_endian_pci_dma()
 API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930073450.33195-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/30/24 00:34, Philippe Mathieu-Daudé wrote:
> Introduce the ld/st_endian_pci_dma() API, which takes an extra
> boolean argument to dispatch to ld/st_{be,le}_pci_dma() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> TODO: Update docstring regexp
> ---
>   include/hw/pci/pci_device.h | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index ff619241a4..dc9b17dded 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -300,7 +300,29 @@ static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
>   
>   #define PCI_DMA_DEFINE_LDST_END(_l, _s, _bits) \
>       PCI_DMA_DEFINE_LDST(_l##_le, _s##_le, _bits) \
> -    PCI_DMA_DEFINE_LDST(_l##_be, _s##_be, _bits)
> +    PCI_DMA_DEFINE_LDST(_l##_be, _s##_be, _bits) \
> +    static inline MemTxResult ld##_l##_endian_pci_dma(bool is_big_endian, \
> +                                                      PCIDevice *dev, \
> +                                                      dma_addr_t addr, \
> +                                                      uint##_bits##_t *val, \
> +                                                      MemTxAttrs attrs) \
> +    { \
> +        AddressSpace *pci_as = pci_get_address_space(dev); \
> +        return is_big_endian \
> +               ? ld##_l##_be_dma(pci_as, addr, val, attrs) \
> +               : ld##_l##_le_dma(pci_as, addr, val, attrs); \
> +    } \

Like the address_space_* functions, I think the endianness is being handled at the wrong 
level here.  Improve sysemu/dma.h first.


r~

