Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D5CCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwUy-0005Yl-80; Thu, 23 Oct 2025 10:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwUr-0005X9-SS
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:40:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwUo-0003Cn-Km
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:40:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-427015003eeso882834f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761230452; x=1761835252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IbKgAE2uNrIDuHHlNskaqajnAfIjgweZ0iP6Yko2TDY=;
 b=Gg5Zzo9JaCVp3ND7ucOi8NZJjqYxWzdqfqh8OHCzJHQFxQdJHV66Ezw/jwqIUqNIjp
 /QScWF1IZQ5eWkTMRdxCrXGlXe6miXEO9ixCEy2G8w93ixVtuIzhhDO4A+4T6V6W4mLb
 NzZj67P/UDJcAbAuvMKPacisdNflewslm5XXRN8JEC7iTxoRcfkbVzcpQE58owCrMti4
 EY1STYUbT8hm1ETwM73zs+blJn+bQuSzZklPrL30gIYSQxaOaADp0AbQ8T6NcA4Y2apk
 ryl6y7JaOyrGUOPd/B8EuNj3UBjoYjSgnug/VlGTXX0vBXcLRZBeQJhGA95YxSIb5mlf
 Qxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761230452; x=1761835252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IbKgAE2uNrIDuHHlNskaqajnAfIjgweZ0iP6Yko2TDY=;
 b=Nzr5kzidUn/YUG1XRPTEYTeJUsA2LLsnaoVz7zOg/S88eOXTASYaYAn3vsqAWPgylD
 mPHZ2iua5JQSKEHkRnNoR4V6D4vLfK5m4ur68WjwXeXLBVCHp++LQWCWbKqHO5/d2phk
 qr/+Kz90koXJU4itZ0j9FTnCr0//2e+4kgrfBqzNTw8n7qbD6aFcIswND5CHAidi8sfh
 Fbe8h7mtgGmxg2Qtp/oD4LufogXcjhlDqP56zG5flq8tcK4iDsaOoBQDY7speo7uMhKi
 8DtgYA4f04SjjiQQ02DPLCn0/goJDg8wHytVST0xBMgxNl7sbNqseBLgbSNfj85/EYYi
 YyGQ==
X-Gm-Message-State: AOJu0Yy4s0xaPs/uBjxJUFE1V4mEk/L0HHMAAiMeHaRk2Z0pwdp6XxK5
 iKckW2bnmaAkz4+hkDPiAc1zsggW8yObrwTgOndFE1o4jjKT6h7VxHvKO7XAAVewktVCK1Jni2D
 rUrgRHXs=
X-Gm-Gg: ASbGncsw8gWhCjfHzhSlhLxPsvjAPeCduCrme4TQzaB7EYzcvEKO2HKP1TVhyTxcZWN
 EvCvXBLXKAAB7RXnkV+DbyV8RP9SKNrrC1B+tEx4k1rR1bs0tTWaj8ZX4m0Rsy3QpGomo78iMs/
 p/Ykp+0idbeCj+9p2HuAkN/sMhg93eu5Y1kZZuGwhy6w3ICd9uO0DlRGxy5PLJCIdHlvULjx3ZF
 Zbo6Mx+8XqpCqQ+pbRGyNh8eulxeI6RXvvXLvtTmyQjCDTQ8Rcc1CxfkzrBvnsQevjXSXB0ltbB
 EuqrgU3TWyZkFdklP2c5viiMOBEqmThZaun/FAJnKXOTEjbzWl/PXkx8hAaZebacRQgi6rSRE65
 nYu7suG41gJcwjBoy+mtICYgoWHgzvumm8qdMrrhwTHobE54dbEov9+xMZ5gv4NCU/gLKkt+Q0g
 myyzrmXCnAcW7pAOZXdnpOasAzi1T71OmzwBg93qZ+YVsAEPYCoJdyAA==
X-Google-Smtp-Source: AGHT+IEY4i3PZU6v2r3M8iTnFgj7CVpgKsLHcKK90UVPqV005BQxg6bl1pBn8xvzJUPDkJ5f7DhsEA==
X-Received: by 2002:a5d:5f48:0:b0:426:ff2f:9c15 with SMTP id
 ffacd0b85a97d-42704d83d04mr19381137f8f.5.1761230452107; 
 Thu, 23 Oct 2025 07:40:52 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897ff371sm4330603f8f.21.2025.10.23.07.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:40:51 -0700 (PDT)
Message-ID: <89e1f33a-2d3a-46dc-aeeb-b14f169d6b7a@linaro.org>
Date: Thu, 23 Oct 2025 16:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/58] accel/hvf: Simplify hvf_log_*
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023115311.6944-8-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023115311.6944-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 23/10/25 13:52, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Rely on the AddressSpace and MemoryRegion structures
> rather than hvf_slot.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h |  3 ---
>   accel/hvf/hvf-all.c      | 40 ++++++++++------------------------------
>   2 files changed, 10 insertions(+), 33 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

