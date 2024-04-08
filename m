Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FE1C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsLK-00075A-Vb; Mon, 08 Apr 2024 12:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsLI-00074f-NR
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:59:36 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsLG-0004Am-TJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:59:36 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so3330138a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712595573; x=1713200373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fnZbzvru+To56jPUz3h45PGs4276zn11uljr4gddnFU=;
 b=kGiKCI4ve9XhRYiAbomruXnKuZ0Cre1HRAyd+SjfVWZCqMpn/Htsfz/tKd2nAcsdQU
 yS5oEL0l4joDux1r7kJtuIqy1Jwj2iFBxbdy2nw6hwUwselEjOilg/ovynrVU5n5Ag3A
 LPZYDZrQC/2XzcmOSleKC6tQFe1J2IE/Qexp4KWYuvRJAYY/PUun9r91ubelLYIHqWgV
 2u4qR2WLI3bKIwKHePPhKfr4jeBkbbpUWZMA7yUp6ickwP7CLVIcsX7EauPoRze4x9uS
 OV0ebn1QTaw1e3mg+/l9KtOZ3rsNkRv3aCMmSO6xMyrhOB/+LbudbRj4wImBYfVFshDf
 pq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712595573; x=1713200373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnZbzvru+To56jPUz3h45PGs4276zn11uljr4gddnFU=;
 b=B/fzEl6QK4LuOBL7ojP5GWZLehgdjw2fnJpJkUDN2xGCticsnmY7Zyy0jA2j1tzaSN
 av2pNSACDTSV0ojCLMHA4bCB8K7M5KCNUh/RNgo8404Op547p2tTk6otU23k7BJzI+UI
 duV/m0Ngr88MXrN2vS4RwVP8fAu8LTdJy3P9zBmBWMgs3LoLUTMr/M/rHJtWBIfpY1os
 jvnViBFzCCF7Z1jax0SNC2nKlkEns29yM06wlXGTVPhhSgFVHNd2/AP5jTXWu/5E+/tR
 GxF2N1nuGIJdXdEh7XX9lJ8mBbUjMzt84Yfhg+kYMoF/WlMiFJEI6hUgvIMZ/vo3+YnN
 TeuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTO/HVea0uqQsc55DpCud4LPoykTx4kBoJJzp/OziCldQaZRBPgpf8kMMLh68xsPoETiqi6RdC5/7VTGb50IcaYsjgn9s=
X-Gm-Message-State: AOJu0YzfEOncxkO4/pYpphYOrJjBCwWOjv8SbzqU02D6JGsIZY0wHgMs
 zCSARIHU2km8dYVq+pf7vqdiyN4HmL+vpxlpXx+qzS0BT+vVXhgE1CELzas8sB8=
X-Google-Smtp-Source: AGHT+IFu5VXbt5lrhNWcrn4uooZM1sH0evJ8bqELvdVa0mOnFNZZbWVE4XzzeLUkoIx2fOdPN09CTQ==
X-Received: by 2002:a17:90a:6448:b0:2a0:36fb:5cc2 with SMTP id
 y8-20020a17090a644800b002a036fb5cc2mr7412244pjm.14.1712595572994; 
 Mon, 08 Apr 2024 09:59:32 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a17090ac25200b002a219f8079fsm6673527pjx.33.2024.04.08.09.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:59:32 -0700 (PDT)
Message-ID: <c47df7e1-e6f1-4170-a024-045eae850c3e@linaro.org>
Date: Mon, 8 Apr 2024 06:59:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/18] stubs: split record/replay stubs further
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-17-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> replay.c symbols are only needed by user mode emulation, with the
> exception of replay_mode that is needed by both user mode emulation
> (by way of qemu_guest_getrandom) and block layer tools (by way of
> util/qemu-timer.c).
> 
> Since it is needed by libqemuutil rather than specific files that
> are part of the tools and emulators, split the replay_mode stub
> into its own file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   stubs/replay-mode.c | 4 ++++
>   stubs/replay.c      | 2 --
>   stubs/meson.build   | 1 +
>   3 files changed, 5 insertions(+), 2 deletions(-)
>   create mode 100644 stubs/replay-mode.c

I don't see how this helps.

With qemu_guest_getrandom you still pull in replay_read_random and replay_save_random. 
With timerlist_run_timers you still pull in replay_checkpoint.

So both stubs files are still used in the same cases.


r~


