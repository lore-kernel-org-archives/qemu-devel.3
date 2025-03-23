Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B0FC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 21:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twSyP-0000U2-RT; Sun, 23 Mar 2025 17:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSyJ-0000R7-KK
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:35:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twSyI-0007i1-2g
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 17:35:07 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1926929f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742765704; x=1743370504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I6miRfiPmdJipCLxfyq50Oh5OlziK8Kj+DGq1upZ7Ss=;
 b=E2AjKVQ/QuvocQJ6+YevXL1EZgT3oRXSPlrzjntUiZEmEbzm2Dmw62ssag+zuUcREA
 YRNjkJGdeanjJ+ft6fRyX//Jr4UptrAwloxb89fEUg0hGh+csuafTWfcp48DHIF0RmkL
 lB95BTK6/PttnQBb9zryk6m8+rQOUbNZ57Y4eBzGovdnoQZBiO+UEhxRqc+EovGUEAD4
 DAfL5vqgPFf35LssykwOOhAkCZ3F/H+uo4J+ib8Cv0J89fRemzLh8MxvExMf1guvTa2s
 02o/TXfxNcegc9dgjI2iBoysYyi/jNyU7B/9niALJFOgXECeiY85iQYH0yVyXehUKmMY
 j86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742765704; x=1743370504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I6miRfiPmdJipCLxfyq50Oh5OlziK8Kj+DGq1upZ7Ss=;
 b=ZpSjo0lOYq0kcecRIdkZVhiBzXn6XyU9DhCYkatWE0KNMBjleKAH4y9mlzyIKPDsgd
 kEoUFgWKi5Qyc0EI6yU8ARFEYRVYf3y/16wOJNsznSbnnj18KBl1zFtNLdpzha2MkUAF
 5+VCad4kW//InaM4VPHLArii9HBW6Xe9AeLrY0izmQ0+rPqkK0xhfFSBDljep18tInKm
 a6PAaiWiuXArGmXoo87+EXbBKIVzB9Sv6h0+7EUcG8ey7Exx9SdSaruC2rFuCDOiQfdc
 uLNNxDw8vx42UT+86qXyoattaryx9KoZWASyiFxOQ8Ge5h9b5aTmy1iYdiMTr7TJYVwG
 c4oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjPaJQ7rzZT+M8AHJPJsruaO/KaEk0hHvn12KxeT/ANeC4xCaO4dzgp2s8sBsJtSoKWa5oQrAefG3C@nongnu.org
X-Gm-Message-State: AOJu0YzHxSKZ6XV9ni2ua+U4qwiVypSfNnSweOIoKpI65YpDvLMlgGzK
 b+DjzMw3VnmVgoZHU35HojK8phZ+7G+6GSTR2/VRJnBBquOk4BzJBJqCou1S280=
X-Gm-Gg: ASbGnctLc59wRoofcXn+wqSYTaQw7c6Rr7FzzoDAOPt/gUKyQwMSskJCGvzLT0CQxdS
 PIEDs2KRCyFXopsn6pPc53XS8j5ZVq8iaqmn5ORSpth153hufodpQLx7zU4jMIIx21qMcmhD55t
 1gQY/xQYzMYMCOnGnHmb+fxOiYj6uYK+PnD2HRbkYioBw1K3EcvvmagKwAJ0/9OSTbMNkJeH1MH
 UdYXdtf43gitBHoBqroYbNLt6Uz5yi5mnZI9+vkDNV3B9xf9YoB/fEyJoua1+WK5UmzZnaNYBrE
 70i05aw20h2gvQZ8V7OOASjvmWDBRJpjT5IZPeqrcdAkXi0Y2cU6TiEH6QDWDBFMcLNNbLE4l2v
 MH50/X0rM0KI1OmAkaQ==
X-Google-Smtp-Source: AGHT+IGyVXQZ5i6k8ipYnfcfi0Niv6UJBNSR9xbhnBRUc0rDEGjQU+yh0fRSKud8ccJdVjYO1Tfy2Q==
X-Received: by 2002:a5d:59ae:0:b0:390:fbba:e64b with SMTP id
 ffacd0b85a97d-3997f9282cdmr9046180f8f.31.1742765704424; 
 Sun, 23 Mar 2025 14:35:04 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6667sm8938571f8f.72.2025.03.23.14.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 14:35:03 -0700 (PDT)
Message-ID: <ee521295-63c5-43ed-add3-cde4f0014524@linaro.org>
Date: Sun, 23 Mar 2025 22:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] target/avr: Handle offset_io in avr_cpu_realizefn
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250323173730.3213964-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 23/3/25 18:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index e4011004b4..538fcbc215 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -161,12 +161,14 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
>       memory_region_init_io(&cpu->cpu_reg1, OBJECT(cpu), &avr_cpu_reg1, env,
>                             "avr-cpu-reg1", 32);
>       memory_region_add_subregion(get_system_memory(),
> -                                OFFSET_DATA, &cpu->cpu_reg1);
> +                                OFFSET_DATA + cpu->offset_io,
> +                                &cpu->cpu_reg1);
>   
>       memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), &avr_cpu_reg2, env,
>                             "avr-cpu-reg2", 8);
>       memory_region_add_subregion(get_system_memory(),
> -                                OFFSET_DATA + 0x58, &cpu->cpu_reg2);
> +                                OFFSET_DATA + cpu->offset_io + 0x58,
> +                                &cpu->cpu_reg2);

Always zero, but I agree it is clearer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }

