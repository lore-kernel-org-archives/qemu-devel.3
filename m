Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369DFD729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4QS-00057b-3M; Fri, 29 Nov 2024 12:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tH4QJ-000572-67
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:04:55 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tH4QH-0006s6-Dy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:04:54 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724d8422dbaso1872956b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 09:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732899891; x=1733504691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q6K2rjw7WXlMZACJwBagsF0mZvejuZPmKPuq0ivQfaQ=;
 b=ehnztCV5A2/kRTDbPR0fUlB65muGxgAGHo/mqWR5QQ516kjgl7Syt2p0YkQm0rM6e+
 Wm3/00eNE+fY61fJPLbThvxeB073qY+vlmeCOZzzBMuQRR+lXbwgfNHxYtPJOj1STNUT
 3SD15Uz5un0yuCxmcFu+mNzQ4rB5RPZlSQ0dcHHQue+H8quLZUI5BIgFodsEdn9uB4NC
 S4ACKQwbSdBc1g6iu1oZgG216CCZLix3Lh3lBcO0uQZk5+RStta/YpMlG84h4jFo0VIc
 C6Avn4mbVe7osjoB5mm5GXi6UjL+Zs3I6LW/y+QBIduQ2bdeAI2pOJWyExJk5h3uLhkU
 pP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732899891; x=1733504691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q6K2rjw7WXlMZACJwBagsF0mZvejuZPmKPuq0ivQfaQ=;
 b=r1OsDJ6/J/rXbduet+ducH79kEr99CdxNJkIJg9r3nA93yQXMAdVDX7/too7ecegsK
 Y6ojyJmG3wLqvvasp1ble+ZuoS4s6iuJvV+Ba5noDvYNIu+lF7DmsV+ScMD7j/WrWIJv
 Hh8omI6NZsZK4Mhw43Da7VHB0VR7YgLE6unDsJn/kokkqPkjvraq3eiywjZo/jXqXUIN
 +eIUs1bkYW6HTL/hXcvWenhqdjN19iHXI01ufNjjgZmtcHpwyGfau3mPF7HH1KfsY1t1
 ZP+XjOT3xYa2XCta+QxmbcyPEFQT9pHw+yDS53vfGu9zrp7xEDPtx6k93l9XVXo76pP5
 QwaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsnTFooEqPzDUcI3PeFlGGcBwqs8kUk1l/eULeN3TKVSdGlY4RQqhq2jlq8JpLcTGBPzPA0NOfMG4q@nongnu.org
X-Gm-Message-State: AOJu0YyIMfJnk7vpzLwqB/0LbQNpQqMRQm3hjU4EYSrFm2WS+y3igPKT
 auOAoUy0/BSxuKYZpqfWIpRzSXWYd/6ueEeCOsAik1HhmdmB9wBPWBPvf3b8MP0=
X-Gm-Gg: ASbGncuTOS3bIiDykZ1n18U8w3miL63fJ5YP1BZYLS1aEDeL/L+OjQgK7ovYVtVsrHh
 JEJJlS4ld7j4EA30nS+Or/tHs9SavP9YuET1NPXA43EQ9bcM1GevqGpR86Gy3kYOlelXYkXo5/B
 KVIQf8pB3ceGuyInMZ8IgcG8cO2DAnMmFxg3WGpscv1ZjU1bMLO6t3C0t9bhAaJVR5cs92zFWA2
 /MA1ukAkWUNQOHx7bjM9d2ypRBDs+Ys92uAdMpkQdTvVsrwePhr23pWVNoOG/c=
X-Google-Smtp-Source: AGHT+IHKVIpKAb0i0P7kXiVT24MgazO+IsjvZBQg7XMYa95nhLwGDEeRjFrx9HpRNIKyOf9VGnKy/A==
X-Received: by 2002:a17:90a:d00e:b0:2ee:5111:a54b with SMTP id
 98e67ed59e1d1-2ee5111a7f3mr4924054a91.31.1732899890762; 
 Fri, 29 Nov 2024 09:04:50 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fad02fasm5524276a91.37.2024.11.29.09.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 09:04:50 -0800 (PST)
Message-ID: <bdaddb45-7b8f-4ef6-bf32-43b8248fd032@ventanamicro.com>
Date: Fri, 29 Nov 2024 14:04:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/3] MAINTAINERS: Cover RISC-V HTIF interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241129154304.34946-1-philmd@linaro.org>
 <20241129154304.34946-2-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241129154304.34946-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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



On 11/29/24 12:43 PM, Philippe Mathieu-Daudé wrote:
> The HTIF interface is RISC-V specific, add
> it within the MAINTAINERS section covering
> hw/riscv/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> IMHO 'RISC-V TCG CPUs' should cover target/riscv/ which are
> the accelerator-facing implementations, and each machine or
> device in hw/riscv/ should have its own section. Not going
> to clean that in this patch.
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1c4abed65..046e05dd28d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -324,8 +324,10 @@ S: Supported
>   F: configs/targets/riscv*
>   F: docs/system/target-riscv.rst
>   F: target/riscv/
> +F: hw/char/riscv_htif.c
>   F: hw/riscv/
>   F: hw/intc/riscv*
> +F: include/hw/char/riscv_htif.h
>   F: include/hw/riscv/
>   F: linux-user/host/riscv32/
>   F: linux-user/host/riscv64/


