Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97251C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiqi-0008UO-8D; Tue, 16 Apr 2024 09:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwiqg-0008Sy-7C
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:27:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwiqe-00050G-M4
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:27:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3465921600dso3913928f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713274063; x=1713878863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=71c8OjkgCUu4ZSWRvMisJgjPpiIGyKO/sFHZngoHC0M=;
 b=dCknoSluz8NS0e7JFgn0K1Xh2PshsJJIm6XfJIMD6rjvGIvUqKia+/o/n2TQOEHy3x
 zCORAxrcMfSf6VYXvfUBppjpk0z360OMJ/CDVg5+1aw1Im1+B9OxsKo0wkOJv2sc7tk/
 RRNF0A/1MscoOvXNi/O8eHsWQgxONhiZJzWQLPDfqFJxIx+gOMDQ2Not0IsyNThmP2xQ
 2STERVz13/iAmXY1YYENNpPMKPo+wYj+WlJEJISVy+vcRadbyJoQ1Z+jQ/2A/ZS4akpA
 IkZ7qGQaVhsYh2PeXkXGouUYmP/O3uHO69XEkUeBds7nxLF19Ba5YF7o+LLA1HLWXgkR
 94IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713274063; x=1713878863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=71c8OjkgCUu4ZSWRvMisJgjPpiIGyKO/sFHZngoHC0M=;
 b=PgshOiy8F3TONxhtdNDjwoZfrBDx9otQ8iFyJx2yu2wydZyy+DRe4m4SpDcwt46Cer
 HwxIuFmYvMq9QlvA29E6OQoqs/R3YQzTvb4VMLKcEUsNjQugvZS0vumHjFiDR3ytmkrh
 cIZ2IZ9Ptf++A7Onp5McOZ/gC7Ya/qXSSvpSrzzXEN3vZ+kK5UYs3v874xi7rX9BVP5n
 HFGRQajFifEtqbYxPzh5P8CQdzW0Bnj6nx4g04MlkwT+HW4TI1KN2jT4x8vqA7eTIB83
 Blynfb9qVHng5HT2YaWct7ajc+oUtKVqlJ533Ioim2qIHqKx5h1sWjnfFYwx+Yi3YeHS
 FkDA==
X-Gm-Message-State: AOJu0YzeZwkAxeKCqBQ1YQSZB5J9HerKRdBXUfHvRsE6uD53ZIrspOR+
 H8p71ml/W83RoFw8576Cajo8LT0Z4E81TUR2hSDAMo9a98f1XjdRt3mlDtkjt0i0F6tAlj1JLXB
 B
X-Google-Smtp-Source: AGHT+IEx3JNEgoaShj8aRfTLRoMrCLD5yzuDa6ZnO0ahe98z9ikYfkr64szIP7s+ZO6HghdpssVqQQ==
X-Received: by 2002:a05:6000:d82:b0:33e:69a8:fe85 with SMTP id
 dv2-20020a0560000d8200b0033e69a8fe85mr8337230wrb.37.1713274062709; 
 Tue, 16 Apr 2024 06:27:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a5d4808000000b0034599eca6c9sm14793467wrq.41.2024.04.16.06.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:27:42 -0700 (PDT)
Message-ID: <a9aa4a44-df6c-4f3f-8f64-f901ab2d89e4@linaro.org>
Date: Tue, 16 Apr 2024 15:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 0/3] exec: Rename NEED_CPU_H ->
 COMPILING_PER_TARGET
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240322161439.6448-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322161439.6448-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/3/24 17:14, Philippe Mathieu-Daudé wrote:

> 'NEED_CPU_H' guard target-specific code.
> Clarify by renaming as COMPILING_PER_TARGET.
> 
> Philippe Mathieu-Daudé (3):
>    gdbstub: Simplify #ifdef'ry in helpers.h
>    hw/core: Remove check on NEED_CPU_H in tcg-cpu-ops.h
>    exec: Rename NEED_CPU_H -> COMPILING_PER_TARGET

Series queued via hw-misc tree, thanks.

