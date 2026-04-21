Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A231F94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJ25-0005Lw-IL; Tue, 21 Apr 2026 17:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJ24-0005Lb-0g
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:53:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJ22-0008AG-IY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:53:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso48784525e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776808401; x=1777413201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UqLyr1J+lx/ZzlqdjcaZWPDNBSVjXdb8bkjn4LRrsBo=;
 b=L0uD8kHh3ytazyrDTMbkm2DEv7KofmnFHbf8zHfY150qPPtH60fEmPMtKPSmO2/aNo
 U7tb8EaOPF8teztPdjU/xVJq6UZx8Y2EsX7kR7Bk4Vb84y2g26dsZ33U9mK51ka9Rihs
 M+6Zrj1VqiOZNvKArYxjTzDcVyFQX07s4BNHNICwH50axjVEtaS6RpcuJ9jsHOt6rYea
 QGySy3wZqEKEp0F40GambI5PdxkQfM+Frvb91Dg/bqLRZV+yTye7oz7spYyMua8fV4w9
 GsxgXwjHwySZU/2uUDkEu6vz1qTZhrwCkAUJ5zpfQeWzmEP2BBAxkjhX85fzmFWNEsl2
 juLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776808401; x=1777413201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqLyr1J+lx/ZzlqdjcaZWPDNBSVjXdb8bkjn4LRrsBo=;
 b=mQv1WDQ7pQQkjn5E+b1a7Xe1LzfyolwfSn8k7JSmDiFEOGBhr7zObOYSa047FTNO8b
 H3vwRwNpgyJVbhUF/vp+2eNSJQNeSi7lQU46vLYE+BHaobT9wCl2C1F8LZ4Kbem4sruo
 5gkW1pqpNdrHUYtJ/JxMSpkt+jeXfLGnA5vUTYhN9/CQqzF/QKKjfKaQQwyWvMphz9tY
 PR4zK/mNNa+3GDpgqZKHxc/wAmmIsbqWprEBYvjm+7NwoLSWVb4bMKs/PkpbXo5tK9D6
 +cnF1SpOK56l0MgbGZbf2UX9wLa1/9ts7XxkqXs79fctwLTO/anz1erGjkEBT+tpZQIl
 WDxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nYKmzKv9u65tsUhgbUBIZE6GJk/0QACTrhUXlxbc8z91kQONN+FwsL17Otu1vIQEJ0+AT1YPrFg76@nongnu.org
X-Gm-Message-State: AOJu0YwKTUKJHRg7+l6JEwOVA3QoLieQAigTTNjxOWbclCAK2XvhFIQQ
 zlyArra1mkz/zGBAwc3qwqWaWaUyD087qDFmQkMMaLqgScoiWvtC12qjzFqtf2RXcAU=
X-Gm-Gg: AeBDieuRekmmx9MbE/71DlWR9OBlXpnzusNVx4RAT/3BqhDky7ikNBVIbmHSUjF95lm
 +zus0GIVJOBSrz03zOUANAtqr6x9ia8P01IaSZixKLssutc6oYUrDXoiHs4pMGvKtHpdQ9WGAKP
 PAt3MjTHrz3uWiXVg7hwhUflkWY+RVlsVIkSuZMeiVesT1/eRDB2J4Vkq1x2CQ5Lt/c3hO0dXDa
 wNUNXh7PdMltPXPOZcKtfkS+IVUNiRCcxaYHBm39QAlt4lwUVqvH6A6BaTZbbO4Q8/j2RiuFcy0
 HDwSQktlpsRjDC8mUF3yQ1+xdqZcOXM6TSteQ+A0OvSo0WnkFAUqW09DzLN6rIw2v4CUuopn+Ah
 z8zHdnmKXfBmZxocDnErswpaznz+jSDxOKyHi8j0DuY7tenswpQ99ok3WLQwL6+R7Q5hnXLzBGc
 F5DLxOs9Xl+Lfe9w9cUUl7Muv7mRHwxpOdKuYJf5Esgp/3mTFEtkv4voeKFPIWDujdAmcThKqJQ
 MEA
X-Received: by 2002:a05:600c:8909:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-4891b10dd45mr147273185e9.0.1776808400885; 
 Tue, 21 Apr 2026 14:53:20 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm42570341f8f.7.2026.04.21.14.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 14:53:20 -0700 (PDT)
Message-ID: <4c554d3f-f6ec-4c01-93ef-1f7eee3d4349@linaro.org>
Date: Tue, 21 Apr 2026 23:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] hw/hexagon: Modify "Standalone" symbols
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-7-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/4/26 23:03, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> These symbols are used by Hexagon Standalone OS to indicate whether
> the program should halt and wait for interrupts at startup.  For QEMU,
> we want these programs to just continue crt0 startup through to the user
> program's main().
> 
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/hexagon_dsp.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index 649cafcf8ec..3c269feed28 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -28,9 +28,17 @@
>   
>   #include "machine_cfg_v66g_1024.h.inc"
>   
> +static hwaddr isdb_secure_flag;
> +static hwaddr isdb_trusted_flag;

I'd store these in HexagonMachineState mentioned in previous patch.

>   static void hex_symbol_callback(const char *st_name, int st_info,
>                                   uint64_t st_value, uint64_t st_size)
>   {
> +    if (!g_strcmp0("isdb_secure_flag", st_name)) {
> +        isdb_secure_flag = st_value;
> +    }
> +    if (!g_strcmp0("isdb_trusted_flag", st_name)) {
> +        isdb_trusted_flag = st_value;
> +    }
>   }


