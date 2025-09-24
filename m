Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169C0CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 03:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1G9Q-0003oU-9A; Tue, 23 Sep 2025 23:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G9O-0003oA-FO
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:26:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G9F-00024c-Sk
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:26:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so3130608f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 20:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758684386; x=1759289186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lFWmLhJxelSKefaPFx7G66Qkm8U/sh1IdlhduMVcPoY=;
 b=utyuFmrPhDj670KUDkE/04P8oyfjc3ePJHQePoU56ZNl1A1dV9sXlAQMoNMy3HeXmG
 xMx/1hWOzPnVEKOov9M3A7cJbJV5vWHZznDiJgJ0WiCAOoJj9yaJShUXdlV27MP0wB2b
 d6ZTV4Nwts9GLFdpRhvc5w5p7k8iPVXBlNfxWrhr/afWa0s1zEo8PjQR3PjD83z011tA
 6bWtHTO6i2PQPVjMLNvPfDFoLRLlQSN2DRHagZA/GceECCg+IM3TSIaC7n8Rn6anlEnq
 zJyb8LtDkWlvrbY5JgJg2zUWmnR6BwAu/uPFAdNP5/ilUWTuNAxW4m6R5ar7DPpTgRH1
 FJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758684386; x=1759289186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lFWmLhJxelSKefaPFx7G66Qkm8U/sh1IdlhduMVcPoY=;
 b=NJmCdULyO/2m/aqnCg8kf56JG5eCG1DFAnWC8k6j6tFNKqpyfc0i4rcn9jMpsHKTrL
 XaZMNGaRR8jmI7QNB1XBFZhLVRggGG3dgwZbCqWKqiDYqkUwyNfj5g/+10Th5E6XyRu8
 GXVH5tchVpxrUh3SSKxD/+eQ4G2TZ+TnY45stsven4inUhNJkzVq1bnrCiDZ+WPofH9s
 NTt6zDF95NX74URn4hcE9iU6fa2pbeczoBShyScRcvNC9xxgJyK7K7qNWJfmgKOKxPGx
 j++0pAp5/LfI/S2R9negypekxTuBNxOgxjfdZo7N82WUB7z0jhL7Mb8KPiTzzj5ccjDR
 AOiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc68wva2Skq4U0yFnbvsR15KyOKirnxU6QKeFmnU0SyVrQ6IqS6uWrfXNhy++uIthRdqIVevmubCZS@nongnu.org
X-Gm-Message-State: AOJu0YzA+NSG9eriIIebEM3MIfxkIfDiTM5Beml6kV9L+pb0wN9BZQJM
 O9uNlu2bscCOZBgyXpSnEZXUYPa4Jkjo22q2d7XkJiwtJrdkB8ibIVSp/K3hMPn2X1o=
X-Gm-Gg: ASbGncsUf+L2QhlCE636XLqJCLjm6W7UauA7nxDQ7s+AzsSd0WlyyaAvm6wOADzUpGY
 /7Q2z0cJW8XjRC2gcjS901s84JdRA17D34y7hNAlEmEg+x1Em+DIyUNiBzQPeg6LKGaFMcEakbZ
 D29TzegwI4FnXrcdlh7F45rrrL0tq/YEdzupu//VLuapYEBuq9QlaTew0cOvQfjEiKiQTNhY/5f
 E4LfMPWWprrDEEUcdeCIefnFbk8WxGzU07l81B2FfBQF+V5WBiMiR22clu7UE5lv0N9N5TGL8v9
 kIhYm69z1gIi/fIy4Zj6D8Mps8ujpONR0mSTYdYB3izxf8bwjErGFH/rwWBQQgOSjxSCvSfqsu6
 N1iAOYC188e34/G4c+sJ1QKEptVpaAaewTCE4Zf2lyNvKAgz15LUa1L4HjeUlUVj57A==
X-Google-Smtp-Source: AGHT+IGczWbQlTJfnHYOy1q1S53mpomYWglUfpyQ6jKwM1WjbGSBlTcd8KMQPTj958qYDEy9+HHp6w==
X-Received: by 2002:a05:6000:40cb:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-405c73c4504mr4582003f8f.24.1758684386527; 
 Tue, 23 Sep 2025 20:26:26 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07411f4dsm25880820f8f.26.2025.09.23.20.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 20:26:25 -0700 (PDT)
Message-ID: <54d12265-0bfd-4ab8-a5b8-20ed34374fba@linaro.org>
Date: Wed, 24 Sep 2025 05:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] accel/tcg: Create queue_tb_flush from tb_flush
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
 <20250923215425.3685950-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923215425.3685950-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 23/9/25 23:54, Richard Henderson wrote:
> Rename the function and remove the path which
> performs the flush immediately.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tb-flush.h   | 17 ++++++-----------
>   accel/tcg/tb-maint.c      | 11 +++--------
>   accel/tcg/translate-all.c |  2 +-
>   3 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
> index 090ffc8818..e971d4ba6d 100644
> --- a/include/exec/tb-flush.h
> +++ b/include/exec/tb-flush.h
> @@ -24,19 +24,14 @@
>   void tb_flush__exclusive_or_serial(void);
>   
>   /**
> - * tb_flush() - flush all translation blocks
> - * @cs: CPUState (must be valid, but treated as anonymous pointer)
> + * queue_tb_flush() - add flush to the cpu work queue
> + * @cs: CPUState
>    *
> - * Used to flush all the translation blocks in the system. Sometimes
> - * it is simpler to flush everything than work out which individual
> - * translations are now invalid and ensure they are not called
> - * anymore.
> - *
> - * tb_flush() takes care of running the flush in an exclusive context
> - * if it is not already running in one. This means no guest code will
> - * run until this complete.
> + * Flush all translation blocks the next time @cs processes the work queue.
> + * This should generally be followed by cpu_loop_exit(), so that the work
> + * queue is processed promptly.
>    */
> -void tb_flush(CPUState *cs);
> +void queue_tb_flush(CPUState *cs);
>   
>   void tcg_flush_jmp_cache(CPUState *cs);

Preferably rename as tcg_queue_tb_flush(), regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


