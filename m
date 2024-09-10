Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9F4ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuqF-0002Pr-KU; Tue, 10 Sep 2024 02:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuqD-0002HC-Ty
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:59:10 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuqC-0007gI-9F
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:59:09 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so385722066b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725951547; x=1726556347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZGaskGv33OS4ZJUw/8+n5ARjH/33/Y1wa5brevBDsGc=;
 b=R06LmEvIEKgFyMaKn6kFY/7WYM9DTGrRy7KiFM2QLU52OkuH8VKZ3xJS/8wzQ9q+Mb
 SJ8ar3fGdGyWUlOOHZGCCxVhDNJRxW/C+XA5Bg3W5OR/3EH98GTat2WTuU4cfz8G4Qst
 vvaqdfr5dCbgy13dODloYC7CzsiF9A/V0GaWgVJLQgZYHLi+TVJXsX2xwueXaJQYrRBz
 nqNkUknIFzj4h0gp3RIdUgHdiMMa4+nAv3K2i9qMxwffEKI3+qeVsBcyu1+xmnV2Z5Av
 fnqsAao8Pfe2g9R0Wba0O63AgxkZyafYIqfOKAFkTmrH8MC3K/3d1KQlFXEgdLMr5CRT
 c+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725951547; x=1726556347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGaskGv33OS4ZJUw/8+n5ARjH/33/Y1wa5brevBDsGc=;
 b=nmagF0XJr87oXkvUrM7uR0j9XHUmzWvCheIsjHj0qAxhre55W59RkLC9W+uoWCZ+Eu
 5kQt/0xyvQ6tTdAhGHLh1WUCtXlHwLEc+ORjywRudtvlTHG3tB6jHp4ok6HU7atZQOJB
 tZpVzLg7RTLb7UwDaExJl0EO670xjswUVyMTuMbZ3yOZAEvmSacu1wi25Yusq3Qy2+oK
 9ioBJt6aj3Leqo1atgXmpfBQ9W4TNaPoMZ4BQYubBEryl11s51bF66Jg66ueaEg3wrFe
 BEQsLdhnvGkXm+lOK55YXVhYapdIWbESl0NJ69oTCuxd+Qf0YJLf5vz1aD608hkuQpyk
 +6GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMTB6VnOhmkoLW5STeuuFadsmCX6+q61Vcc3nAwfG4LFhxae752OZe/d4C+zJR9rzKIehIUJnYAo2P@nongnu.org
X-Gm-Message-State: AOJu0YzPsZo/tbwDGQoEvkfZg0L8i6fV0vd+3dVRiCR1x7www9pxI6oB
 Ka6H7gENjcEfVcFN+VeEaDT/+d18Z1FCYa6Kl11l8ABzFVK0gGw3MG1Z7kwnjjWuUM/WPGqWy6+
 k
X-Google-Smtp-Source: AGHT+IGdpso+D5a9xS9sWimo3GV49rmGCjvytxR9QP8wN4HRZH8N8CHSTCd680C0/+DdE4HQ5vbucw==
X-Received: by 2002:a17:907:3f83:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a8a885f8046mr1214236166b.15.1725951546576; 
 Mon, 09 Sep 2024 23:59:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c61240sm436928166b.133.2024.09.09.23.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 23:59:06 -0700 (PDT)
Message-ID: <366309d7-7f70-4073-aad3-bf1454f8fcfb@linaro.org>
Date: Tue, 10 Sep 2024 08:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] tcg/i386: Split out tcg_out_vex_modrm_type
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240908022632.459477-1-richard.henderson@linaro.org>
 <20240908022632.459477-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240908022632.459477-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 8/9/24 04:26, Richard Henderson wrote:
> Helper function to handle setting of VEXL based
> on the type of the operation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 38 +++++++++++++++-----------------------
>   1 file changed, 15 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


