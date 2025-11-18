Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966DECEE336
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOJs-0004zC-Ft; Tue, 18 Nov 2025 11:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vLOJJ-0004c1-5x
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:12:08 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vLOJH-0005Tk-Hf
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:12:04 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-297e239baecso61575435ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763482314; x=1764087114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B/8t6ED9BvS2fPO4jZeW2Yt8HfoNHyuEXKQE1en/NdA=;
 b=CMZi6eyD06rzjMcGGeL9yfMQrSNrInN7+rV4w5InxULSIULGzCyr0MTLGjW3Be9HyL
 vcVMke8EZL7qyxTNgAdGgIL2/PT5Ur3hyM2xtryGnaHWOzRsPoW8JkEw/49y3Eqm7lv0
 WWyf67xjBmp76FxyVJ7lQdfhRlG5RZ8w4d4s1F0/I8fO5jGC/b7sCNgWA73BtGJp0YZA
 SvNN4mKchKtMyUU4tLPokY2UhFzJG9LsKx1ZLNtta+HgGo5luUQau56HYt7Edn220QpR
 7YKDGJB47MZzWlk4XWFTqJfj67s23Phj74gA7LBZ3shu1qTJMMMbi7XXnC+9ic3swaXP
 URcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763482314; x=1764087114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/8t6ED9BvS2fPO4jZeW2Yt8HfoNHyuEXKQE1en/NdA=;
 b=FyDdM1fSjyPzlZ9UB2aFKuSJ2xOJdAAndMo9RAg4W70kVRYP1iyqtW/BifUzfjBn5B
 /SpLu9X/yRMXWRVg3QRNU2CuGzUrIlrnwEcUQF25EJ64zPMGML6hASkujzvLfcZl5x19
 Bmdd5Jp4revnMwK5nBXfUJzZjWujq2PjPXabSL2RYJcduEnig63FQSTwDO8wpiyUFHon
 XPYF5zt/gDoX/PmqDY3JqJG84d+u4g5Enzal9xscygmxAOdgq9N3Ssn1kCpRdGUC6eBD
 umiHKa3bEoQZabQ/xcWdhtRximIea3b5PG4c0TG5QH571g3hitDpHKOj7azweuQbJCxe
 HNZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG6Y9Irh6pLw1slqmxUWnnss7RslgHcPGLieez701uGUiQmPSb6m8/pyORPo7MkHBR1bTUcYHZnSeU@nongnu.org
X-Gm-Message-State: AOJu0YwOjyZpo1al/E6wSdB4k056HCI/znqFVn4ebjr6o++gZyWzhyKB
 FjRP74zRQbSgGXQd3nqGRd6ZkJ3UEgIaYGnSCOQ82/7P4TLt81AMxHc6sEXsYp7j8Kk=
X-Gm-Gg: ASbGnctKHxYJyn/lYNVb8zf+cShRF6iVjTYi8meFxqLRyuge47s0yJRIcjyIgosN3yZ
 EaeZsNxO8Cm1FzUz8XpN/u44w9QcOUXygIxcv+F0vjHwf7EOY0/BzKfqZc0/IjCO1b1GmHB0+tE
 ve5nK9rMuYe+FT8gBhMbqEOKhl4KfQGrOX8BEfb12BbJguFl1Te0O9e9FucljWlBOmlrEQ3zeI9
 sTBH9j4vE/S+rVcmAbm/AEgle12fpEWctiJYVQruXsktqNHjJ+ZXsBAQxXPqcytmk/smDNGnGcm
 bfIimPohJAlBR69HpHy/PpTMtxg/Ritma3QWwDmnsWQJVgnrtqI6MYSjTEsMOJbwfvpM7ihCq9C
 /Iloi5nv8+0kA3eCCglWyXMsBWfs347lP+FLYoup/JT08wWk0ud50MeNMYhmfgsSnFX1aE5w0Ej
 0kzRCsJfhsaO6hDOXSLvrLmB4dD2zcwVnLw8Ti8Q1fB2jhro8oJJsj9gtjLq4dtWRIySHkMRxTQ
 AQ=
X-Google-Smtp-Source: AGHT+IGbsGo69AUJ8pQx7W1HXgKH6BOWjjWBgyOesk+Co6aFWtYMxNSeH6nPpbuLLnqseheivSgf7g==
X-Received: by 2002:a17:903:2451:b0:294:f6e5:b91a with SMTP id
 d9443c01a7336-29a046f1da0mr256765ad.13.1763482313662; 
 Tue, 18 Nov 2025 08:11:53 -0800 (PST)
Received: from ?IPV6:2804:7f0:b400:8262:bc80:a9f2:2dc9:3bd5?
 ([2804:7f0:b400:8262:bc80:a9f2:2dc9:3bd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bc375177be4sm15669566a12.19.2025.11.18.08.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 08:11:53 -0800 (PST)
Message-ID: <e54894b2-635d-4c8e-9781-ba0bb4729361@linaro.org>
Date: Tue, 18 Nov 2025 13:11:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] hw/southbridge/lasi: Correct LasiState parent
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251117091804.56529-1-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251117091804.56529-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
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

Hi Phil,

On 11/17/25 06:18, Philippe Mathieu-Daudé wrote:
> TYPE_LASI_CHIP inherits from TYPE_SYS_BUS_DEVICE, not
> TYPE_PCI_HOST_BRIDGE, so its parent structure is of
> SysBusDevice type.
> 
> Fixes: 376b851909d ("hppa: Add support for LASI chip with i82596 NIC")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/misc/lasi.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

oh, right :)

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


> diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
> index 04312d0b589..0e95be1c32a 100644
> --- a/include/hw/misc/lasi.h
> +++ b/include/hw/misc/lasi.h
> @@ -13,8 +13,8 @@
>   #define LASI_H
>   
>   #include "system/address-spaces.h"
> -#include "hw/pci/pci_host.h"
>   #include "hw/boards.h"
> +#include "hw/sysbus.h"
>   
>   #define TYPE_LASI_CHIP "lasi-chip"
>   OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
> @@ -63,7 +63,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
>   #define LASI_IRQ_PS2MOU_HPA 26
>   
>   struct LasiState {
> -    PCIHostState parent_obj;
> +    SysBusDevice parent_obj;
>   
>       uint32_t irr;
>       uint32_t imr;


