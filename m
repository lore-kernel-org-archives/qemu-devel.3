Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A3DE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 12:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMRTc-0007wH-Pu; Sat, 14 Dec 2024 07:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRTR-0007ua-Vk
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:42:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRTQ-0001RL-5h
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:42:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso27213075e9.2
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 04:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734180138; x=1734784938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sSXe/kVeIK4sLLZI6qLyc/dOVuRDTQrAFwpmBKIt3TA=;
 b=Vt+oSYiEkn3knfQad8weqd+yE+cRfeSKcbxNw+WcdFCggeRdGYoGiq2jap7WFwz8Tp
 s8coTBKccN19Eb4o87QbexXbnfkdckrPFjquMbWMrQ7fa6wkZSBCnSsS25e0it28aLt0
 MRjgHXeqFwiTOt8V5He+/M8MI6uWfv+tHSYEVPpopItGtlaVnY51ZGLbX77vkV04QQIz
 z4uFiJPjY44uF/i2TfvGsqoqfAvi4gRgiGrvcgruqwhetDWfVtaO2Z+uyuQpwq0oyM9Y
 4PC5vJyxyPuySsK5amfwEsUV/3zWU+KXT5XWnB3H3ztzKYQL5gpQACcvHAxF6Rymnm3p
 XV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734180138; x=1734784938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sSXe/kVeIK4sLLZI6qLyc/dOVuRDTQrAFwpmBKIt3TA=;
 b=q8/EuArhCkaTAbo8mHJGWpAOYVvQrpvuPksTAUPPf3bZO17KhF1aooSB2H5/MQ3k3o
 aVCtdQxG5XCL8MHjgMkLCDCsozwIyZZPhndkX2QCpKo6E+Pxz3Acm4BYhI91YYAcJEHm
 epHPR3smRZ4HopmxWUWfENwZGwL2tFopFnbuClPZjmtBFD8LfWsVHJ97aUlLFteQmtI/
 Wy5Xu2H7tw+LB6PW/IsbnCnWG9IttwpNkDIIbYsmTxZOyzIApvsgBnkVkxfTqj3X0xId
 gjSkDKc9ZboueB04bI3YhZH4ib2Likb/Uj+CdFdcxzR9Prc03RbQkOG3yG04rdP5g7fr
 rLlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9dX3mNRNzLNitlpJaUb9RdXCbLhvkMVSJb9ImRyKAlyljPJ9rCWYgzK8cmZvkp2OdGAMP2EClmuUf@nongnu.org
X-Gm-Message-State: AOJu0Yw1VbtXjy5RHUfBGoj1S9w+K4cJVcLthEsxQWxNdTUdN7OkwiZe
 3Ntr3ftmdoZjI6EoUQezHvXXbbGUuUeOfh5KMUNP4flG2ybY4Iqjk0QNEspjHnUf9GYna86xcwC
 6+kc=
X-Gm-Gg: ASbGncsnIiMbF31Pe7CSuKIV5FP93fzzW2P7yqH4LunEXuFPxY/97fZ37ArmrQqPvrc
 Pwj1ZQrdjqJGLo/P0o2V92ydIpedyKQkjxcyqgPB/tcgSd83E9YsLmrH52nTpv+cLbIq2Gyvbgn
 cOY8A6qiPiOvVYZoTKpxt5bFKZ49wwZ3YA0VfgGd1WMx578TM+KX7tNQUdwJtU7ON6sjS47dUS1
 R+qjbCX8i1fr/hOhMFTTTIbymZGoj3hbAyaPbr4fvxaNRkHAkqQq6Q2iuo9HzrhujNo40QoDEcW
 OzZkP/UUwr82KQrnxy9+5QVYcbI4Lz+0I7nGZV+DgvqhOQ==
X-Google-Smtp-Source: AGHT+IEjPyyMaPQ825HdyeWa4d6tcKanBReTF9GbPS2I7K5pqA9oPMN8Amc1TUEqhouLLXg/F8kQpw==
X-Received: by 2002:a05:600c:4511:b0:434:f4f9:8104 with SMTP id
 5b1f17b1804b1-4362aaa4ca1mr50090935e9.33.1734180138053; 
 Sat, 14 Dec 2024 04:42:18 -0800 (PST)
Received: from [192.168.224.213] (196.red-95-127-57.dynamicip.rima-tde.net.
 [95.127.57.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706cb9sm80572945e9.27.2024.12.14.04.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 04:42:16 -0800 (PST)
Message-ID: <48cd4167-c382-450e-a805-da559dd67795@linaro.org>
Date: Sat, 14 Dec 2024 13:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/34] next-cube: map ESCC registers as a subregion of
 the next.scr memory region
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-11-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 12/12/24 12:45, Mark Cave-Ayland wrote:
> Since the ESCC device exists within the memory range of the next.scr memory region, map
> the ESCC device registers as a subregion of the next.scr memory region instead of
> directly to the system address space.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/next-cube.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


