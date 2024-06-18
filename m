Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D405EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZSR-0005K6-9C; Tue, 18 Jun 2024 10:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJZSN-0005JQ-Bj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:05:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJZSK-0003Ru-Kr
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:05:06 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35f225ac23bso5402463f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718719500; x=1719324300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cx7NBo/uziFpbQFcQsV1wyuyuUt+7AcfH2mrNHWJziA=;
 b=mlcRIiunWgviSc6mph08k9RVxmPqi/ngQ+dbAwuVcXttM1T3kd8xETWYfZgky2ojKn
 1SYSufLZWLHKjhayRD715DiB4/Za6DD6mVCLB6KlNF3ahkoSrDuVNOqcVP6zEZziOvUP
 VlMfmFCZNJSg10Z629s4tlLzxHpRctrYtSHvxh/2daCWRNo4uXrMLk+QDcph2dzs7BoB
 YXfSB3c2IP2bm0qeV8Lpng2i74FqvuoA2WLJI8cWyBnzIkvNuSj6/HsSHkYy4RirFpE0
 lA6h4EwW6v+zWWTY5Yj+4QZkW1WHAP7WCvkYGtK+ohntvoLU+2k4DDWSaVppYjraJZvf
 KmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718719500; x=1719324300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cx7NBo/uziFpbQFcQsV1wyuyuUt+7AcfH2mrNHWJziA=;
 b=aQDW7Y3xAlUeD1kXFz+j22shfrm1o3aEGYAWz3fcuZPSM7OdEZK00t1lHFbssAZfcT
 d4RFHAT1UzSVcyKQWwswZe0W0L2TKQPOZcLHyQ9lgNbLpBDwtkTJDxZX17N4AZMGbPJp
 CZa1UfhzEW3ANkK54r4QjMqzjE+EXodEoUvwetD9glr0delo7YK/zmifn5Sfjz6n7g74
 a6RwSJaGUF2kloV5Xv998Y1Y9sYdAeAf9XakvdMuJ/SZQPoRmDeYUT0Hwv5rUWtoy9Ng
 SNi+qxb3VkP30aS+M3OwOJ4xEywfXF0SEqbAa8MvEsqZMEFe7JQRCIZg8yxuPj4n7uv4
 tXgQ==
X-Gm-Message-State: AOJu0Yz5Vacc9DSKXK50cgLy4laQzo2JTc7pkC4wFxhgzogdsa+St5/S
 WvAqKvcBifghZ2xj5T9oqGTaJOoF5aTaowLLZJ93ZTDshsvr+pTCsTUO4dbXPMdpkLIcLwwACb6
 u
X-Google-Smtp-Source: AGHT+IH+AAG1xAGXSBQR2gi4fyqHmXSnqNszQYjYBr5OExtSRzlY3wuTfPrVfBEk/fHjhioWQ77a3g==
X-Received: by 2002:adf:fe12:0:b0:35f:2f14:b98 with SMTP id
 ffacd0b85a97d-3607a783420mr12141858f8f.48.1718719500309; 
 Tue, 18 Jun 2024 07:05:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c9a0sm14164508f8f.27.2024.06.18.07.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 07:04:59 -0700 (PDT)
Message-ID: <ef0941df-ab08-4e1b-ade4-843a46356112@linaro.org>
Date: Tue, 18 Jun 2024 16:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-dwc2: Handle invalid address access in read
 and write functions
To: Zheyu Ma <zheyuma97@gmail.com>, Paul Zimmerman <pauldzim@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20240618135610.3109175-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618135610.3109175-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Cc'ing Paul.

On 18/6/24 15:56, Zheyu Ma wrote:
> This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_write() functions
> to handle invalid address access gracefully. Instead of using
> g_assert_not_reached(), which causes the program to abort, the functions
> now log an error message and return a default value for reads or do
> nothing for writes.
> 
> This change prevents the program from aborting and provides clear log
> messages indicating when an invalid memory address is accessed.
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=qtest, -m 512M -machine raspi2b -m 1G -nodefaults \
> -usb -drive file=null-co://,if=none,format=raw,id=disk0 -device \
> usb-storage,port=1,drive=disk0 -qtest stdio
> readl 0x3f980dfb
> EOF
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   hw/usb/hcd-dwc2.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index 8cac9c0a06..b4f0652c7d 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *ptr, hwaddr addr, unsigned size)
>           val = dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2, size);
>           break;
>       default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, addr);
> +        val = 0;
> +        break;
>       }
>   
>       return val;
> @@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *ptr, hwaddr addr, uint64_t val,
>           dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2, val, size);
>           break;
>       default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> +                      __func__, addr);
> +        break;
>       }
>   }
>   


