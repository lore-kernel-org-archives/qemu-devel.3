Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533B2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeLH-0003Km-Bb; Tue, 16 Jul 2024 05:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTeLF-0003IO-TX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:19:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTeLE-0003qt-Ba
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:19:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367ab50a07aso3313461f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721121562; x=1721726362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HCwG4y9RfylQmlQ9XAEiDhPnOMthCInzLc5NEQS7oxY=;
 b=agCjEZvXt2V33wQFut//+SMQCG7bMqJ3KKWWsYumeVhWuni1lsyUyf8ERY5zLHJDTy
 TzJ0vzg0lXIxbS92UmkfpDW6nmnfoMPDu4k+LnG+iRBIDgmqn6ZZMrcICP+i3sFyYPLQ
 rI9RoX4iAtgtYFCwQgZ55FvEl62chimjiPveTUStonktIqvidOGt4fmhmWrRUjKgsb6m
 XPg1ZhL65WYY5iEWihco+upTqNWtvHlF1FzkcGHR2ohV8C1R5uCSKY0nG1Y/J6ZzqXGQ
 PCLgLtYMISF8aI8A1dQQKFC+ad9JQBXpqOtCXR2tZrWZev2LAX7zDnLUtEvWTZtwcpQu
 tCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721121562; x=1721726362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HCwG4y9RfylQmlQ9XAEiDhPnOMthCInzLc5NEQS7oxY=;
 b=aoSjWdWSxNcPvXOmvQ/KEeDV/zHrqZT1Fq0rywwWpvrQyGlDp9SId0NkG/AYgJzFwx
 dXoGbW7FhViUndAKPBEC8OlTIO1UP7XaomTbsuv+lVBPzKeIQxVtgNM+1Oj6MUykTTDa
 ZGbwlJLQFz/jHQfZFIqeQOi7DdPzNie4hP56J1juBVlcudhz5QkkSrP+ANhoPeZbY1is
 2fSe46hwoWZJBC2aPZ/nZEWRsb38swZaKXaq2IRvAN/GsT5STVNdVtCqBWJrRgc1s+eO
 vZl3Ena5gyqJZpRYg66YLiLVZdA3E52wJCF9ujfUSy/u+RnDdUASQdw47IN6ZM+CRYJV
 ivIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Hm5yiMp0edclyox2J5XPuetYxpir0sm3K9i9coGp0dRzX05p0+gWkC7r0XyCUmyuUKguD+YBMEYYrSYyUIZ4PczpAyg=
X-Gm-Message-State: AOJu0YwWNTcp9ZgDLsJEDZSzxcg720Fn9C3e/owpuC0z6EOdVcCptkz7
 o5tC4nnWNCBNpXAbxu8RrYXVWYZ/0X4hMUPlaH589gneH6XddGo7SjO/ATRiiz0=
X-Google-Smtp-Source: AGHT+IHQQCGHWb0tVPOJFNgT4QVaj7AoigdHomsGm8sHFJSwrT7GUHGIItLW9bF+/GymOFBLt7CKkA==
X-Received: by 2002:a5d:4204:0:b0:366:ecd1:2f38 with SMTP id
 ffacd0b85a97d-36825f7476bmr877035f8f.7.1721121562296; 
 Tue, 16 Jul 2024 02:19:22 -0700 (PDT)
Received: from [192.168.86.175] (233.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3cb0sm8387945f8f.10.2024.07.16.02.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:19:21 -0700 (PDT)
Message-ID: <b6fa54fc-bba9-4f0a-9fd6-f3bc62eaa1ac@linaro.org>
Date: Tue, 16 Jul 2024 11:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/arm: Always add pmu property
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-4-f3e3e4b2d3d5@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240716-pmu-v2-4-f3e3e4b2d3d5@daynix.com>
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

On 16/7/24 10:28, Akihiko Odaki wrote:
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property too.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/arm/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


