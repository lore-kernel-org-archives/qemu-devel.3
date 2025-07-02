Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6D8C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz5M-0005S9-6o; Wed, 02 Jul 2025 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz5I-0005HT-HY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:09:16 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz5C-0002Bv-PJ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:09:16 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so4897932fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468949; x=1752073749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wyE4TE5vYymeFgJLjj6Ezpl+gTEXeHQxlcSiIX9ywQQ=;
 b=fZ67UbpevG8/lPYKURAR7ijq/UkW31cgj2Lp6AG8c/q7i7FVey84McfRqa9GV1l5hQ
 qlW33jbfqQ7xGdnqtwl8CUOvJO87Y2D4KvS4OgBFlXrq/rQgI/KK6OyLRDg4Is9aUFgz
 XVPG0vlRQ8EiJBz+j/yGkyMpa6pcXx+hD0mf898pH9hntXZjTjC3ZId+Aq2G9iaMlD1c
 5202J3wK1BqypoL9iLXePMyEdqfstllqBHHRRMpQDp/i6Wui/S1GbTMd9wzGr+XGjTgx
 8qevndhbkf7PDINWWkJapWGKykEW3R6joT/Du2ocIRgF0RyfoULqRS1js45on3nrTWAS
 LLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468949; x=1752073749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wyE4TE5vYymeFgJLjj6Ezpl+gTEXeHQxlcSiIX9ywQQ=;
 b=S7yvDm9qQN2VJBcd7KGcdkj0ILrVAczRxY6OlzhwQ85VuieW7/sc/g76GHnzzs9inQ
 BH1RFDj/gUdGf9juNISfmX3hXmI692StKg6XcC1yH19DCiQgMZrvzmJtAPFtP5MfORKX
 LQ2LfbuvJD1N/7Kp39/tlUufjdF0cmoJoaU6vwDa/wxgs8N7Hew/0H444Nv4S5ZIp+yk
 /lgtuRg9cds2ePdaPLyh1Ijs2O7+98mQBSwUOlmn5Ne6zrGHiYni0DWyfTjXC6dWRNL3
 jkThtb4T+yU8ptoDR+JLY+HBfhzkBCBejJNsdtTyx426LhEs0VKi0fHtAtKTVA6exiDe
 vpFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwOI1r6vclnrjrP8QcCjXhFmBvDqAi+I98+jdggJ0owDP72RDaBzqV/l3KCVFmAysvY0hg3KXkaHsn@nongnu.org
X-Gm-Message-State: AOJu0YwI8SaUwsmBbOWNmIQK9j9OPbNOAgEBcoNqA114aRpAeI0euAVG
 H/r/qk/R6mfXil6EN4qD5afjJy2wNe83CPPvSLDJSI2Kt3R4MhkKpWXStR+LQ/u/iEQ=
X-Gm-Gg: ASbGncs5belU/wmE29W41Et8AvVgyZwuSY9KvGqzEualmGhs5cO/kJ3ufQ4kJXGC6C8
 V7oRbm4BR8bKe0OKhAIdKtAbQooqJABXWYFpHhLlXuNbYEnj+X0Y0s1jp1yc4Oe8wpD8As1iSoK
 XEHAUjXkQnQ7d3nNH/rmWThw4vYjNv3ABs9k6nO/TZSIr6JuDoKWCst2myIGxjmjpylHYqbe4Ke
 9x6KC38w0nSUPVCST6nmBnydpQSby2Ta0xMknTmv8ZmXFwVVc3VthQCPH3jT4eOiFXZpZTV/plu
 ZEXlgBFCTCLyJMU6b6XiFpyPeV0PxCCfRJuoVSb+w/+pb5lWC+C4UA7ZB8tslU10496BInhkpt8
 9
X-Google-Smtp-Source: AGHT+IEQXtPZ24v0Wj6BnfMrdJGsXSd3pmtmFVumBBcjpVD1aHT9oTt7y9XH8wECNTL1eTlK1dWj/w==
X-Received: by 2002:a05:6871:cd07:b0:28c:8476:dd76 with SMTP id
 586e51a60fabf-2f5a8b594c2mr2927248fac.29.1751468948767; 
 Wed, 02 Jul 2025 08:09:08 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd5145967sm3843495fac.49.2025.07.02.08.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:09:08 -0700 (PDT)
Message-ID: <ab2349fb-d8b7-4b5e-8610-f2550b840b30@linaro.org>
Date: Wed, 2 Jul 2025 09:09:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/68] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-34-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-34-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/hvf_int.h  |  1 -
>   accel/hvf/hvf-accel-ops.c | 10 +++++-----
>   target/arm/hvf/hvf.c      |  4 ++--
>   target/i386/hvf/hvf.c     |  4 ++--
>   target/i386/hvf/x86hvf.c  |  2 +-
>   5 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

