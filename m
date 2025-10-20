Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D4CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 06:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAj30-0007P5-P1; Mon, 20 Oct 2025 02:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAj2z-0007OV-2I
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:07:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAj2s-0002ji-Cz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:07:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso17338365e9.3
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 23:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760940415; x=1761545215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qlUtH9IPp3sHC1doAZ3214Uh+yQkI1bpAbLemOW71rw=;
 b=M1JjVOKSyOnFJDg7rjmZhEoYG1WeuVFudZRajpR4ExMEpiwnKeWAaFpy8LkgOv2Q3f
 AJoDibR0YWfreQMDQw23wUIYJZ/NwOKFHcJJujZe96U08+m4naGIeIxApHuxnrhWZ8rO
 1ohz3ZJV7mhV3DiSq5Z8Wyn8GAjWHDb2Lu8Bwd6Ptgs93tDqpQKxDPeO8TgBMXIdJ5QA
 zPnUFbwWu3NnAK/Kie5rgQrn6soj7B0hOFpzhCGjrceeCOUWKgajsOSGvq99yleuCM1L
 vYVknnKgVCzH1uzPmvE3sLcBbV1xTFNw/JFe2KzQExgleosbbrOmCfl86cuLB75U4+D0
 8MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760940415; x=1761545215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qlUtH9IPp3sHC1doAZ3214Uh+yQkI1bpAbLemOW71rw=;
 b=DNZgzJF6PybX3UXlc4hS8HJjwN1J0h0AKM6uSKFS6mmSUPEBVz3vKFuLzv9wE5PmrR
 oEmI4czOq/RAtFqimzx9xZt5fEdiqxiHWOV/a3xFxz0HaCJm9P/MQWk7cIJ3WvsKJXQ/
 pgC4kz6Zr8nCnOUPJDm6BZ4aW2yyWileirV1hH2ct7bS0KKx4RzdKWwLxU/MX54+iMVr
 61UwGzWMZDTwi0rIZ6gblzatbGf4F05AGhTevGQMeDd1orgsosseDFqQOvMfEkSbt5vl
 s21KjkR0wQd7DzI++SNkdj3CaLGMo8T2XiOEHSU73UkRL7AvH8TKqK9dWaYHpQ12+HK5
 /uWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFp9PVIDW1/IJLLHDnTMO9kqtPs6SJ1e9d6lZ2dGfpNYQg35jzZ/85fBVBG5LUJP1flRxFL5YlmlyD@nongnu.org
X-Gm-Message-State: AOJu0YyYtHOeH4XeyP6PgQWPHm8f2NysIcdn3A4DsrmCPttYTPlyQC3b
 HhRx+jelt/b4IMBXlKMwBD3RUPNsc/kr8LcAX1gryEDZS2VszzYcJ3Ox4q+1jkoLCUg=
X-Gm-Gg: ASbGncsQjiUWZ/eMJIRiJJ2m3+lm8yPdFmhyQpU4fAL3SEFktPjOPYuri8TIxhF14m/
 ImmuJwy3oN1JPCmLP+ePh3MrFRmL2lqumrZKKEyswk53FJyrJQBqn5/cTexkeiSCGYtmMkyRNAw
 Wx7bzeVRWJT7hw4s8FuMWiZrmPB+qpdkerjpbpT+UfhBKAxpY+It4iks/y3sNwNN51TPspJCsVl
 QQy/tHP+gKKLNxXNVjWScbHhwnoM5HPiqs0GrgVUPmtkv05NRGsa1oWfeE1XmZwQosW1jJ0v/nP
 6pumxQmvv8LK+BtWyWBczPzhbfUsgOiro9cmRql5zz5odP68avhYfEY5IijnmQW5qH6RAgNDCZq
 2atnZk/G9S7k6nVfsP1splJb8F3orTggAAnjPKOP71NVL+0LGReR58HT+tv2YzV9AHnCIFsp/2W
 IwxSM5i+j4XrHPxQa+JJKfj37Z0i4x0wkZmQBaD6b6Pk4=
X-Google-Smtp-Source: AGHT+IGIzaGVQ+2Sqqly0gl7oT9KK5YNtQmqRqHgen6/+1ZKol+zTGnyfJtb+/jrTxyd7S4zLal29Q==
X-Received: by 2002:a05:600c:470d:b0:471:7c8:ddf7 with SMTP id
 5b1f17b1804b1-471178a7447mr74887475e9.14.1760940414968; 
 Sun, 19 Oct 2025 23:06:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c34sm224569535e9.10.2025.10.19.23.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 23:06:54 -0700 (PDT)
Message-ID: <0ed67f0b-60ef-4ed6-82a8-2a56c7966dea@linaro.org>
Date: Mon, 20 Oct 2025 08:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
 <20251019210303.104718-5-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 19/10/25 23:02, Bernhard Beschow wrote:
> Avoids the error-prone repetition of the array size.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/rtc/mc146818rtc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


