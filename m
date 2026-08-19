Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169B8C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmmI-0002LT-Bv; Wed, 19 Aug 2026 16:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmmG-0002L6-5j
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:20:48 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmmE-00071j-LK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:20:47 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1115231a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787170845; x=1787775645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P4MpX5czXRSCuBZ6y7s/sbgyOkF952n3pQ6dKhyHeq4=;
 b=Gh3aOCsVjMafqP97P26f8dyGbC8VzEs3SsXrGrQpPaJJJ2pGq1zbC2Tjfkn0k1TxU1
 mNOKTka0bFH4N5qmLMh6JTyR6yx2Vk+xoCgHbnrNqBVsorvXDgymzeGxxeSHZVanONmL
 x0hqRMgzWZyBAWGvC1thZCI8Qmbox1Lj3gBAheMQYQb6FkySvYGCHJM6IcylMr32fr1U
 Z/+UxNZav8VyNF8ivhagsBBvdVG8d/2dUpnqn8lN79XpH1NaJhv6OISrQZeLKMoFykYL
 KEXLu2Jj6FmzY6kJDuqJDYQXyQ5Y0Hg08CaFN1enC7j9vwoV0Qic6G4iLaOJBEXzxhrY
 PLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170845; x=1787775645;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P4MpX5czXRSCuBZ6y7s/sbgyOkF952n3pQ6dKhyHeq4=;
 b=ab6eciQxT8q/9ce9kk0gD8Hx9AaSXPOZMczJY/vxNJw+yLYjCvYhQAU4DWj8b5bu3H
 jyh5Zd1lebuVgwuZ4/kzBWI2EOsasQ9mGXFrVb1MiqkV5+ncHu+T9pw5hvE4cHKlAT9R
 mnq0cBIR3rHQcVfCAnAc44EUiQvdif7wsk2hy8BUaQbvgTTeOQvHOjQkA1DL9qn5kV2p
 4U21tId7QHY/e/F4rUxnkNjW16SOXODZUwJf2m+dP2D8wPVVGyp1EIliX9Et/mgETFVt
 HOH1e8/ukxkPIpoQ6lGFo6qccckpUUCWdk7A5rjE28iFij0yw5JLpDUC8NfnlGkn2RCW
 FOMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTG7ZCDysUGS3yRNiCwyUi8uaTzbVhBYU7SqJN8xZyfuu1arTUv99NeBxqWbnaElKmHiw9bjujIxA0@nongnu.org
X-Gm-Message-State: AOJu0YytkUR9HVcNWzXf6vv1UZrouZiNHIzUXN55zjXU9odkoTZkjZUb
 H/AujGdJBCNbhQdDW3wciLqnwVNxz2W5DV0MLM7TZ+GeGmeLkv5qIdNNh1IqtdQ5n+M=
X-Gm-Gg: AR+sD13UuMimyDd+AQrBKlTpt4p3wLXx9j51w8IUvKH9EYAQ7c9fyxK3mAFUSLyZaMa
 hODxWviaL8gchja7y9RjNmtEGf7izb1xN/76jT1ya5q1Qi0lz3CafMB/FVEoxRGSy+TmKDp9Fxv
 yqM7MB6hbntVDDpydS5Kgjcp+/C1DzcNRhZokjbj+LnXGtBBxvwKX+x5X/xDGxsyRl4nDBN3qrY
 zU789w7oUpxLSzKz8tFW0VDny/WCXSYZ0KKKn+r/BTJDF1EjGODOg3MaWtWsd/W5W6ot4afgI+7
 xZuk6hADOA5ivTNKYHxqWk9r9TknwrcaeD/kxXmCD/4U3kUnI0i4PmgA6pN1j8ZY3jIcYEpvflV
 /CcoxpiLew2rnS0r3GB1wf+wBvpFqpZHAzyOHqCdZlOWE5VUi4siFPVfr5NyzVuwusLv91HgjEX
 UNXYBUF2pssky1TBSEIoJ7K06BtYNC9yLtJMatl76wAKkb42wXcqoxRbGhED8wtgyH3XewKErpt
 PLIkPkWpPGYn254YYB+avHW9tLt60c=
X-Received: by 2002:a05:6a20:72a6:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3cd01247b48mr12292441637.15.1787170845196; 
 Wed, 19 Aug 2026 13:20:45 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc15568c722sm1052733a12.24.2026.08.19.13.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:20:44 -0700 (PDT)
Message-ID: <378d7f90-a180-4205-9ca5-e9a4947ef592@linaro.org>
Date: Wed, 19 Aug 2026 13:20:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] accel/tcg: Remove the now redundant cpu_exec_halt()
 hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-12-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-12-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> Every target setting the cpu_exec_halt callback alias it to
> their cpu_has_work() function, making the callback redundant.
> 
> Call cpu_has_work() directly in accel/tcg/cpu-exec.c
> cpu_has_work_after_processing_async_events() and remove the
> boilerplate cpu_exec_halt hook registration. No functional
> impact expected.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h    | 17 -----------------
>   accel/tcg/cpu-exec.c           | 23 ++++++++---------------
>   target/alpha/cpu.c             |  1 -
>   target/avr/cpu.c               |  1 -
>   target/hexagon/cpu.c           |  1 -
>   target/hppa/cpu.c              |  1 -
>   target/loongarch/tcg/tcg_cpu.c |  1 -
>   target/m68k/cpu.c              |  1 -
>   target/microblaze/cpu.c        |  1 -
>   target/mips/cpu.c              |  1 -
>   target/or1k/cpu.c              |  1 -
>   target/ppc/cpu_init.c          |  1 -
>   target/riscv/tcg/tcg-cpu.c     |  1 -
>   target/rx/cpu.c                |  1 -
>   target/s390x/cpu.c             |  1 -
>   target/sh4/cpu.c               |  1 -
>   target/sparc/cpu.c             |  1 -
>   target/tricore/cpu.c           |  1 -
>   target/xtensa/cpu.c            |  1 -
>   19 files changed, 8 insertions(+), 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

