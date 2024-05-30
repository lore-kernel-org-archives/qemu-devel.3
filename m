Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF0AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCa7N-0000Ci-TC; Thu, 30 May 2024 03:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa7L-0000Ba-Hu
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:22:31 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa74-0006UK-Sd
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:22:31 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52b7d180542so555281e87.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717053732; x=1717658532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o2EeA518C36w+iQ7h9HD8qUmE+N4G0/Tt/R6lPrURr8=;
 b=rCaeavA3dzw1UOlgze/NL3Q/wgRKkTUf1ipawTpKJc/hikc7km/YODthH/SMk7vH88
 UJI9m3XUsv1/QyDVi5oQsgUxD8BpTKH4i+5F5RLjUMLPm61Qi0ofBAJEG8WMT5WiB1bh
 tyAojDbHX37UulYdtB9CUw469/njSfG/7S3QwyNaaYkL9bpbYl8X8lK082GYpud8JrEu
 C94/RLhu7z13KLmIguF+Ou33v5oGTNa7Nozm6FUm1uCnoX0xepOr5+jSCfEsezGb6WQt
 jg0KK1dYzfKQC+sNnILP0ZUz40jxTA8Wags5BTC0lxl4wAez4NbANXMeUjsqEl8Vnsj2
 FUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717053732; x=1717658532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2EeA518C36w+iQ7h9HD8qUmE+N4G0/Tt/R6lPrURr8=;
 b=eEzqdKq65fhH/nfrjoJwmjZLNHq8S7OORYznuGyrqy0KXEsJFnEi6eA/vakB5C6U2j
 oYW5UxjDhI/b28e0X7vNaNUD0zOY2/OpReRuF0ju+LxGIG2/wp+3bHt0QaiuciMiLBp+
 fATBQnNi/0JtuGJKmML+mQz7XIU/syGdAPPKgt0gQsolxk/pD62zHGJPX+Fw+QbMzOIH
 u6X2tk/uq8jXh5eLc19KkuoLxsQi7St/R8vaQ5m5RalRYLHig97XsZoBeoroDk6bQmlC
 0eSZ2wxI5532Cshiu7YuXBxETVIWciMbJMiNil0Z+qyiHcHAzDqdRHETLKSVOrmfGicG
 Y5ig==
X-Gm-Message-State: AOJu0YyT8P602b4kklViaqU9r5Sz2ZNBAy49IJ/nX6S6t8MiwZcZRkzf
 RyWWO+X2Su2XYoY3oTGVYBFgdiWZxaBKtCkpOC8CB5q68YIm3Qam2xZbwxHUr0w=
X-Google-Smtp-Source: AGHT+IEkjSCBC3x2N9dxesTUsQWQiI7f63ttX1SEhqXJP7IsI59XzdYXiJchniB/tJNkQ726MuQeSA==
X-Received: by 2002:ac2:5147:0:b0:51a:ca75:9ffe with SMTP id
 2adb3069b0e04-52b7d47a4f4mr854953e87.42.1717053731400; 
 Thu, 30 May 2024 00:22:11 -0700 (PDT)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421270aeb18sm15723265e9.48.2024.05.30.00.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 00:22:10 -0700 (PDT)
Message-ID: <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
Date: Thu, 30 May 2024 09:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 30/5/24 08:02, Paolo Bonzini wrote:
> On Wed, May 29, 2024 at 5:56 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>> It is pointless to build semihosting when TCG is not available.
> 
> Why? I would have naively assumed that a suitable semihosting API
> could be implemented by KVM. The justification (and thus the commit
> message) needs to be different for each architecture if it's a matter
> of instruction set or insufficient KVM userspace API.

I wasn't sure where semihosting could be used so asked on IRC and
Alex told me TCG only. Maybe the current implementation is TCG
only, and I can reword. It certainly need some refactor to work
on KVM, because currently semihosting end calling the TCG probe_access
API, which I'm trying to restrict to TCG in order to ease linking
multiple libtcg for the single binary (see
https://lore.kernel.org/qemu-devel/20240529155918.6221-1-philmd@linaro.org/).

> Paolo
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   semihosting/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/semihosting/Kconfig b/semihosting/Kconfig
>> index eaf3a20ef5..fbe6ac87f9 100644
>> --- a/semihosting/Kconfig
>> +++ b/semihosting/Kconfig
>> @@ -1,6 +1,7 @@
>>
>>   config SEMIHOSTING
>>          bool
>> +       depends on TCG
>>
>>   config ARM_COMPATIBLE_SEMIHOSTING
>>          bool
>> --
>> 2.41.0
>>
> 


