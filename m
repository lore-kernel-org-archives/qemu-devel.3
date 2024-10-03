Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F62CF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTTj-0000Jm-8X; Thu, 03 Oct 2024 17:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTTg-0000B3-Mh
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:35:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTTf-0006eE-34
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:35:16 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7d666fb3fb9so892624a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991313; x=1728596113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUMoZ4AXEREfNycTJNzhfxPsT3g/XsPhQpkrmIV6azo=;
 b=rKbXH/zn1t8eizxNVpW9ysDphhl7fQu+DIMEk5OhW51X9pYPlnYVObc/1A1OAczA0X
 LkvcizD+O1OG3N9sF4IXzdUckY4mHYKVSKllkdnVJ8QdsxQBmE+lQFwStZ0zGHHRidPE
 wHVAQd8hCTkEHUC+0qirlAhHQ5YiQX8+eg5xBTS96zyHJWR4jSgR97Gnvs6BzDyAXhJu
 ZCzXVtuqCYi5X4hBpaQT+eoqiz/+7jIdJGb/JytTAb3xWrfQMKwbVzNbBtBWl8bZWOX9
 MwYHeKKAo879f6R414SESbp71F50tLFLx3kApAYehYxS68UevYzmk22/+9jy/gJDyqET
 FZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991313; x=1728596113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUMoZ4AXEREfNycTJNzhfxPsT3g/XsPhQpkrmIV6azo=;
 b=ZoyoAxxKG1l1hZyUo/0LtTP/n8bdKzJHltKs6RgusIMLkfcSmzxPIsE38bhhnugagT
 XHKzfmfNYssRWA3c0AnDWySviKqqmdN/gDy+x1cp+FjLIGJVI2rIJh+Dhndwq500xG8g
 PKBCyVXVIwpFc3lC7RrrsnSIaXoWRFTrRX/zQCm2ZkMQWAL9vaxPsCElIvQVH/cMOBKd
 fjj8+bF6tMYOdS2PVLoUpMv4hHr+fBs2Z/9Tqx+H4XgaRKAQPdgtMqwKNNrp3X/ADVqE
 rXPDfJAoyPRJV0TCFLgDo3eWKBCQTJLvorK6p6RbFTGPHMOcRBE2lBYQ29FIl+lVuyGN
 9WHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd2fLjFbMf+wLZjpPVoZ6+3JjRazHlGsgdOryiSZVED8MzcD3QOnjjqBdMFJg4mV4F/XBWogwNGybs@nongnu.org
X-Gm-Message-State: AOJu0YyD1U7KYsMP01BXaYIWFCSNDaso7MA2Ix/56QauG0CKXGPTx7VB
 dLa1bMd9GkSUAuUL/DqkgwCgzYjnWHvtiGEMc9dFMvCpWpVQ8lhwiyClZQv7HPJpDOz35hVWtr7
 B
X-Google-Smtp-Source: AGHT+IFIKvSfe/P1mmbP9iMB4UM1pnbvucgctmx97X9xh97pq4Sxhs8AI4yMUlXPZoyNiemzw2I4wg==
X-Received: by 2002:a05:6a20:9190:b0:1cf:2d22:564e with SMTP id
 adf61e73a8af0-1d6d3a5a702mr6708517637.6.1727991312677; 
 Thu, 03 Oct 2024 14:35:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9dcb60518sm1160513a12.90.2024.10.03.14.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:35:12 -0700 (PDT)
Message-ID: <c592f4de-f6df-4363-8060-c1ac569e2947@linaro.org>
Date: Thu, 3 Oct 2024 14:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930073450.33195-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
> Move code evaluation from preprocessor to compiler so
> both if() ladders are processed. Mostly style change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xtensa/xtfpga.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 955e8867a3..228f00b045 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -415,8 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>               }
>           }
>           if (entry_point != env->pc) {
> -            uint8_t boot[] = {
> -#if TARGET_BIG_ENDIAN
> +            uint8_t boot_be[] = {
>                   0x60, 0x00, 0x08,       /* j    1f */
>                   0x00,                   /* .literal_position */
>                   0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */
> @@ -425,7 +424,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>                   0x10, 0xff, 0xfe,       /* l32r a0, entry_pc */
>                   0x12, 0xff, 0xfe,       /* l32r a2, entry_a2 */
>                   0x0a, 0x00, 0x00,       /* jx   a0 */
> -#else
> +            };
> +            uint8_t boot_le[] = {

Fix these to use static const?


r~

