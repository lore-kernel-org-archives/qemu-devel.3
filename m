Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B917C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hbg-0001KD-7k; Tue, 22 Apr 2025 13:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hbc-0001J7-4I
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:40:25 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HbZ-0008Bi-C9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:40:23 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so4185125a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343620; x=1745948420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XuXRAd1cPt/9KdSTnyTZupq3L6ijAXPISCHkl56lBLI=;
 b=R+MjrvoQR7Y6cdmw/9TaU2pUKq8ZcCUHsw6ezZhNAy0s+JtKkWKK5v0KbIx76K041Y
 N/0wUZj/MHWf5KTk9aPj7QgbE3AEFjjY8gA+SZfZTej2Gkue8ZWTExRoYHkBeEONYtaD
 binVyl5aPm84vXpRav8hEXIvcN6VzI98jdtn5s4V7kXQai8XJbdqxr+6fIWhnXQpzKJy
 YoRZ/lrEnFdCUkQeHnx+kabDYsd9PJxhIFMzCdRCwerzOwd8WpRiH33+rWSUoY3Jl5gw
 Y+FguNQVbwqpBo7aPYGRwE/1EpWXeeFrkLCujGJDxDwFPZ+BJ9En87UYj/obFQOjtojB
 VLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343620; x=1745948420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XuXRAd1cPt/9KdSTnyTZupq3L6ijAXPISCHkl56lBLI=;
 b=gRcuUVOlfkmNaHnfV+Vkn1xcQCkkTGqsoSugxHA3FesdHvQIafNl//3nBkHxxjlcYn
 GK2zwi++4eGUU3Rq+oTIiw4DvwFgIh8ij16OVKtMxBTR4n77UirHGAhKpnjqesMi/S3P
 lgP7wB+Z+/T/mpqW5S1+oKbKnvIBTAvAdul4uAxqK3EBAh1P/Eid4Z3uklur8Jh2Jyo2
 6rqHT/l+6qWQ7CntG3TNK24kDNd9C7qbok2+wWFkCcrYEJvegOkrfo7Wd8xqEokY2QoM
 o6EpIPsAHuyygUzO0XiAR3C9kIHY1lCpB/ML74KkU79yyIteXG6zWfNv13aivk6dzqEu
 l/eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3u4E/qt4ymyVh1AZwszFPXUOcLdLJ/V6cN0h1Y643DxuN76/E3sIfwr+XB5k/rpaqFWrHELfJbzL3@nongnu.org
X-Gm-Message-State: AOJu0YxC8CUSd8GVHxpPFL23zaHK+DwAdtKFwnC7tOu9XHLXNM4JAdJh
 tE5EBIBqs14+OT7p2chws6mNxfWmNJ859NY+qGSHhjx0MQI8BjxQqIz8dzIU2b8=
X-Gm-Gg: ASbGncuIF1n4Hl8cpNvEeZNcNHCebfVedw7vH2n4WaeKgaMzVfYeYesF/xWVQpBclrt
 R30F+iEEt80KpA7MGlp33aFexbbnh+RAr9iVfHu3oRD2Qo969Olt2lxZSCsFgkZW1BC/wbuNHd8
 K41TuDmlS0D9iDZcyg3TbwW3mAnWJDSTZX66yPSb5K8LU0I1Oj935TzO16obQk0VPHbP5M7gW3E
 wrvEzMHX6Q85kYZWMsHmAHOx1iq5gut0QzEUrdc0r6GU5gXZm5OxRtsqGId54HYtc3hmMh4ZXyb
 9OD/ITB9IJr/wXEwPRcXiJ/ypVMHlaMJSFJi70ZldIjwJ3fKiYG2itIqVKq9G2VQgEAb6hz5ZFg
 sDFw9B0A=
X-Google-Smtp-Source: AGHT+IGV3B7aYqkUOhTj6wcUv0O1zM9yHWZKrOwJle0stQnQ5XAWSX6Pe5gEJGHvwq9DPsK3SdsBjA==
X-Received: by 2002:a17:90b:570c:b0:305:2d27:7ba0 with SMTP id
 98e67ed59e1d1-3087bb2f6f8mr20127017a91.6.1745343619672; 
 Tue, 22 Apr 2025 10:40:19 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087e04a94bsm10157037a91.40.2025.04.22.10.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:40:19 -0700 (PDT)
Message-ID: <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
Date: Tue, 22 Apr 2025 10:40:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Since the qemu-system-aarch64 binary is able to run
> all machines indistinctly, simply register the
> TYPE_TARGET_AARCH64_MACHINE interface for all
> existing machines under the hw/arm/ directory.

"indistinctly" is the wrong word.  I'm not quite sure what you're trying to say in order 
to suggest a replacement.


> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 82f42582fa3..ce4d49a9f59 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -15,6 +15,7 @@
>   #include "hw/arm/aspeed.h"
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/arm/aspeed_eeprom.h"
> +#include "hw/arm/machines-qom.h"
>   #include "hw/block/flash.h"
>   #include "hw/i2c/i2c_mux_pca954x.h"
>   #include "hw/i2c/smbus_eeprom.h"
> @@ -1760,91 +1761,199 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_palmetto_class_init,
> +        .interfaces     = (InterfaceInfo[]) {
> +            { TYPE_TARGET_ARM_MACHINE },
> +            { TYPE_TARGET_AARCH64_MACHINE },
> +            { },
> +        },
>       }, {
>           .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
> +        .interfaces     = (InterfaceInfo[]) {
> +            { TYPE_TARGET_ARM_MACHINE },
> +            { TYPE_TARGET_AARCH64_MACHINE },
> +            { },
> +        },

Don't replicate these anonymous arrays.
You want common

extern InterfaceInfo arm_aarch64_machine_interfaces[];
extern InterfaceInfo aarch64_machine_interfaces[];

to be shared by all.

As a cleanup, we really should make all of these const.


r~

