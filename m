Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BA3CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 22:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSxB-00030H-0e; Tue, 19 May 2026 18:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSx8-0002zB-V5
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:30:18 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSx5-0004Uq-Tk
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:30:17 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso2910376a91.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779229814; x=1779834614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=76cNQ7FxFaNbgbuThrohuuCani+bJHSS6LyJjU7TcQg=;
 b=Axl5HriG0bm9+kNCWIRBvNuHzkeOgig1/rnqEVVLS3leAjrj2kFfifzdGbZa/2IkIf
 7Ro9DZVLde8yT4EwIwAFC6jFeY5bKtMqQwSCEJG/bs5gK6bwByObp0YuCYP0WXNqtx1W
 sa3gidfNoco2cnyXqdN75YdY4si+xMEkcE0e1wBIt1zAL/pnOm+j0/jVQSzBH1dE1a51
 al9uQ4igyz5tnlNWxOOpYi9+kOfqHM5NOuw9douViFjcgwO8ioihhjBxwPCEVfcOyAcd
 gGewWjvGtNbTIM+aNIr6WHrQtEtxYuG18rHKuBJa1qHjA/zWm5gnkFzp3gf1FxtyaXBi
 N3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779229814; x=1779834614;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76cNQ7FxFaNbgbuThrohuuCani+bJHSS6LyJjU7TcQg=;
 b=WZccqAVVI/84KHt8NfpI96uSiSEn8irY7ZZh6qkrMXmROyjaoQ+nqIuWTNxZ8DkiRi
 7KjnbBIBLLHpikVGdbHTUANlO3DmS4nKFuZ0hUX5xSQ2HKctGMLgkcfKRToD5qZqp1cN
 y62vcCNuygCR2o9/vkGKOhIy5spztCO/Jd0sDe/oWI+gS5mWhvsnFJC93nfr9ykVxNhq
 cbBhHKQRlxOuHcGc6700+MrmdIub+FvFU4v0sCLoJRqqxHKQ4jXcxFk6HYmmqRwraY4d
 Rqq8URE+ulJE+KfwjvZwIb2Mzl557JCMfipmtIT/DvckgJ7psxWpArDTGEjUkN8AOlDn
 5TOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vO+64tMAG09wSB0VENXoVxToeIQnrXBlfPiCyMNZc+JCDxDryUO/HKJ/yr7oNCUcxq9AydYURfPDe@nongnu.org
X-Gm-Message-State: AOJu0YxBvl3vFBJcpUDl6gHQ2P1LAzvC5zWQ9MH/tWgNXQ35srqjsm4E
 9b4miuuAnd8G1TlU/vtIhEtgkccN5c/qLkVABPFLibwmkBNk8aDXzGfrJQoCzY/R8ecnf5GHBR2
 4ZYqaHN8=
X-Gm-Gg: Acq92OEEeePQeYZ9rkxXeNK9QwHeUWjOjtdTMvgOWBSlRa0po+UH+HtIzNOM9//GcQy
 iB0kpH6HNXV8KoWtm9VTKZaE+TdwqsGD2XVeeRMNZUwIHhda62xE2sH8x9wpFcbMwUqFaXTKQVK
 qOz+Nb7pf+0fJHFpP8WZ04ukziSf0rrcKnCYpjDwdeOamg1xIMmf56C+aXXClrbjn/mx+wVqZOp
 JxjRjqG5qVLMklOSRQKF5GMqWG9BKVvGjKUo5RTu55y8jZk1rkgxJlR+Otb/zChBiFVXHSo9qts
 O9Z29wEc/uKN/XxSVQwOUdLfRJU5nKVJh15kVHityIRD+WYW3w/UTbVlNCwd7VZlOtcBiuS31xR
 6gEeioXTWCBqRbcebfUaISllu0UKK3i8edhr+8DMQ1RM45zD1CzmkKcU/MfeFnjTRMgaFg1qK8F
 27s5cPQWpn7CGS41Nwx5t4BUyn68b+uhuLTTlJSQPJnQ9xh6M=
X-Received: by 2002:a17:90b:4a42:b0:368:3830:a8bd with SMTP id
 98e67ed59e1d1-3692345e3eamr23302200a91.7.1779229814332; 
 Tue, 19 May 2026 15:30:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951434eafsm15379339a91.10.2026.05.19.15.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 15:30:13 -0700 (PDT)
Message-ID: <83b11621-e445-4b54-afa3-1b19004b022d@linaro.org>
Date: Tue, 19 May 2026 15:30:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] buildsys: Stop checking for ESA/390 host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
References: <20260519171240.97420-1-philmd@linaro.org>
 <20260519171240.97420-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519171240.97420-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 5/19/26 10:12, Philippe Mathieu-Daudé wrote:
> We still build QEMU tools on 32-bit hosts (see commit
> cf634dfcd8f), however no OS supported by QEMU still runs
> on ESA/390 (Linux dropped support in release 4.1 in 2015).
> 
> Remove the configure check, directly checking for the 64-bit
> z/Architecture.
> 
> Also per commit 3704993f545 from 2020:
> 
>    "we don't support s390, only 64-bit s390x hosts".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configure                 | 12 ++----------
>   include/qemu/cacheflush.h |  2 +-
>   include/qemu/timer.h      |  2 +-
>   block/file-posix.c        |  2 +-
>   disas/disas-host.c        |  2 +-
>   util/cacheflush.c         |  2 +-
>   6 files changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

