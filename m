Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94EEC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 06:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujXvK-0004BI-H1; Wed, 06 Aug 2025 02:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXvI-00049i-Rq
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:46:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXvH-0005Bj-6k
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:46:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so5162814f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754462809; x=1755067609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mSQ/Ql+nyu08nemb0aK0h1Pcxhcrx4e1FVO4xBBr8HY=;
 b=m6S5YD1Xqdv1rSrtECHTx+TR+qGClTUOaUiwaFCbo1Ccwxr1EPa/ydOxZbHKo+tIKh
 NSr4z7MIk6O7BYfMLIWJqNDAtqDK/kFTyRUNtfeb0n711Ro7B+xGlvSRQPg1Ucr6pX8i
 ppmlCv7CysXcBdf8elm+tc/P+e6mqpZmhP8V0JNxjNaviZaX9AuZE1eW9+JgwJP9rcUR
 dmepw3fgsfDhWg9QDawteOF4o325XKnAcfXibBj2yUWaiAlmsU16hd1p0JC2A6CdY50F
 jfP/Aggq1vM1duSCRJBE4h1ekzC6MCt5dnLXCjMLobdt7yUb8P9EwjnDCZf6qHEenBiH
 JfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754462809; x=1755067609;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mSQ/Ql+nyu08nemb0aK0h1Pcxhcrx4e1FVO4xBBr8HY=;
 b=W1fYyyTARhR67Dy7NRIalYAa/aKFQu1b8tPJVHFrD37mEkgsbqIwtajzVvNtQlu28a
 hErWcbG1FNipUz3cXdcu0PJcIWFX7ZxdryftAeVkrcJkfdlfDC6FutuBqGt3mT4waCVr
 7lfTZzqnK1bT7GAu6aRSOeaJtW/gGoiMtvMCknN3h4Rf4fhjIvJvHNn4R0g2s438nB88
 b2I+nfx7AVYr/YRgAkXvuUV0ADBjKuh1P5BQbcqjzNTj+mhlPLdk3Qik2hO37PaMylNc
 PlHMTrCbXtAtJfnPuywmbXE8BZF/1JbRLh9GS2nuZCPQaoZar4dvRn8E4HIkZUKeN5j8
 yOHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlUIZbJe/Ck6I4C7SUJ2Ewv2A9TvavMVV8JqIpwfMGEO5ZTy+cYdy/pm757K+vHZbpJpF1JoubDDPE@nongnu.org
X-Gm-Message-State: AOJu0YyFCA8rq7Kw1BCEuuKVUH/iwF/9BmBQqSlpoDUSFWej0rIKRZHs
 T/IvP7eoLOdG4/HHZNbrqhQWhlq7EqdLCS2W20fr6J7kY1FnscEtLDN+teUngVeMHVM=
X-Gm-Gg: ASbGnctgQBsPpwxmNA47u4Lrx68EjXux2XLO029BkGE1V04RFNuzJRAY4FRUVRX6z6v
 iuePApm2++6MQPZ7DhvomQeCQ260P3Q8KyhigWFtnIuTvrarMsUbP5r7LijJHmKIKMYXA0aAgtu
 6jJXODqo47uIxIpOe6P2md0JgbsyyG55bMjsStMloNU+yRGWtnM3chQtWFAfMEX5YAgIGNPIU9a
 NzsSu7y4qC5BVPiN8JlOLKS6oePcOuV6kCxBBH0G5X67BodZ0Vatapf55ZD44J0B8uHJeQoM41w
 sVlKRoZ9KHIEx17qx6sE8Kb2NoyWjlQiiK18oipRtp0zxoBH19t2GnrO/MwgIQcTXGgailyzIEE
 L3GoQ3dYYosZMJgu4vL4EOpvxPsRzG1Ghys7zv0MuzXLpNy5caTxseoe3J7VcyVD/7w==
X-Google-Smtp-Source: AGHT+IGscfMQAQLSwo3iWN8cAs5OyDhjrCjJvvXT7POG2BG2H4VqiMeXMc7Gvtzwy+eCPUJitw8E+g==
X-Received: by 2002:a05:6000:22c6:b0:3b7:8832:fde5 with SMTP id
 ffacd0b85a97d-3b8f48ec1d5mr1062821f8f.13.1754462809147; 
 Tue, 05 Aug 2025 23:46:49 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e583f9fcsm33081485e9.4.2025.08.05.23.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 23:46:48 -0700 (PDT)
Message-ID: <6f7a0534-3e78-426a-8c9c-1a8f9ff395b6@linaro.org>
Date: Wed, 6 Aug 2025 08:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tracetool: drop the probe "__nocheck__" wrapping
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250805200334.629493-1-berrange@redhat.com>
 <20250805200334.629493-7-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250805200334.629493-7-berrange@redhat.com>
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

On 5/8/25 22:03, Daniel P. Berrangé wrote:
> Every generated inline probe function is wrapped with a
> trivial caller that has a hard-coded condition test:
> 
>    static inline void _nocheck__trace_test_wibble(void * context, int value)
>    {
>        tracepoint(qemu, test_wibble, context, value);
>    }
> 
>    static inline void trace_test_wibble(void * context, int value)
>    {
>      if (true) {
>          _nocheck__trace_test_wibble(context, value);
>      }
>    }
> 
> This was introduced for TCG probes back in
> 
>    864a2178: trace: [tcg] Do not generate TCG code to trace dynamically-disabled events
> 
> but is obsolete since
> 
>    126d4123 tracing: excise the tcg related from tracetool
> 
> This commit removes the wrapping such that we have
> 
>    static inline void trace_test_wibble(void * context, int value)
>    {
>        tracepoint(qemu, test_wibble, context, value);
>    }
> 
> The default build of qemu-system-x86_64 on Fedora with the
> 'log' backend, has its size reduced by 1 MB
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/tracetool/__init__.py |  1 -
>   scripts/tracetool/format/h.py | 16 +---------------
>   tests/tracetool/dtrace.h      | 18 ++----------------
>   tests/tracetool/ftrace.h      | 24 +++++-------------------
>   tests/tracetool/log.h         | 24 +++++-------------------
>   tests/tracetool/simple.h      | 18 ++----------------
>   tests/tracetool/syslog.h      | 24 +++++-------------------
>   tests/tracetool/ust.h         | 18 ++----------------
>   8 files changed, 22 insertions(+), 121 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


