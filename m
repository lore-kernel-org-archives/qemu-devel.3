Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B404C47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkTn-0005TL-9V; Wed, 24 Jan 2024 16:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkTZ-0005SN-K4
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:08:02 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkTY-0002Yb-3B
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:08:01 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-362a0aa2a33so344205ab.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706130478; x=1706735278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=791cZu6A7Ndii3DHqtHOZ7waa4pX0IAVBgDH47eoipA=;
 b=uXboQP8RIJ+OC/Xiw2pOLAMlhDoHde1jx4Zjx8SvCfECEaTEOZxZjT+02QFNNKOMXO
 I3j9o2WjG7QF5zaq0DhPeu8HFQak2cuVDql3xHuYDo4L93Q+uvx3sfGB1X1hWSGNyWh/
 BQTORWy0TOKW34knDyAVlIUGLRgjcGWTeTSYbMzjvXhJDAljUbHGg1vdWYWydWT4YJ2Z
 2AZ0aANX0oWOD83ia+nmvsotSCQptgaR+PzGKbMfuC1Rs7hyThiVJidYT/cd6SRBZJbe
 7sxQg2fxx2dtOgFdvFOnAQ1uoScfRmhSXU8NVLafG+SPqCH7NYjRFGH6SxbQ9tigj8TX
 WfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130478; x=1706735278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=791cZu6A7Ndii3DHqtHOZ7waa4pX0IAVBgDH47eoipA=;
 b=YHMcctSx895m3b4SDxBe1zH7XhvoHyc0lsWbdrbhCv1qSz+pBnTsjPms5nkYKUCH9Q
 zA6iDo2B6zZW+R+3gg7APCnqiZ9JKVWwqRslgkhd0J4c0wVqnCx8Dw6Z4mSP9kRjTW2Z
 DW8acE8mLTN0TzaD4DPuvvqo7VGO3TxQjOMEC0LDpCC9R9ZnT6bo3qBq/D7kXcWpTazQ
 urOTGBj46xmMhENcHZRciRduvOTEBkWXmmn7/u/szzecfdpSdZ7IHmDKUms1n4128p+Q
 k+uo03pDKjACqmrgvrWK10ov9hnggMyK6ssx17ihAUpEwfu+plOT9+PTEHY41H+01q3N
 0CAQ==
X-Gm-Message-State: AOJu0Yxf9sIPL7sx/N3l46GISo3Btuj5kx0INvYkDJrjBppLZ9+DZwJP
 qKPZZwkdJ7PosmeLIbqiJq4h3T2Lq8iREJwwkQm0qrAxDYW1dW/nduEeHIEBu/Q=
X-Google-Smtp-Source: AGHT+IFIw31Kkj1XJOzcU+Lv2VXEeDyS/hQA5YhsTFmse6PJ76Je7LumbFiKxUN+aDSsTFzWfeuAdw==
X-Received: by 2002:a05:6e02:14c:b0:361:adb5:959f with SMTP id
 j12-20020a056e02014c00b00361adb5959fmr42499ilr.54.1706130478101; 
 Wed, 24 Jan 2024 13:07:58 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a63d90d000000b005ce033f3b54sm12497610pgg.27.2024.01.24.13.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 13:07:57 -0800 (PST)
Message-ID: <af5f319b-cdde-451f-b7cd-0faf4e1b7e12@linaro.org>
Date: Thu, 25 Jan 2024 07:07:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240124075609.14756-1-philmd@linaro.org>
 <20240124075609.14756-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124075609.14756-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 17:56, Philippe Mathieu-Daudé wrote:
> From: Ilya Leoshkevich<iii@linux.ibm.com>
> 
> Preparation for moving perf.c to tcg/.
> 
> This affects only profiling guest code, which has code in a non-0 based
> segment, e.g., 16-bit code, which is not particularly important.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> Message-ID:<20231208003754.3688038-4-iii@linux.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/perf.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

