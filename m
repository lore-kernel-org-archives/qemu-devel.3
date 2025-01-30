Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA831C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdckm-0001FJ-9z; Thu, 30 Jan 2025 17:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdckk-0001Dv-7C
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:11:14 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdckh-00070X-LU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:11:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so751877f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738275070; x=1738879870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L0tx4pUH+PghU+NCi8StXWqsKto4DjFi9YNkvFHPRco=;
 b=z0iTae0ds3KsNcfRnK8OzKARYJE32m0k50LJ78YqrKFO5sJMt7+1+ltQqnNDB4vwEV
 IwOe5/qNz/H2ErKbs4ELIReJDijaHOWwrsX5VlcxrPCgpn70vwbhd3UR5LdgIwe5eB2k
 SkgwibctSsuCsd4dIbVX6wm6guZvhd9VKPdsp3eZRALDX7+yE2Xgs4Fq4aMv8+AM70/u
 Y+fxQHra3m1OJq59b3G+xapOHbequdySrsGuERuEapGDuJULAUqO5ZESosXyzewwJX2/
 AYjEq8s0/WBltxrOIRVYB7M+4M56KaP8kIrfWqSlZ9BydCzpRl1E12MwZlAY7XQg8OMI
 v9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275070; x=1738879870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0tx4pUH+PghU+NCi8StXWqsKto4DjFi9YNkvFHPRco=;
 b=CjWB974f3Pw2Ok8bMl1jbvRciMs5szJYB+3ScCCHXkzziTVYWgVyFWFVfbDjdUS7Oc
 SJ9I/X1wPyf6H14xdoytL1oa+tKX34TjPYB8+YGkQ8BkYiQ02ZJt3zkx/bOWbK3rI31R
 IY5h0bnzLlg4/zRCQxjpmhO0x1Igtu96X4xqeUpzB+bPk43MzcuO+58UqMEWO2BmyUYQ
 hfwNp3i0cGzYe/4gjw89vlaWuE/X8gY4ssSA4hqdD0/B8mBKtfHBjlupPNrJ8cKt4AHr
 7Jwvb7W+wVkfZU2KhEaktISGWjL0ZgpOcNmIX3Rz2ZVHrITal8fy1X68WXdJeY68lso4
 2p5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4SiXAgVFsSBzI9xHgteB0oQswIdFvyMfzTkI8xcsTNe/DU9W94OPiuYju6CfW6xgOYBBkXAtLsLkR@nongnu.org
X-Gm-Message-State: AOJu0YxtUM+8I0da68F1Y/I6dg0vLEsVuKUh2BVC9wjYSWEKk/x95lsd
 HD1IeJfJRcZuyDAS0CnXYDtTppF61t7Eh/twVN3PiVtlrEtE48u5SBQSH0s5ZHM=
X-Gm-Gg: ASbGncv/d937uGcnj+hJhOoZtk/Lbh+fF1TZsMnuEf8nPpff/4EeAwB1E7hUcVD0cYR
 DmjBZOwI9mjTiqvRMsERphLT1Kz9/ZvQlC0sqQi/fKkPRy7VkpiWiG6208G28sMKggvxiQ/hSzg
 nO7hHLaCfVBVu2/5haD/MmQ5zD/S7xXvwYQ+NBzJcmPwpBf31TzB0xM3KQC93WMPHQ9mvDTpSBV
 Q2dkUPbsAopojwIQ39r983vlnFt/4ATUfWBjpy2OcNKCA/qujEcjPGV1/5557m3cXvPQZ8SNx34
 986WZkaJkgE/Jy6zS1S57JxirXlcs7gqkQif11o8El+tZUMQRgR3ZcVKnqk=
X-Google-Smtp-Source: AGHT+IHdtT/tqv2PZYAuJSpOej63rpFg0EVVudrBE2xFUAHhXlqeHGXSqqPKTZzZMd0IDCHr31amYQ==
X-Received: by 2002:a05:6000:1f86:b0:38c:5b62:9fdf with SMTP id
 ffacd0b85a97d-38c5b62a3b2mr3652455f8f.31.1738275070069; 
 Thu, 30 Jan 2025 14:11:10 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec35asm3137123f8f.15.2025.01.30.14.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:11:09 -0800 (PST)
Message-ID: <e2359748-f251-4830-ac1c-e4fff397c1b1@linaro.org>
Date: Thu, 30 Jan 2025 23:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] hw/arm/omap1: Inline creation of MMC
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-7-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 28/1/25 11:45, Peter Maydell wrote:
> Our style for other conversions of OMAP devices to qdev has been to
> inline the creation and wiring into omap310_mpu_init() -- see for
> instance the handling of omap-intc, omap-gpio and omap_i2c. Do
> the same for omap-mmc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c   | 15 +++++++++++----
>   hw/sd/omap_mmc.c | 22 ----------------------
>   2 files changed, 11 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


