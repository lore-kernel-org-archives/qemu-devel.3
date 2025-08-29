Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B4DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNi8-0002C9-8b; Sat, 30 Aug 2025 11:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7R1-0000wT-CR
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:19:05 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Qx-0001AO-GT
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:19:01 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so2607410a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756505936; x=1757110736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t3jQQUc01jW0I2l5HvOL4L7fQ2s6GxUPSQM22cp499Y=;
 b=DuWcsEnXgAOYlyh19lMtbgq/r8PeaxMqqDBROyezTKtI2mv75QfAzk+bFoDuWM0/ok
 ShAfAknCIsakZKQfQE4y2WHTfSkQHuxZys37m7XYbyeKCrGGggWwMoQ5tGqynj7hdoJT
 cNBjUghRx07peXieIUkrOZhFJg98erho5cwrCrD9Jx8ci3HXlTGRn1p4i0JremIdZg3p
 rML3CmLP65Q4Fa8rt20vO9K7hSp+3X5P3a5E5vsF4mP9nXAcMOcsnM/DJmiQZz+qZmKc
 Si4y2dB1lOpmp0BxEy2edvWytT2ZwNS/05uVje/ZeGfKQ7mtBGtqWK1SZaJhOVjJMRID
 8DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756505936; x=1757110736;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3jQQUc01jW0I2l5HvOL4L7fQ2s6GxUPSQM22cp499Y=;
 b=XJoQqtmVeEtD5sC4c0HKMzVshPsR6tIabMlSGbcckXUySGjw8lyHnDXpfPd76oH+Oe
 G+gJLWWvQVNCs+nXUylvmZG7Zkj3UWQidt90ZfvB9rW3ydLXF+oFqymqmFmrZ2SWiJqS
 umwbgZEvLPs3BE2yohy/JIxrgCfbo1IJcR6CmP3rspZA9JAfqW0lAHYfbYrRf0ODICh/
 sMmsgBOIv7/P+L+qJIL/rd0r7mbK2xGFTBWb3qn0xfcPDMQXba/3Oh9Ro6+oYnZZRm6A
 EjL4rGtVIc1TQAOz1nfrRsquWxKDv5UGsjeJaIapfF5D9YV9+YI2ctLFNZqEIJGioMqI
 XHUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0gyZsro1V3nMJwwlRF5yqGEDMcsBmm6AMyMJ0y4CdW/h5hhjkNXNApHahzCWD0AnxJorVKYuGGDXQ@nongnu.org
X-Gm-Message-State: AOJu0YxsOal/yvn7ixbauxNdtrdyublX7YpiiPY75lJLbUaxPsQUYjoX
 48zszyiUJf7OCjR+f87F+S78XJtUlSPauIMYc73bKHpwS8O4+Y9qaGxbteiqtEy+B+w=
X-Gm-Gg: ASbGncv6on5hkOU6hbW2ysPzyyx+DjROs9YqVszesh+fSZo5W2wo3OcT11IEN7GJ4Bl
 ahS96feJpVVEnaFN4Z3W44+ursd2M5BGXsowjXMGGM1nlLvV2QYljJVb+lL0/h5E1O5gRPk8MVw
 TPsZT6s4BlXH3xHr4CAMdiKnXxrSy2FyrnHO/UyYRdzdA3u3+woKmKj2u9KtU1xcM29DNpNqBG+
 /KqSyCwq6us5bR1qzmXdZJlFoi2cQKQPn5Ox6mYdDTB1QQcx9BzTCvMdvzp1JgcDrft2BH5I8A3
 nReGhDPyW2XqZCZuewCEGLCKIL0yaO3bGpdjENszuLWD8bycUFWkzxy4rAiA3zuQ1WTe/J8KxRw
 KB3tI/IbsRYwke5XzYzesjQnVs1Ux/T1WeyMBSUlV4UJXjl+3MYVHncwRLMzgY/qr0nUktEL+db
 9mwwLD
X-Google-Smtp-Source: AGHT+IFDw5kqLSmI9qrmgBJ3GGzK5bBsUF/rs1QywPSurSzNW4+gW1wDd3y6M3ZkVTIv0Hj66/bM4Q==
X-Received: by 2002:a17:90b:4c8f:b0:31f:252:e765 with SMTP id
 98e67ed59e1d1-32815437acemr274227a91.6.1756505936316; 
 Fri, 29 Aug 2025 15:18:56 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327976b5074sm3360315a91.4.2025.08.29.15.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 15:18:55 -0700 (PDT)
Message-ID: <56d449f5-3572-4cf8-b875-07a2aaf1f094@linaro.org>
Date: Sat, 30 Aug 2025 08:18:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] target-arm: remove uses of cpu_interrupt() for
 user-mode emulation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829152909.1589668-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 8/30/25 01:28, Paolo Bonzini wrote:
> Arm leaves around some functions that use cpu_interrupt(), even for
> user-mode emulation when the code is unreachable.  Pull out the
> system-mode implementation to a separate file, and add stubs for
> CONFIG_USER_ONLY.
> 
> Cc: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/arm/internals.h |   5 +
>   target/arm/cpu-irq.c   | 381 +++++++++++++++++++++++++++++++++++++++++
>   target/arm/cpu.c       | 370 ---------------------------------------
>   target/arm/el2-stubs.c |  37 ++++
>   target/arm/helper.c    |   4 +
>   target/arm/meson.build |   2 +
>   6 files changed, 429 insertions(+), 370 deletions(-)
>   create mode 100644 target/arm/cpu-irq.c
>   create mode 100644 target/arm/el2-stubs.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

