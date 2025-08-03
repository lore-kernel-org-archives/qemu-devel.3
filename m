Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2260C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiN64-0005rL-17; Sat, 02 Aug 2025 21:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN60-0005kS-2B
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:01:04 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN5x-00082C-8J
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:01:03 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-741ad8d0c15so216621a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754182859; x=1754787659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQ5GLEVb3TgfrxH1moI6F4NRxqoWMHrn2u0F7wxROh0=;
 b=Su4QJV3BM7qJfpGT4Wm+N6SH5q2f650kdCH6ouYtnW1SjgyhYEh6mNbBCPnUS/nzWh
 siaVH7mvGb6+XtMEdrVRadOeisIndJqM+zuWfLXaXBSac7zDpGwH60xO7cuXpJwcKRtb
 wyUkIm1m+TYsVagRTZtjcZpehA+CxsZGYQKwm+VPxjGfnTa7vWHHirHtVPyIBmkXZj4w
 BdLBzapq2DDqmFqHMCw3i/2tsDugrIXWzG2hZXtGj+jUD+ZjF4sDTUgvKp+Sf46NLM9U
 B+kYvTxSoPmKcqBTNw6mBBlYYi8dS+KvkzZLCUUzlkcaU268ltZ2qKv94UEIZJmEeDeq
 OWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754182859; x=1754787659;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQ5GLEVb3TgfrxH1moI6F4NRxqoWMHrn2u0F7wxROh0=;
 b=vjEnbSXikziyqQmr97c8SPyi4bEMUdEDNpJhkPBTv2OenlsWSQA1FAFaK1p2feFi4d
 VO3ZrQ1cSrKjXnvL8kiqsYjRuqvopddx0EQtPNh5sIDb8RchVpfyXGGCZ4rAPA36HI5i
 mqcxgXN/JcxROr7dIa0uPM2hG3m9XIzYpjpJdSU/uYNF7SnuWp2flhckgpxeDieZzAab
 kPUGf/DYEXAPapcBrLjBB6HTq4dq6l4pKo7KksE4dZ1QwWW6j7wT7T/dupIRknp0TeDR
 yWBYB/+uH55RsytICzRmzSXyrSN4Dj/MMYOFvDbWuYx2/Pn9HPlQ0nHohTaAqA44s55d
 Llug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO1ukwUM+ZOd0yTUZnZIjMw/Vb+IiGvAJtPTPzHGcdm56/BgeXiwPeBOw+5JcQieWEPo8GbQpdXW49@nongnu.org
X-Gm-Message-State: AOJu0YxCff+q+d2ULLr8rolR8o2Q3scDjrirK7pRkFbpdiL1jHEvJ/Cp
 4wDVDdHYN8wXLGvLflI43kxW7hJHVAqyfuvitWcfo/+yrGdsTW3qkkdYhj8fahEG29w=
X-Gm-Gg: ASbGnctXUW9uzI7CiS6HFExGuPhFMSkTlOsXEUYl638doxnQj6F9tvrg47T04FcTJXo
 LRU6LLWqySPKtEQB43PPGP7frXFF9NekeScBvw8XcH2BKkynsOniI+QmNkzaOLp/MSWt6RhORTi
 l4pdtpdkn8f9POn1LITOLwNIKWX8Xgzcm3YVHx1K6JeEjmN1MyEf9Do+Aw7x06caEMoOJVaevp8
 zTvYj2jBu53JXojP2mEtktM7gnRbYw8xB2we+ORtyfLvU3B2i1pa/7Q7sVk5Z7e02GefNPvs1pn
 0ZSPX11GZvRWyjYFbHGgc+UPoZHI8D3gyRh7zxRMzJ4HbMcaaBpTUC+PKWZMG21Cf1NRR5TaMpS
 UIaxL522mJaDWiYDkos7rbo4oeu+Z2ZngdeV4hdZtZ3z1x7ytQcaIw55JsneqOPN1
X-Google-Smtp-Source: AGHT+IEkZtR0FVqIeuW0Qe64iVPXc0oX04axWYZiql329KxZJeQPYqaxKHEp0UHKI9YNXlbZZ4hTAw==
X-Received: by 2002:a05:6830:7188:b0:73e:643f:5b29 with SMTP id
 46e09a7af769-7419d0bab27mr2611174a34.3.1754182859351; 
 Sat, 02 Aug 2025 18:00:59 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186dace17sm1511622a34.38.2025.08.02.18.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 18:00:59 -0700 (PDT)
Message-ID: <db6c8b4f-027a-460d-902a-33536b1123cc@linaro.org>
Date: Sun, 3 Aug 2025 11:00:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] whpx: arm64: clamp down IPA size
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-12-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-12-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> +++ b/include/hw/boards.h
> @@ -276,6 +276,7 @@ struct MachineClass {
>       void (*wakeup)(MachineState *state);
>       int (*kvm_type)(MachineState *machine, const char *arg);
>       int (*hvf_get_physical_address_range)(MachineState *machine);
> +    int (*whpx_get_physical_address_range)(MachineState *machine);

We need to generalize this to an accelerator hook, so that there's one code path for both 
hvf and whpx.  And kvm, for that matter, though it's less obvious how that's handled.


r~

