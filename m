Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44735C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugid2-0006H4-A3; Tue, 29 Jul 2025 07:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugicm-0005wA-Kr
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:36:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugicj-0003tN-5H
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:36:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso56413375e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753788959; x=1754393759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WN5tZ1EymSZJjLNnM9AjMTtwS9C4dyCtem5Rpbudups=;
 b=gUm0UMjJj4k+1g5lJyCCeaqe1YT1tB57d0SVeeHm6XljGwUq5uiQBBpBOfoybV6ih/
 ZOtob+NbOBDath/INgOamcmb//elcJZuGyJvNwyK1AUdKKz2mwrZe330YUUiFTBAVKtW
 DwXsALq7YG1m1O0eMy8ca4REHCOP1u5FCO6C/jBnj0wcuGkXwldU4VnOo23lJLs4GjLI
 Tim24RDf5LgayjYdUy8EmsUAs7FvvUn/eoXybqeWolu5H+o/y+16FsmBBPkBWjlFl7ir
 Bz76J53j8QVNkFO9WVfShLoGT7d6L7wZaA9hkwkwx9jMqSpy/nvqfyFISG7WH8AYmbmD
 9G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753788959; x=1754393759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WN5tZ1EymSZJjLNnM9AjMTtwS9C4dyCtem5Rpbudups=;
 b=wOY2L9+unfdh35QYKDXNCWqUpb4wB7nvFMXXGF6E7kQte1nXq6XmGetjZdKirlprpS
 LwjWsDInjxM2dFR3fh7zwDGwXxm+BEfxUOI9gBK9hPauLKPE+pQdxWj9isJibktdszjY
 J+acmB2iD8oU/N7uWPORFQW/VFUvLge0jgYWDQfaHfcE/JAIY3PbhHTIWBTmUL8/RAsU
 4hi9GVZu2wKV5wt6AL7C67g0rQNHp4ZERfLBW7+S9zfZiv2BnrDW6QR5lDEKldAB01um
 jS5tB7uZUzpWIafj4I1CDr1VNGy/KL5A+G+XRPc/C8SXZcw5HlZa+0HcyTIieRdj2Xiy
 2q3A==
X-Gm-Message-State: AOJu0YyhYclPJ68acdIqelyaoxoB1+PnQA9Dc4Ou7zdsX2vUWRCLECmP
 ouCfev9oRbvxQi/xhPLWfbtFnBfuAkxpI9WqLm45Ml1cdB5lXJQXH58gr7jt/53J4L4=
X-Gm-Gg: ASbGncsXmIeyYdYN2XBxeNcZrXTvtSaAashuYPySe1sVQbGFLihWEdnuDRcp/vf5c7X
 QgevGSCMxVX//kj6D8bWbIU457Ok3L2a7lk37ZA2MMcM/4HaHDjQWpio5fvIazwdYdaSKB0QW56
 cgDJfJKxAfu9j+0q8Fndt0nvGwz52uObkUv8OGRa+mDOJidurukKn62qxIVVQkvAFzfOhuCuh0o
 ZsCJYsPlHNlIrn1NNmNDYxZiRGo1J5086pxQ8cBeMHoJI3IlpHQGW+POBTvmGkLQ1kFNT/Y4vCG
 l6g7fTW/CX4OI04TMcHEwVZwp8m8BM46KFxgttbJhCQctmSpNtGgvnZx0Rz6dxFhI1odihPYoXw
 7IN1/oGXgzwx2IBxiZnXzx2iTB8NgVk6PIMNJyzWu/4FRLNKOqJyGwnrmYFuJkmopl5d5aOm6wK
 nF
X-Google-Smtp-Source: AGHT+IFNC5Gt7aWnj9UHH4h8KHg4j/9sFqqZ7quQnp9FiLAR/Q940pxuO2HPgPlkFBa7HaaH1G4YeA==
X-Received: by 2002:a05:600c:1552:b0:450:b240:aaab with SMTP id
 5b1f17b1804b1-45876314354mr129432315e9.8.1753788958579; 
 Tue, 29 Jul 2025 04:35:58 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5b7692sm24147955e9.2.2025.07.29.04.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 04:35:58 -0700 (PDT)
Message-ID: <ec9da35b-fe83-43d4-ba6e-d0d09f425ec7@linaro.org>
Date: Tue, 29 Jul 2025 13:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix SEND_STATUS for SPI cards
To: Ben Dooks <ben.dooks@codethink.co.uk>, qemu-block@nongnu.org,
 bmeng.cn@gmail.com
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
References: <20250724133830.869623-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724133830.869623-1-ben.dooks@codethink.co.uk>
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

On 24/7/25 15:38, Ben Dooks wrote:
> When the code re-organisation for the SEND_STATUS command
> was done it broke the ssi-sd code which is now throwing the
> error "ssi_sd: error: Unexpected response to cmd 13" or a
> similar one in newer code.
> 
> Fix this by returning sd_r1 instead of sd_r2_s
> 
> Fixes: 807f6adac3773c18772bf ("hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler (CMD13)")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 80b59c8ff9..4472d101f2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1388,7 +1388,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
>       }
>   
>       if (sd_is_spi(sd)) {
> -        return sd_r2_s;
> +        return sd_r1;

Yeah this is what was suggested to Guenter previously:
https://lore.kernel.org/qemu-devel/e52b231d-f23e-4772-bfb2-08ddcc3e7ad0@linaro.org/

hw/sd/sd.c looks correct w.r.t. the spec; the issue seems to come
from hw/sd/ssi-sd.c "implementation". I'll post a fix, let's see
if it is acceptable for the next release.

>       }


