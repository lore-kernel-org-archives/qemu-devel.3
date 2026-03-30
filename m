Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB3D1061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7KZG-00081c-8p; Mon, 30 Mar 2026 17:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7KZE-00081T-W4
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:54:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7KZC-0000zq-Tp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:54:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fb439299so46184545e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774907677; x=1775512477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WmOyTBXx7aQ/ZD4z3zvak4zeD46XWM2bHJpmh1k0l2o=;
 b=tZEyzKyjHo9TiPg+1fPkCnWtcFRQJCSfGYS64XgAsIF8mzXsLWIEPB1Xx6Tw8pFrr9
 TfInYx3QJVooxFtogOBwUWmrIywkNamr4AJgSzZwYmBLfq0B4mwsMhePeBP0gvDriAKP
 VBmOVM4atZs7Nkr2jmiT1/FhGvFPWVr8/8Ig8Lg9wtnI4256g9Byi0JSHkF9C+BFwtZ4
 F2Xs80F66Eo88sDDs9t6McC23O5uDd5UNvIKLPFiPGSbxB7TNOURSrUb8WC56e6dHvGs
 gtt+OxguQdiGvDuBJxrG0w+avyMVoH6tC6z3hU9atJQybp3u3RG2wHHFR7mfXhyEGoBf
 18wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774907677; x=1775512477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WmOyTBXx7aQ/ZD4z3zvak4zeD46XWM2bHJpmh1k0l2o=;
 b=FA4pMWcq8SD/dJrEQ7TdStaCj9cPAM3+yRv0/JszM9koRNYIrT8SNxOCbu8ghx10BH
 1yolnFf2W1wLdlLvTuQmI/pSeIzutZi14bC9v7SBktLyCz3L95FgWyE2Osg/AsizLnJU
 GOo1GLqLtxDvyUzaemwOT5Bq1Acps2b0tQCRjcOzNtNYZRLrgWYlhbER/SuilVbqKb2+
 r0qK6t1KvnqX/fcp5GU061MbAP8VuSbVST6Lbr+BghhJSXRsRHOC4zkUrxugAGTVEPbZ
 g9eipkyKJc3daG3bIzcEjLftrxJK6yzQRGuuA9u1t13sPNMgmLkbJ2Rm6JmT9UUeOYG3
 tyWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVU7ljZPDh8sjj7tsFJ4wtPb3ZHDtq0m0dAA4QbYZazMOop9QFyEk5IZZdKi0EJJKPeY38LT0q8Kbp@nongnu.org
X-Gm-Message-State: AOJu0YxHIDgaAeS3OHnoPHn/GcX9TiRWFy1rwZYgcdR9FjZYsciFTl8t
 JF1cz5FjgvDIPRUyw5/9fxPSGKftC8JP/knjvz9mEweKlmMqcJa3vxTY9EI1XAaIoFU=
X-Gm-Gg: ATEYQzzTOcVKWmDL3GD0BDKIKKL79YJWhw8mJ8Iny0BrP4TmzYdJtTa9xmvgOQ6tYSB
 hPU/jtaOzmdJ2to7JF+akwkcQNDsj0+bmZn1S4v3A39YXNzLh//W5uh3NyN1Nu5hCL74V+EHLrq
 X6YCKkMgP5VQ7PtFe294R7omnXO5O6YddvWhfAFE/6WlNFAnC8sggWoQW+lK1avUM8BDlT6Rpg0
 5OahrumqegMrt/oTEm0L9+I7wljZX/oB9zl7mmwWu4mREBO+QwPHRl1nMtDynqXyvb3SVEVDCx9
 7UXyrn8zC7aw7IFAXE7/2YeJJaIboLVHB49e9a7uF+L/TdnstyIUWn5cYFejAv7Wf1sA6XEV/Eq
 x25m7wvmR0WMDprnyT6JEfhlSV6rV1aaJidnztJ/9a1Gu+lPqV+hM7IsrQ4fvn5um+DI8Ye4etr
 L5zpe1tL83EfOe3A/ucHoPKRIzYKfkVVqFie+uU2u6ir7zAituSoKHLns61lrw
X-Received: by 2002:a05:600c:6287:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-48727ef1782mr247616175e9.3.1774907676882; 
 Mon, 30 Mar 2026 14:54:36 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887aab1ee3sm3347035e9.6.2026.03.30.14.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 14:54:36 -0700 (PDT)
Message-ID: <a0b4d43e-6798-49c1-9699-a25d260ccebe@linaro.org>
Date: Mon, 30 Mar 2026 23:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] hw/pci-host/astro: Add comment about Astro version
 numbers
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-9-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330211859.19317-9-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/3/26 23:18, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/pci-host/astro.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
> index 8c61c696bd..776267e150 100644
> --- a/hw/pci-host/astro.c
> +++ b/hw/pci-host/astro.c
> @@ -738,7 +738,7 @@ static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
>       switch ((addr >> 3) << 3) {
>       /* R2I registers */
>       case 0x0000:        /* ID */
> -        val = (0x01 << 3) | 0x01ULL;
> +        val = (0x01 << 3) | 0x01ULL; /* 0=Astro 1.0, 9=Astro 2.1, 2=Astro 3.0 */

Using enum:

enum { ID_ASTRO_1_0 = 0, ID_ASTRO_2_1 = 9, ID_ASTRO_3_0 = 2 };

             val = ID_ASTRO_2_1;

>           break;
>       case 0x0008:        /* IOC_CTRL */
>           val = s->ioc_ctrl;


