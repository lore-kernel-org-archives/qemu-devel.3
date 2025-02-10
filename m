Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F998C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thY7n-0005EO-Bq; Mon, 10 Feb 2025 13:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thY74-00055x-OS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:02:31 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thY72-0007ew-Re
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:02:30 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f710c17baso36313785ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739210546; x=1739815346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GXLzL+fxgCYHVIBiRMynIEKruG/VmjYHXCYabfpGc00=;
 b=g4Vxy8QXhb0qKUpmjPANAMAh6uH3JD9K9aiUHN1tC86JWHYCs6V1/e5qMvykqhR+Hq
 ZYYwnEgsZitWTq2p+01kztJBpqi5eCXP/IthdBzoy9CV82TXMcnyRfJmdafAP5+zWbf3
 3xB7tHeYcLXp+1suP+OTmXJy4Yroda+kV2CBDROv6tgJlxQn0YEcv+PfZNhbCooPXOVI
 oprGyIASFHyIzpa8fa0L7L11opipQeHkz1oPjB4LV/Skwh6TTdggLczccGDtsWvVSulZ
 boIM9t4sODIebcfagfB8Y5MqOBo2tavGFSzB7jKrLuGSgpNzxBUTvgLwBzjjtx9hlLlq
 MO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739210546; x=1739815346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GXLzL+fxgCYHVIBiRMynIEKruG/VmjYHXCYabfpGc00=;
 b=bkawFBDWBSJ9Rhbkx4r7HuTx9wFEBiFpmk4b16IbxdjQatdA8ALIO2quqIF4nDqzNt
 lKTaJe543mnpx0FclF8zAt3S+x1S7whW6JzhKnuSXc19eX1/VSa8m11Ccd9hp468SnK8
 hvyznYSXG0a4xIB5bP57TgMqPvcmmJRSu+uWjGSk30wIY5ew6CCP39cLzDG30J3YKeIk
 /JOzPdD6IjM+rprs3pYWYivaRovDejllfnv15w0OlIdn5R5mXXVIafVkD/8tpfLBXEQt
 OqwPPI8x2uQ8YUw6N76hxPSEjHBxY4cwX2rdMUeslZWxqAzgf3fR0vQUAU2ccUKhJJiw
 uGFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEc8BIEPoaj3Wl7OfkAt3UfRP1x21O66gtDzUQ04SEzV4SvQsaDA/x9y4P9fGzbWxqxNK6jXCNRo7s@nongnu.org
X-Gm-Message-State: AOJu0YxfeW6s33t0Nnx0+IBtX+fIz5Tuc+UyNaZ8ZFbGwxPXdMOF3nAe
 FoRL0tu+ynQ/fNgtZlD3Embq2gpuDBoxFqJQdK6pFAqQT4JShFT8zwRn8CpMfYI=
X-Gm-Gg: ASbGncvnGmRTrGisrVgkLtpR/PssZRryHYaxvvsxmUSG4x/EA/EDKvEGLEaLt3BZmsj
 UQyIF4WUNZB4mZHm9mP6NReshpoUi2vE7NxuDn74gmvPmRbTXe/bX+73azSSN/ugm95uWX8RCkf
 4MxIWLgqfFENipi9p6My4wBR8Aqe1r1ENMPDcgKwS9XT+9L+iNXtgMPfk/IRh5OBG5Sygh/ddNw
 wLrlAaDNl8xr1RQ3AH37+q7ZxwVMPOIDj3sV/G5z932yg/KsqLjuvcUi8N2Ea05HQyhFwfnKYAM
 OqcO9kQOJMxOVf9lydvI3KBYaP7/6jnhPx5+bfGnP3a4iP5E/KnIoBo=
X-Google-Smtp-Source: AGHT+IEd2NFCN5lxQ1Ydu2zrNS1t9mrOr0B7GW1RNTOlqmArWB4iZmXspJXFR+qCbaew3lRBfbAs2w==
X-Received: by 2002:a17:902:db0b:b0:216:7d22:f69 with SMTP id
 d9443c01a7336-21f4e7799abmr248557505ad.50.1739210545155; 
 Mon, 10 Feb 2025 10:02:25 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3650e6b5sm82210785ad.46.2025.02.10.10.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 10:02:24 -0800 (PST)
Message-ID: <5a6db5e2-d551-4f83-a181-d900b68e4f6f@linaro.org>
Date: Mon, 10 Feb 2025 10:02:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
 <CAFEAcA97TpSfRVpNOg025GMw3pduR+73gr2LDmncoCpTDfV3jg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA97TpSfRVpNOg025GMw3pduR+73gr2LDmncoCpTDfV3jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/10/25 06:08, Peter Maydell wrote:
> On Mon, 10 Feb 2025 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Currently we call icount_start_warp_timer() from timerlist_rearm().
>> This produces incorrect behaviour, because timerlist_rearm() is
>> called, for instance, when a timer callback modifies its timer.  We
>> cannot decide here to warp the timer forwards to the next timer
>> deadline merely because all_cpu_threads_idle() is true, because the
>> timer callback we were called from (or some other callback later in
>> the list of callbacks being invoked) may be about to raise a CPU
>> interrupt and move a CPU from idle to ready.5A
> 
> (oops, stray editor damage "5A" at end of line)
> 
>>
>> The only valid place to choose to warp the timer forward is from the
>> main loop, when we know we have no outstanding IO or timer callbacks
>> that might be about to wake up a CPU.
> 
> This raises actually another question: should the call to
> icount_start_warp_timer() in main_loop_wait() maybe go after
> qemu_clock_run_all_timers() rather than before? (Haven't tested
> whether that breaks anything ;-))

It seems likely.  :-)


r~

