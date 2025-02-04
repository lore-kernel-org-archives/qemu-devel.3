Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B971C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNPR-0004qH-P9; Tue, 04 Feb 2025 13:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNPG-0004RY-4m
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:12:19 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNPE-0007nA-8n
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:12:17 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38db3a3cf1cso16773f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738692734; x=1739297534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y6n4KRzeTHbK4w+XNxVWOELQISpUnvz1D+9zTHfaYRY=;
 b=muh4c5AwFCqdwm3Jh+xqCkUZ5qDh9P9REfPBmE7zr2aV3ZKXPkJHy/sqm89MuJbpqz
 Fc8QxIvrDJGMYbQS85E3TduQTyqtud1MxTM9IRP8WUHysmRXkP6r7N0AYHbjZKZFTSIC
 5ihaGkF+A7NjzT9DSw0hl+MkY8ClvJrAe8Veyqv6TZOkWIDHHzVGv9vI75iFw44EIFxB
 X03CvvZyrfd5GN3QrgJ7sElYfRr2Vk+eyJUT7LX36nzmx6QbVOFJM/OpTIAzZDs6expm
 HtQo5Cuhw5sEW8d/LdTbQ4xuROku5BZdVNhOxTDJ0nK3wvvcGxsLFJAKpe7J0d6oA6UX
 +SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738692734; x=1739297534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6n4KRzeTHbK4w+XNxVWOELQISpUnvz1D+9zTHfaYRY=;
 b=AkSqpLa4aBez6sQIW2OTdpAYDKDcVoqChsCuGZkYJiIM/03YLhdZ9s0h5AsVwDmytw
 6Ix3sQkjpw7/5xkQON/hHVZfUhV+8e4YC7ixsp6yd9IRlAOvXywBrft9XTV+ECDM2TaS
 IziCbx2mMfeotvtnao8IZzPneOex63WiGPlmlsWqETKwrdQ5Dp3vCfpUoorGQ+CxvYC8
 7buRp+OEFmBMoVYgW/6QPjVe548wwLywtq1PRLTg8EXTO/deFszLI/pnLYWJ7oxZuXQ8
 zpP4ELvemOjGLzwzKm0Q/QzsSNNQ/fXk5GUn3Qhv2/W1X0fH2RH3qlFzEMwGqX2PWu/i
 EbXQ==
X-Gm-Message-State: AOJu0YyiYC5dOoeLgo5HhtGQR/ID6z379rHD/YMl19CJHpZ/e9j1gdoz
 79Alk17252wdzpLhUsJvF8sYzQtplqsNtd8oDnpCnPoWZDZP5YPghMw7cPI20aQCEz6NdFQbH29
 K2Yw=
X-Gm-Gg: ASbGncssfi117dcWVEQMmpvaesnq7BvCd/bpyj42BkoCVfLLZujmJKREaETQJl8q+/8
 CvYD16/RAp+9EPVo5v3WhKbjYW0mBWJJ8jv3CMn9/jqmpsqGHtjsWFNKTPJq/McgX9KsikSiMWo
 Z6pswnmaOt+D+UWIaaZPgwAkTK3pzOW0UBPkC3NdexWkcIDmPzDjMQODZUWHtJekrsPHU0T7+eK
 BvHhnfcwHn2XfgCCzyrKkM+F7/c6lViH2x1ppEKH7XELOv6qUAwtxly1D4Ipc9XjzhwpL/TsiZk
 q3ZOWmB8ck/jqRvlqCc8prNilj8WLrrrZ05hAi+K4QBwE1CLZcyOovdJf3A=
X-Google-Smtp-Source: AGHT+IG6c5VXZ9qRf1qq9Q3QP9hhMRgOviUewRn3aO38/wp+yoZPJE7e5PMl2988x9oHzCbu9BD0qw==
X-Received: by 2002:a05:6000:1fa4:b0:38a:673b:3738 with SMTP id
 ffacd0b85a97d-38c519738d2mr23483948f8f.33.1738692733926; 
 Tue, 04 Feb 2025 10:12:13 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e6860sm197358125e9.20.2025.02.04.10.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 10:12:13 -0800 (PST)
Message-ID: <4c200141-d9c9-4a8f-832e-38f4aeeb0ed0@linaro.org>
Date: Tue, 4 Feb 2025 19:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] hw/ppc/e500: Remove empty
 ppce500_machine_class_init()
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-6-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204180746.58357-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 4/2/25 19:07, Philippe Mathieu-Daudé wrote:
> Previous commit left this method empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/e500.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 59208da87de..26933e0457e 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1285,10 +1285,6 @@ static void e500_ccsr_initfn(Object *obj)
>                          MPC8544_CCSRBAR_SIZE);
>   }
>   
> -static void ppce500_machine_class_init(ObjectClass *oc, void *data)
> -{
> -}

Hmm I think it is a left-over and shouldn't be necessary in patch #2.


